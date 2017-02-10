class Beer < ActiveRecord::Base
	include AverageRating	
	belongs_to :brewery
	validates :name, presence: true
	validates :style, presence: true
	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user
	def to_s
		"#{self.name}, #{self.brewery.name}"
	end
end


