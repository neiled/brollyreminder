class UsersController < ApplicationController

  def index
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    @user.save
    render :action => :index
  end


end
