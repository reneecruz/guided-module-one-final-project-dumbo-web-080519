class Interface
  attr_accessor :prompt, :musician

  def initialize() 
    @prompt = TTY::Prompt.new(active_color: :yellow)
  end

  def welcome 
    system "clear"
    puts "Welcome to the Gig Lister Application! 🎷"

    answer = prompt.select("Are you a returning user or a new user?") do |menu|
      menu.choice "New User", -> {Musician.handle_new_musician}
      menu.choice "Returning User", -> {Musician.handle_returning_musician}
    end
  end

  def main_menu
    system "clear"
    musician.reload
    prompt.select("Oh hey, #{self.musician.name}! What would you like to do today?".colorize(:cyan), per_page: 15) do |menu|
    menu.choice "Select Gigs", -> {self.musician.list_gigs}
    menu.choice "Create a Gig", -> {self.musician.create_a_gig}
    menu.choice "Update My Musician Bio", -> {self.musician.update_musician_bio}
    menu.choice "Update a Gig", -> {self.musician.update_gig}
    menu.choice "List Gig Venues", -> {self.musician.list_venues}
    menu.choice "Delete a Gig", -> {self.musician.delete_a_gig}
    menu.choice "Display Gig Details", -> {self.musician.display_gigs} 
    menu.choice "Count My Gigs", -> {self.musician.count_gigs}
    menu.choice "Venue Locations", -> {self.musician.venue_locations}
    menu.choice "Update Musician Profile", -> {self.musician.update_musician_profile}
    menu.choice "View Musician Profile", -> {self.musician.view_musician_profile}
    menu.choice "Exit", -> {exit!}
    end
  end

end

