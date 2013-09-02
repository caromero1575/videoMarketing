require "rubygems"
require "ffmpeg"
include FFMpeg

class Video < ActiveRecord::Base
	attr_accessible :name, :message, :file, :state

	UNPROCESSED = 0
  	PROCESSED = 1

	after_save :convert_video

	def convert_video
		self.delay.convertToMP4
	end

	def convertToMP4

    convert self.file, :to => :mp4 do
	    video_codec "libx264"
	    audio_codec "aac"
	    strictness "experimental"
	    overwrite_existing_file
    end.run
	
	end

end
