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
        # gig_names = self.gigs.each_with_index.inject({}) do |hash, (gig, i)|
        #     venue = Venue.find(gig.venue_id)
        #     hash["#{i + 1}| #{gig.name} - #{venue.name}"] = gig.id
        #     hash
        # end
        choice = TTY::Prompt.new.select("Select gigs for more details:", gig_names)
        gig = Gig.find(choice)
        # binding.pry
    end 

    def display_gigs
       self.gigs.each do |gig|
        puts "#{self.name} is playing a gig as #{gig.name} at the venue #{gig.venue.name}."
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
            
            gig_to_update.update(venue_id: updated_venue_name)
            updated_venue = Venue.find_by(name: updated_venue_name)
            puts "Success! You've updated your gig venue to #{updated_venue.name}"
        end
    end

    def delete_a_gig 
       display_gigs
       puts "Which gig would you like to delete?"
       gig_to_delete = gets.chomp
       find_gig_to_delete = Gig.find_by(name: gig_to_delete)
       
       answer = TTY::Prompt.new.yes?("Are you really sure you want to delete this gig? #{gig_to_delete}", find_gig_to_delete.delete)
       puts "Gig, BYE! It is finished. That gig no longer exists. It has been destroyed."
    end

def count_gigs 
    puts "You've got #{self.gigs.count} gigs listed!"
end

def list_venues
    puts "Here are all the venues where you're playing gigs: "
    self.venues.each do |venue|
    puts venue.name
    end
end

end

   