class User < ApplicationRecord
	include AverageRating
	validates :username, length: { minimum: 3, 
								   maximum: 30 }, 
						 uniqueness: true
	has_many :ratings
end
