require 'dalli'

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
    session[:user_id] = @user.id
    options = { :namespace => "videomarketing", :compress => true }
    dc = Dalli::Client.new('videomarketing.ofcogu.0001.use1.cache.amazonaws.com:11211', options)
    dc.set('user_id' + @user.id, @user.id)
    redirect_to '/'
  end

  def logout
    options = { :namespace => "videomarketing", :compress => true }
    dc = Dalli::Client.new('videomarketing.ofcogu.0001.use1.cache.amazonaws.com:11211', options)
    dc.delete('user_id' + session[:user_id])
    session[:user_id] = nil
    
    redirect_to '/'
  end

  def videos
    @videos = Video.all
  end

end
