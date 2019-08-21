class Interface
  attr_accessor :prompt, :musician

  def initialize() 
    @prompt = TTY::Prompt.new 
  end

  def welcome 
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
    menu.choice "See Your Gig Venues", -> {self.musician.list_venues}
    menu.choice "Delete a Gig", -> {self.musician.delete_a_gig}
    menu.choice "Show All Gigs", -> {self.musician.display_gigs} 
    menu.choice "How Many Gigs Do I Have Listed?", -> {self.musician.count_gigs}
    end
  end

  


end



#prompt = TTY::Prompt.new
  
# prompt.ask("Your question here")
  
# prompt.yes?("Are you a dog")
  
# prompt.mask("Enter your password:")
  
# prompt.select("What's your favorite kind of taco shell?", %w(Soft_taco Hard_taco 
# Porque_no_los_dos?))

# prompt.multi_select("What's your favorite pet?", %w(cats dogs fish 
# birds reptiles plants))

# prompt.enum_select("What's your favorite pet?", %w(cats 
# dogs fish birds reptiles plants))

# prompt.ask("What's your name?", default: 'Anonymous')
# prompt.ask("What industry do you work in?", default: "Tech")

# prompt.yes?("Is GrumpyCat grumpy?", default: true)

# prompt.select("Choose your fruit of choice") do |menu|
#   menu.default 3

#    menu.choice "Papaya", 1
#    menu.choice "Mango", 2
#    menu.choice "Watermelon", 3
#  end

#  prompt.multi_select("Select tea?") do |menu|
#   menu.default 2, 5

#    menu.choice :green
#    menu.choice :black
#    menu.choice :white
#    menu.choice :earl_grey
#    menu.choice :sweet
#  end

#  prompt.mask("Enter a password: ", required: true)

#  prompt.ask("What is your name?", required: true)

# end
   

      

     

      


      # def find_lines(station)
      #   station.lines
      # end

     




