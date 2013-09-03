class User < ActiveRecord::Base
	attr_accessible :name, :lastName, :email, :password

end
