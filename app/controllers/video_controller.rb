class VideoController < ApplicationController
  	
  	def index
  		
  		@video= Video.all

  	end

 	def uploadForm
		@uvideo= Video.new
	end	

	def upload
		
		@uvideo= Video.new	
    	@uvideo.name = params[:name]
    	@uvideo.message = params[:message]	
    	uploaded_io = params[:file]
    	path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    	File.open(path, 'wb:ASCII-8BIT') do |file|
      		file.write(uploaded_io.read)
    	end

    	realPath = File.absolute_path(path).split('public/')[1]
    	@uvideo.file = realPath
    	@uvideo.save
    	redirect_to '/'
	end

end
