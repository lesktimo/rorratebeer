class Rating < ActiveRecord::Base
    validates :score, numericality: { greater_than_or_equal_to: 1,
    								  less_than_or_equal_to: 50,
    								  only_integer: true }
    belongs_to :beer, required: false
    belongs_to :user, required: false
    def to_s
        "#{self.beer.name} #{self.score}"
    end    
end
