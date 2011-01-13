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
      ReminderMailer.send_confirmation(@user).deliver
      redirect_to :action => :thank
    else
      render :action => :index
    end
  end

  def confirm
    @user = User.find_by_id(params[:id])
    if @user.confirm_guid == params[:guid]
      @user.confirmed = true
      @user.save!
    else
      flash[:error] = "That doesn't seem to be the correct link to confirm, please try again"
      redirect_to :action => :index
    end
  end # confirm
  


end
