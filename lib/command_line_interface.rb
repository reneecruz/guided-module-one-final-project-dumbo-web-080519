class CommandLineInterface 

    def greet
        puts "Welcome to Gig Listing, the command line solution to for your NYC live music finding needs!"
      end

      def gets_user_input
        puts "We can help you find live music at NYC venues."
        puts "Enter a date to get started:"
        #what could we put here to allow a user to type a response?
        gets.chomp.strip
      end

      # find_venue = Venue.find_by(name: name)

      def run
        greet
        input = gets_user_input
        # find_station(input)  
      end

      # def find_lines(station)
      #   station.lines
      # end

end