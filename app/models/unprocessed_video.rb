class UnprocessedVideo < ActiveRecord::Base
	attr_accessible :name, :message, :file
end
