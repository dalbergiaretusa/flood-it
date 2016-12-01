#Flood It - Sebastian Ksiazczyk, 2016

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

$width=14
$length=9

def get_board(width, height)
  # TODO: Implement this method
  #
  # This method should return a two-dimensional array.
  # Each element of the array should be one of the
  # following values (These are "symbols", you can use
  # them like constant values):
  # :red
  # :blue
  # :green
  # :yellow
  # :cyan
  # :magenta
  #
  # It is important that this method is used because
  # this will be used for checking the functionality
  # of your implementation.
end

def change_board_size
	puts "Current board size: #{$width} x #{$length}"
	puts "Please enter your desired table size below:"
	print "Width:"
	$width=gets.chomp.to_i
	print "Length:"
	$length=gets.chomp.to_i
	puts "The board size has been changed to #{$width} x #{$length}."
end

def play_game(array)

end
# SPLASH SCREEN
splash = ConsoleSplash.new(20,60)

splash.write_left_pattern("0", {:fg=>:cyan})
splash.write_right_pattern("0", {:fg=>:light_cyan})
splash.write_bottom_pattern("*-..-*", {:fg=>:cyan})
splash.write_top_pattern(".-**-.", {:fg=>:light_cyan})

splash.write_header("Flood-It", "Sebastian Ksiazczyk", "0.1.0", 
        {:nameFg=>:light_magenta, :authorFg=>:light_green, :versionFg=>:yellow})
splash.write_center(-5, "*press [ENTER] to continue*", :fg=>:light_magenta)

splash.splash
# END OF SPLASH SCREEN 

# MAIN MENU
menu = []
menu << "Main Menu"
menu << "s: Start game"
menu << "c: Change board size"
menu << "q: Quit game"
menu << "No games played yet"

input=gets

if input=="\n"
	while true do
		puts menu
		puts "Please enter your choice:"
		input=gets.chomp
		if input=='q'
			puts "It was lovely to meet you. See you later!"
			exit
		elsif input=='c'
			change_board_size
		elsif input=='s'
			play_game(get_board($width, $height))
		else
			puts "Undefined input. Please try again"
		end
	end
		
	end

# END OF MAIN MENU
# MAIN LOOP