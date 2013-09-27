class Video < ActiveRecord::Base

	attr_accessible :name, :message, :file, :target_file, :user_id, :state

	UNPROCESSED = 0
	PROCESSED = 1

	after_save :convert_video

	def convert_video
		if(self.state == UNPROCESSED)
			self.delay.convertMP4
		end
	end

	def convertMP4
		puts self.file.split(".")[0] + ".mp4"
		self.extend FFMpeg
		execute_command "ffmpeg -y -i " + self.file + " -strict experimental " + self.target_file
		self.state = PROCESSED
		self.save
	end

end
