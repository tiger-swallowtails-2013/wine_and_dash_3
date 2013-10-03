class User < ActiveRecord::Base
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :username, uniqueness: true
	validates :password, presence: true


	# scope a
	# attr_reader :username
	def self.authenticate(username,password)
		return false unless user = User.where(username: username, password: password).first else return user
	end
end