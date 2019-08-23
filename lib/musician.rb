class Musician < ActiveRecord::Base
    has_many :gigs 
    has_many :venues, through: :gigs 

    def self.handle_returning_musician 
        system "clear"
        puts "Welcome back! Please enter your name: ".colorize(:yellow)
        name = gets.chomp 
        Musician.find_by(name: name)
        # TTY::Prompt.new.mask("Please enter your password:")
    end 

    def self.handle_new_musician 
        system "clear"
        puts "Glad to have you here! Let's get you set up! What's your name, musician?".colorize(:yellow)
        name = gets.chomp 
        Musician.create(name: name)
    end

    def list_gigs 
        system "clear"
        puts "Here are the gigs for #{self.name}:".colorize(:yellow)
        gig_names = self.gigs.map do |gig| 
            {name: gig.name, value: gig.id}
        end
        answer =  TTY::Prompt.new.multi_select("Select gigs for more details:".colorize(:yellow), gig_names)
       
    end 

    def display_gigs
        system "clear"
        if self.gigs == nil 
            puts "Sorry, you don't have any gigs listed right now!".colorize(:yellow)
            TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
        else
            self.gigs.each do |gig|
            puts "#{self.name} is playing a gig as #{gig.name} at the venue #{gig.venue.name}.".colorize(:yellow)
            end
            TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
        end
    end

    def create_a_gig 
        system "clear"
        puts "What's the name of your gig?".colorize(:yellow)
        gig_name = gets.chomp
        puts "What's the venue of your gig?".colorize(:yellow)
        gig_venue = gets.chomp 
        find_gig_venue = Venue.find_by(name: gig_venue)
            if find_gig_venue == nil
            create_gig_venue = Venue.create(name: gig_venue)
            new_venue = create_gig_venue.name
            find_gig_venue = Venue.find_by(name: new_venue)
            end

        puts "What's the description for your gig?".colorize(:yellow)
        gig_description = gets.chomp 

        new_gig = Gig.create(name: gig_name, venue_id: find_gig_venue.id, musician_id: self.id, description: gig_description)
        puts "You've successfully created a new gig for #{self.name} named #{new_gig.name} at #{new_gig.venue.name} with the following description: #{new_gig.description}.".colorize(:yellow)

        TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
    end

    def update_musician_bio 
        system "clear"
        puts "Here's your current Musician Bio: ".colorize(:yellow) + "#{self.bio}"
        puts "Please enter your updated Musician Bio: ".colorize(:yellow)
        updated_bio = gets.chomp
        updated_bio = self.update(bio: updated_bio)
        puts "Alright! Here's your updated Musician Bio: ".colorize(:yellow) + "#{self.bio}"

        TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
    end

    def find_gig_by_id
        system "clear"
        puts "Which gig would you like to update?".colorize(:yellow)
        self.gigs.each do |gig| 
            puts "#{gig.id}. #{gig.name}"
        end
        gig_to_update = gets.chomp
        find_gig_to_update = Gig.find_by(id: gig_to_update)
    end

    def update_gig
        system "clear"
        gig_to_update = find_gig_by_id
        puts "What would you like to update for this gig? Name, Description or Venue?".colorize(:yellow)
        answer = gets.chomp.downcase
        case answer
        when "name"
            puts "This is your current name: ".colorize(:yellow) + "#{gig_to_update.name}"
            puts "Please enter your updated name: ".colorize(:cyan)
            updated_name = gets.chomp 
            gig_to_update.update(name: updated_name)
            puts "Success! You've updated your gig name to".colorize(:cyan) + "#{gig_to_update.name}"
        when "description"
            puts "This is your current Gig Description: ".colorize(:yellow)#{gig_to_update.description}"
            puts "Please enter your updated description: ".colorize(:yellow)
            updated_description = gets.chomp 
            gig_to_update.update(description: updated_description)
            puts "Success! You've updated your gig description to: ".colorize(:cyan) + "#{gig_to_update.description}"
        when "venue"
            puts "This is your current gig venue: ".colorize(:cyan) + "#{gig_to_update.venue.name}"
            puts "Please enter your updated venue name: ".colorize(:cyan)
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
            puts "Success! You've updated your gig venue to: ".colorize(:cyan) + "#{gig_to_update.venue.name}"

            TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
        end
    end

    def delete_a_gig 
        system "clear"
        display_gigs.each do |gig|
        puts "Gig: #{gig.name}, ID: #{gig.id}, Venue: #{gig.venue.name}"
       end
        puts "Which gig would you like to delete? Please enter the ID: ".colorize(:cyan)
       gig_to_delete = gets.chomp.to_i
       find_gig_to_delete = Gig.find_by(id: gig_to_delete)
        if find_gig_to_delete == nil 
            puts "Sorry, you don't have any gigs to delete right now!".colorize(:cyan)
        end
        
       answer = TTY::Prompt.new.yes?("Are you really sure you want to delete this gig? #{gig_to_delete}", find_gig_to_delete.delete).colorize(:cyan)
       puts "Gig, BYE! It is finished. That gig no longer exists. It has been destroyed.".colorize(:cyan)

       TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
    end

