class User < ApplicationRecord
	include AverageRating
	validates :username, 
				length: { minimum: 3, 
					      maximum: 30 }, 
				uniqueness: true
	validates :password, 
				:presence => { :on => :create },
				:confirmation => true,
				:format => { 
					:with => /((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{4,})/i, 
					:on => :create, message: 
						"must be at least 4 characters long, include at least one uppercase letter and one number." }
	validates :password_confirmation, 
				:presence => true, 
				:if => '!password.nil?'
	has_many :ratings
	has_many :memberships
	has_many :beers, through: :ratings
	has_many :beer_clubs, through: :memberships
	has_secure_password
end
