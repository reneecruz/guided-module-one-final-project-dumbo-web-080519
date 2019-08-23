require_relative '../config/environment'

cli = Interface.new
musician_object = cli.welcome 

system "clear"

while !musician_object 
    musician_object = cli.welcome 
end

cli.musician = musician_object

choice = cli.main_menu

if choice
     cli.main_menu
end



# binding.pry 

0