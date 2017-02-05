class User < ApplicationRecord
	include AverageRating
	has_many :ratings
end
