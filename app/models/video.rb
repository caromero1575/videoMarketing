
class Video < ActiveRecord::Base


  attr_accessible :name, :message, :file, :user_id, :state



	UNPROCESSED = 0
  	PROCESSED = 1

	after_save :convert_video

	def convert_video
		self.convertMP4
  end

	def convertMP4
    self.extend FFMpeg
    puts self.file.split(".")[0]+".mp4"
    execute_command "ffmpeg -i public/"+self.file+" public/"+self.file.split(".")[0]+".mp4"

  end
end
