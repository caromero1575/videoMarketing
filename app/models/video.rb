class Video < ActiveRecord::Base

	attr_accessible :name, :message, :file, :target_file, :user_id, :state

	UNPROCESSED = 0
  	PROCESSED = 1

	after_save :convert_video

	def convert_video
		self.delay.convertMP4
	end

	def convertMP4
		self.extend FFMpeg
		puts self.file.split(".")[0] + ".mp4"
		execute_command "ffmpeg -y -i " + self.file + " -strict experimental " + self.target_file
		self.state = PROCESSED
		#self.save
	end

end
