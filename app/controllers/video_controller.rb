class VideoController < ApplicationController
  def index
  	@video= Video.all
  end
end
