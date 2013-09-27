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
		downloadS3(File.basename(self.file))
		execute_command "ffmpeg -y -i " + self.file + " -strict experimental " + self.target_file
		uploadS3(self.target_file)
		self.state = PROCESSED
		self.save
	end

	def uploadS3(path)
                AWS::S3::S3Object.store(
                        File.basename(path),
                        File.open(path),
                        "cloud-videoMarketing",
                        :content_type => "application/octet-stream"
                )
	end

	def downloadS3(videofile)
		#puts "videofile: " + videofile
		open(videofile, 'w+b') do |file|
			AWS::S3::S3Object.stream(videofile, 'cloud-videoMarketing') do |chunk|
				file.write chunk
			end
		end
	end
end
