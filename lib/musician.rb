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
        puts "What's the Venue where your gig is taking place?"
        gig_venue = gets.chomp
        gig_venue = Venue.new(name: gig_venue)
        Gig.create(musician_id: self, name: gig_name, venue: gig_venue)
        puts "Success! You've created a new gig for #{gig_name} at #{gig_venue.name}!" 
    end

    def update_a_gig
        prompt.select("Which gig would you like update?") do |menu|

        end
    end

    def update_musician_account
        self.update(name: update_name)
        self.update(bio: update_bio)
        self.update(website_url: update_url)
        self.update(instrument: instrument)
    end

    def delete_a_gig 
        puts "What's the name of your gig?"
        gig_name = gets.chomp
        puts "What's the Venue where your gig is taking place?"
        gig_venue = gets.chomp
        gig_to_destroy = Gig.find_by(name: gig_name, venue_id: gig_venue)
        gig_to_destroy.destroy
        puts "Success! You've deleted a gig for #{gig_name} at #{gig_venue.name}!" 
    end

    def list_venues 
        puts "#{self.name} has gigs at these venues:"
        venue_names = self.gigs.map do |gig| 
            {name: gig.venue.name, value: gig.id}
        end
        choice = TTY::Prompt.new.select("Select venues for more details:", venue_names)
    end


   
end