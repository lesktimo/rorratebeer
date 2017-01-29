module AverageRating
    extend ActiveSupport::Concern

    def average_rating
        ratings.inject(0.0){|sum, n| sum + n.score} / ratings.count
    end
end        