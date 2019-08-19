class Venue < ActiveRecord::Base

    has_many :gigs 
    has_many :musicians, through: :gigs
   
end