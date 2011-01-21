class UsersController < ApplicationController

  before_filter :create_times, :only => [:index, :create]

  def create_times
    @times = ["12:00 am"].concat(\
              (1..11).map{ |t| t.to_s + ":00 am" }.concat( \
                ["12:00 pm"].concat(
                  (1..11).map{|t| t.to_s + ":00 pm"}
                )
              )
            )
  end

  def index
    response.headers['Cache-Control'] = 'public, max-age=300' 
    @user = User.new
  end

  def thank
    response.headers['Cache-Control'] = 'public, max-age=300' 

  end


  def search
    GeoPlanet.appid = YAHOO_APP_ID
    all_results = GeoPlanet::Place.search(params[:location])
    @geo_result = all_results ? all_results.first : nil
    respond_to do |format|
      format.json {render :json => @geo_result}
    end
  end # search
  

  def create
    @user = User.new(params[:user])

    if @user.save
      ReminderMailer.send_confirmation(@user).deliver
      redirect_to :action => :thank
    else
      render :action => :index
    end
  end

  def confirm
    @user = User.find_by_id(params[:id])
    if @user and @user.confirm_guid == params[:guid]
      @user.confirmed = true
      @user.save!
    else
      flash[:error] = "That doesn't seem to be the correct link to confirm, please try again"
      redirect_to :action => :index
    end
  end # confirm

  def cancel
    @user = User.find_by_id(params[:id])
    if @user and @user.confirm_guid == params[:guid]
      @user.destroy
    else
      flash[:error] = "That doesn't seem to be the correct link to cancel, please try again"
      redirect_to :action => :index
    end
  end # cancel
  
  


end
