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
end