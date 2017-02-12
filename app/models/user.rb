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
	has_many :ratings, dependent: :destroy
	has_many :memberships, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :beer_clubs, through: :memberships 
	has_secure_password

	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
	end

	def favorite_style
    	return nil if ratings.empty?
    	styles = ratings.map{ |r| r.beer.style }.uniq
    	styles.sort_by { |style| -style_ratings(style) }.first
  	end

  	def favorite_brewery
    	return nil if ratings.empty?
    	breweries = ratings.map{ |r| r.beer.brewery }.uniq
    	breweries.sort_by { |brewery| -brewery_ratings(brewery) }.first
  	end

	def style_ratings(style)
    	style_ratings = ratings.find_all { |r| r.beer.style == style }
    	style_ratings.map(&:score).inject(&:+).to_f / style_ratings.count
  	end

	def brewery_ratings(brewery)
    	brewery_ratings = ratings.find_all { |r| r.beer.brewery == brewery }
    	brewery_ratings.map(&:score).inject(&:+).to_f / brewery_ratings.count
  end
end
