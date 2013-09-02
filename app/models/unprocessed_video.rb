require "rubygems"
require "ffmpeg"
include FFMpeg

class UnprocessedVideo < ActiveRecord::Base
	attr_accessible :name, :message, :file
	
	def convertToMP4
    convert self.file, :to => :mp4 do
	    video_codec "libx264"
	    audio_codec "aac"
	    strictness "experimental"
	    overwrite_existing_file
    end.run
	end
end