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
    
end
