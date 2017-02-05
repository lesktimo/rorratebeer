class User < ApplicationRecord
	include AverageRating
	validates :username, length: { minimum: 3, 
								   maximum: 30 }, 
						 uniqueness: true
	has_many :ratings
	has_many :memberships
	has_many :beers, through: :ratings
	has_many :beer_clubs, through: :memberships
end
