class UsersController < ApplicationController

  def index
    @user = User.new
    @times = ["12:00 am"].concat(\
              (1..11).map{ |t| t.to_s + ":00 am" }.concat( \
                ["12:00 pm"].concat(
                  (1..11).map{|t| t.to_s + ":00 pm"}
                )
              )
            )
  end

  def thank

  end

  def create
    @user = User.new(params[:user])

    if @user.save
      ReminderMailer.send_confirmation(@user)
      redirect_to :action => :thank
    else
      render :action => :index
    end
  end

  def confirm
    @users = User.find_by_id(params[:id]) & User.find_by_confirm_guid(params[:guid])
    @user = @users.first
    @user.confirmed = true
    @user.save!
  end # confirm
  


end
