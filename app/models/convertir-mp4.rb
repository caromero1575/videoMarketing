#!/usr/bin/env ruby

require "rubygems"
require "ffmpeg"
include FFMpeg

convert ARGV[0], :to => :mp4 do
	video_codec "libx264"
	audio_codec "aac"
	strictness "experimental"
	overwrite_existing_file
end.run
