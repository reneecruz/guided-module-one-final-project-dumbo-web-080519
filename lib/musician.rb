class Musician < ActiveRecord::Base
    has_many :gigs 
    has_many :venues, through: :gigs 

    def self.handle_returning_musician 
        puts "Welcome back! What's your name?"
        name = gets.chomp 
        Musician.find_by(name: name)
    end 

    def self.handle_new_musician 
        puts "Glad to have you here! Let's get you set up! What is your name, musician?"
        name = gets.chomp 
        Musician.create(name: name)
    end

    def list_gigs 
        puts "Here are the gigs for #{self.name}:"
        gig_names = self.gigs.map do |gig| 
            {name: gig.name, value: gig.id}
        end
        choice = TTY::Prompt.new.select("Select gigs for more details:", gig_names)
    end 

    def display_gigs
       self.gigs.each do |gig|
        puts "#{self.name} is playing a gig as #{gig.name} at the venue #{gig.venue.name}"
       end
      end


    # def list_gigs 
    #     puts "Here are the gigs for #{self.name}:"
    #     gig_names = self.gigs.map do |gig| 
    #         {name: self.name, value: self.id}
    #     end 

    def create_a_gig 
        puts "What's the name of your gig?"
        gig_name = gets.chomp
        puts "What's the venue of your gig?"
        gig_venue = gets.chomp 
        puts "What's the description for your gig?"
        gig_description = gets.chomp 
        find_gig_venue = Venue.find_by(name: gig_venue)

        new_gig = Gig.create(name: gig_name, venue_id: find_gig_venue.id, musician_id: self.id, description: gig_description)
        puts "You've successfully created a new gig for #{self.name} named #{new_gig.name} at #{new_gig.venue.name} with the following description: #{new_gig.description}."
        
    end


   
end