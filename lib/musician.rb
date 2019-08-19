class Musician < ActiveRecord::Base

    has_many :gigs 
    has_many :venues, through: :gigs 
    
end