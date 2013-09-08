class VideoController < ApplicationController
	def index
		@videos = Video.all
	end

	def uploadForm
		@uvideo = Video.new
	end	

	def upload
		@uvideo = Video.new	
		@uvideo.name = params[:name]
		@uvideo.message = params[:message]
		@uvideo.user_id = session[:user_id]
		@uvideo.state =  Video::UNPROCESSED
		uploaded_io = params[:file]
		path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)

		File.open(path, 'wb:ASCII-8BIT') do |file|
			file.write(uploaded_io.read)
		end
	
		uploadPath = "public/uploads/" + File.absolute_path(path).split('public/uploads/')[1]
		@uvideo.file = uploadPath

		suffix = File.absolute_path(path).split(".")[1]
		target_filename = File.basename(path, suffix) + "mp4"
		destPath = "public/mp4/" + target_filename
		@uvideo.target_file = destPath
		Rails.root.join('public', 'mp4', target_filename)

		@uvideo.save
		redirect_to '/'
	end
end
