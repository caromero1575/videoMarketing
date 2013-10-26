class Video
	include Dynamoid::Document

	table :name => :videos, :key => :id, :read_capacity => 1, :write_capacity => 1

	field :name
	field :message
	field :file
	field :target_file
	field :state, :integer
	field :user_id

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

		ses = AWS::SimpleEmailService.new()
		email = User.find_by_id(session[:user_id]).email
		identity = ses.identities.verify(email)
		if (identity.verified?)
			ses.send_email(
			:subject => 'Video Marketing video conversion complete',
			:from => 'noreply@videomarketing.uniandes.edu.co',
			:to => email,
			:body_text => 'Your video ' + self.name + ' has been converted and is now available.')
		end
	end

	def uploadS3(path)
		key = File.basename(path)
                AWS::S3.new.buckets['cloud-videoMarketing'].objects[key].write(:file => path, :acl => :public_read)
	end

	def downloadS3(videofile)
		open("public/uploads/" + videofile, 'w+b') do |file|
			key = File.basename(videofile)
                	AWS::S3.new.buckets['cloud-videoMarketing'].objects[key].read do |chunk|
				file.write(chunk)
			end
		end
	end
end
