class Venue < ActiveRecord::Base
    has_many :gigs 
    has_many :musicians, through: :gigs

    def self.find_venue
        Venue.find_by(name: name)
    end

    def list_gigs 
        puts "Here are the gigs for #{self.name}:"
        gig_names = self.gigs.map do |gig| 
            {name: gig.name, value: self.id}
        end 
    end
   
end