def count_gigs 
    system "clear"
    puts "You've got #{self.gigs.count} gigs listed!".colorize(:cyan)

    TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
end

def list_venues
    system "clear"
    puts "Here are all the venues where you're playing gigs: ".colorize(:cyan)
    self.venues.each do |venue|
    puts "#{venue.name}"
    end

    TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
end

def venue_locations 
    system "clear"
    self.venues.each do |venue|
    puts "Your gig at #{venue.name} is located at #{venue.location}".colorize(:cyan)
    end

    TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
end

def view_musician_profile
    system "clear"
    puts "Here's what we've got on file for you:".colorize(:yellow)
    puts "Name: #{self.name}".colorize(:cyan)
    puts "Bio: #{self.bio}".colorize(:cyan)
    puts "Url: #{self.website_url}".colorize(:cyan)
    puts "Instrument: #{self.instrument}".colorize(:cyan)  
    
    TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
end

def musician_profile 
    puts "Here's what we've got on file for you:".colorize(:yellow)
    puts "Name: #{self.name}".colorize(:cyan)
    puts "Bio: #{self.bio}".colorize(:cyan)
    puts "Url: #{self.website_url}".colorize(:cyan)
    puts "Instrument: #{self.instrument}".colorize(:cyan)  
end

def update_musician_profile
    system "clear"

    musician_profile
    
    choices = %w(name bio url instrument nevermind!)
    answer = TTY::Prompt.new(active_color: :yellow).select("Select what you'd like to update:".colorize(:yellow), choices)

    case answer 
    when "name"
        puts "Please enter the new name you'd like to use:".colorize(:yellow)
        updated_name = gets.chomp.downcase
        self.update(name: updated_name)
        puts "Success! Here's your updated name: ".colorize(:cyan) + "#{self.name}"
    when "bio"
        puts "Please enter the new bio you'd like to use: ".colorize(:yellow)
        updated_bio = gets.chomp.downcase
        self.update(bio: updated_bio)
        puts "Success! Here's your updated bio: ".colorize(:cyan) + "#{self.bio}"
    when "url"
        puts "Please enter the new url you'd like to use:".colorize(:yellow)
        updated_url = gets.chomp.downcase
        self.update(website_url: updated_url)
        puts "Success! Here's your updated url: ".colorize(:cyan) + "#{self.website_url}"
    when "instrument"
        puts "Please enter the new instrument you'd like to use:".colorize(:cyan)
        updated_instrument = gets.chomp.downcase
        self.update(instrument: updated_instrument)
        puts "Success! Here's your updated instrument: ".colorize(:cyan) + "#{self.instrument}"

    when "nevermind!"
        TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
    end

    TTY::Prompt.new.keypress("Press any key to return to main menu!").colorize(:yellow)
end

end

   