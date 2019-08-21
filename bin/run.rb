require_relative '../config/environment'

cli = Interface.new
musician_object = cli.welcome 

while !musician_object 
    musician_object = cli.welcome 
end

cli.musician = musician_object

choice = cli.main_menu

# binding.pry 

0