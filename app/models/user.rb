class User < ActiveRecord::Base
  before_create :set_woeid, :set_time, :set_confirm_guid

  scope :confirmed, where(:confirmed => true)

  validates_presence_of :email_address, :location_string

  attr_accessor :time

  def set_woeid
    GeoPlanet.appid = YAHOO_APP_ID
    p = GeoPlanet::Place.search(self.location_string).first
    self.woeid = p.woeid
  end # set_woeid

  def set_time
    Time.zone = self.time_zone_string
    Chronic.time_class = Time.zone
    parsed_time = Chronic.parse(self.time)
    self.seconds_since_midnight = parsed_time.getgm.seconds_since_midnight
  end # set_time

  def set_confirm_guid
    self.confirm_guid = UUIDTools::UUID.random_create.to_s
  end # set_confirm_guid
  
  

  def self.to_check_before(time_to_check)   
    where("users.seconds_since_midnight < ?", \
          time_to_check.seconds_since_midnight)  
  end  

  def self.check_weather_and_email_users
    #Time.now needs to be in the users time zone for checking
    users = User.confirmed & User.to_check_before(Time.now.getgm)
    users.each { |u|
      client = YahooWeather::Client.new
      #could cache the responses rather than checking every woeideid?
      weather_response = client.lookup_by_woeid(u.woeid)
      if RAINING_CODES.include?(weather_response.condition.code) or true
        ReminderMailer.send_reminder(u).deliver
      end
    }
  end # check_weather_and_email_users
  
   
end
