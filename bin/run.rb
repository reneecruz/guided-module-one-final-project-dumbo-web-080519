require_relative '../config/environment'

cli = Interface.new
musician_object = cli.welcome 

while !musician_object 
    musician_object = cli.welcome 
end

cli.musician = musician_object

choice = cli.main_menu

# while choice != "exit"
#     choice = cli.main_menu
# end


# binding.pry 

0