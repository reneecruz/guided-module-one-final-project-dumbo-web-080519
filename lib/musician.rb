class Musician < ActiveRecord::Base
    has_many :gigs 
    has_many :venues, through: :gigs 

    def self.handle_returning_musician 
        system "clear"
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
        answer =  TTY::Prompt.new.multi_select("Select gigs for more details:", gig_names)
       
    end 

    def display_gigs
        if self.gigs == nil 
            puts "Sorry, you don't have any gigs listed right now!"
        else
            self.gigs.each do |gig|
            puts "#{self.name} is playing a gig as #{gig.name} at the venue #{gig.venue.name}."
            end
        end
    end

    def create_a_gig 
        puts "What's the name of your gig?"
        gig_name = gets.chomp
        puts "What's the venue of your gig?"
        gig_venue = gets.chomp 
        find_gig_venue = Venue.find_by(name: gig_venue)
            if find_gig_venue == nil
            create_gig_venue = Venue.create(name: gig_venue)
            new_venue = create_gig_venue.name
            find_gig_venue = Venue.find_by(name: new_venue)
            end

        puts "What's the description for your gig?"
        gig_description = gets.chomp 

        new_gig = Gig.create(name: gig_name, venue_id: find_gig_venue.id, musician_id: self.id, description: gig_description)
        puts "You've successfully created a new gig for #{self.name} named #{new_gig.name} at #{new_gig.venue.name} with the following description: #{new_gig.description}."
    end

    def update_musician_bio 
        puts "Here's your current Musician Bio: #{self.bio}"
        puts "Please enter your updated Musician Bio:"
        updated_bio = gets.chomp
        updated_bio = self.update(bio: updated_bio)
        puts "Alright! Here's your updated Musician Bio: #{self.bio}"
    end

    def find_gig_by_id
        puts "Which gig would you like to update?"
        self.gigs.each do |gig| 
            puts "#{gig.id}. #{gig.name}"
        end
        gig_to_update = gets.chomp
        find_gig_to_update = Gig.find_by(id: gig_to_update)
    end

    def update_gig
        gig_to_update = find_gig_by_id
        puts "What would you like to update for this gig? Name, Description or Venue?"
        answer = gets.chomp.downcase
        case answer
        when "name"
            puts "This is your current name: #{gig_to_update.name}"
            puts "Please enter your updated name."
            updated_name = gets.chomp 
            gig_to_update.update(name: updated_name)
            puts "Success! You've updated your gig name to #{gig_to_update.name}"
        when "description"
            puts "This is your current Gig Description: #{gig_to_update.description}"
            puts "Please enter your updated description."
            updated_description = gets.chomp 
            gig_to_update.update(description: updated_description)
            puts "Success! You've updated your gig description to #{gig_to_update.description}"
        when "venue"
            puts "This is your current gig venue: #{gig_to_update.venue.name}"
            puts "Please enter your updated venue name." 
            updated_venue_name = gets.chomp 

            find_gig_venue = Venue.find_by(name: updated_venue_name)
            if find_gig_venue == nil
            create_gig_venue = Venue.create(name: updated_venue_name)
            new_venue = create_gig_venue.name
            find_gig_venue = Venue.find_by(name: new_venue)
            end

            new_venue = Venue.find_by(name: updated_venue_name)

            gig_to_update.update(venue_id: new_venue.id)
            
            # gig_to_update.update(venue_id: updated_venue_name)
            # updated_venue = Venue.find_by(name: updated_venue_name)
            puts "Success! You've updated your gig venue to #{gig_to_update.venue.name}"
        end
    end

    def delete_a_gig 
       display_gigs.each do |gig|
        puts "Gig: #{gig.name}, ID: #{gig.id}, Venue: #{gig.venue.name}"
       end
        puts "Which gig would you like to delete? Please enter the ID"
       gig_to_delete = gets.chomp.to_i
       find_gig_to_delete = Gig.find_by(id: gig_to_delete)
        if find_gig_to_delete == nil 
            puts "Sorry, you don't have any gigs to delete right now!"
        end
        
       answer = TTY::Prompt.new.yes?("Are you really sure you want to delete this gig? #{gig_to_delete}", find_gig_to_delete.delete)
       puts "Gig, BYE! It is finished. That gig no longer exists. It has been destroyed."
    end

def count_gigs 
    puts "You've got #{self.gigs.count} gigs listed!"
end

def list_venues
    puts "Here are all the venues where you're playing gigs: "
    self.venues.each do |venue|
    puts "#{venue.name}"
    end
end

def venue_locations 
    self.venues.each do |venue|
    puts "Your gig at #{venue.name} is located at #{venue.location}"
    end
end

def view_musician_profile
    puts "Here's what we've got on file for you:" 
    puts "Name: #{self.name}"
    puts "Bio: #{self.bio}"
    puts "Url: #{self.website_url}"
    puts "Instrument: #{self.instrument}"
end

def update_musician_profile
    view_musician_profile

    choices = %w(name bio url instrument)
    answer = TTY::Prompt.new.select("Select what you'd like to update:", choices)

    case answer 
    when "name"
        puts "Please enter the new name you'd like to use:"
        updated_name = gets.chomp.downcase
        self.update(name: updated_name)
        puts "Success! Here's your updated name: #{self.name}"
    when "bio"
        puts "Please enter the new bio you'd like to use:"
        updated_bio = gets.chomp.downcase
        self.update(bio: updated_bio)
        puts "Success! Here's your updated bio: #{self.bio}"
    when "url"
        puts "Please enter the new url you'd like to use:"
        updated_url = gets.chomp.downcase
        self.update(website_url: updated_url)
        puts "Success! Here's your updated url: #{self.website_url}"
    when "instrument"
        puts "Please enter the new instrument you'd like to use:"
        updated_instrument = gets.chomp.downcase
        self.update(instrument: updated_instrument)
        puts "Success! Here's your updated instrument: #{self.instrument}"
    end


end

end

   