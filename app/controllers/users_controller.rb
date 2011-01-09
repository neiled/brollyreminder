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

  def create
    @user = User.new(params[:user])

    @user.save
    redirect_to :action => :index
  end


end
