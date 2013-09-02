class UserController < ApplicationController
  def signup
  	@user= User.new
  end

  def create
  	@user = User.new(params[:user])
      if @user.save
        redirect_to '/'
      else
        render 'signup'
      end
  end

  def loginForm
    @user = User.new
  end

  def login
    @user = User.find_by_email(params[:email])
    puts @user
    session[:user_id] = @user.id
    redirect_to '/'
  end
end