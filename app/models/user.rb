class User < ActiveRecord::Base
  before_create :set_woeid

  scope :confirmed, where(:confirmed => true)

  attr_accessor :time

  def set_woeid
    GeoPlanet.appid = YAHOO_APP_ID
    p = GeoPlanet::Place.search(self.location_string).first

    self.woeid = p.woeid
    
  end # set_woeid

  def self.to_check_before(time_to_check)   
    where("users.seconds_since_midnight < ?", time_to_check.seconds_since_midnight)  
  end  

  def self.check_weather_and_email_users
    users = User.confirmed & User.to_check_before(Time.now)
    users.each { |u|
      client = YahooWeather::Client.new
      #could cache the responses rather than checking every woeideid?
      weather_response = client.lookup_by_woeid(u.woeid)
      if RAINING_CODES.include?(weather_response.condition.code) or true
        ReminderMailer.send_reminder(u)
      end
    }
  end # check_weather_and_email_users
  
   
end
