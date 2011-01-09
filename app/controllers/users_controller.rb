class UsersController < ApplicationController

  def index
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    @user.save
    render :action => :index
  end

  def check_weather_and_email_users
    users = User.confirmed & User.to_check_before(Time.now)
    users.each { |u|
      client = YahooWeather::Client.new
      weather_response = client.lookup_by_woeid(u.woeid)
      if RAINING_CODES.include?(weather_response.condition.code)
        
      end
    }
  end # check_weather_and_email_users
  

end
