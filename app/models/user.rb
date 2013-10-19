class User
	include Dynamoid::Document

	table :name => :users, :key => :id, :read_capacity => 1, :write_capacity => 1

	field :name
	field :lastName
	field :email
	field :password

	has_many :videos
end
