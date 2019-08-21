class Interface
  attr_accessor :prompt, :musician

  def initialize() 
    @prompt = TTY::Prompt.new 
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
    prompt.select("Welcome, #{self.musician.name}! What would you like to do today?") do |menu|
    menu.choice "See My Gigs", -> {self.musician.list_gigs}
    menu.choice "Create a Gig", -> {self.musician.create_a_gig}
    menu.choice "Update My Musician Bio", -> {self.musician.update_musician_bio}
    menu.choice "Update a Gig", -> {self.musician.update_gig}
    menu.choice "See My Gig Venues", -> {self.musician.list_venues}
    menu.choice "Delete a Gig", -> {self.musician.delete_a_gig}
    menu.choice "Show My Gigs", -> {self.musician.display_gigs} 
    menu.choice "Count My Gigs", -> {self.musician.count_gigs}
    end
  end

end

