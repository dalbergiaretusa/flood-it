#Flood It - Sebastian Ksiazczyk, 2016

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

$width=14
$height=9
$record=-1
def get_board(width, height)
  # TODO: Implement this method
  colours=[:red, :blue, :green, :yellow, :cyan, :magenta]
  
  $board=[]
  $row=[]
  
  # creating the board with random colours
  for i in 0..height-1
  	$row=[]
  	for j in 0..width-1
  		$row << colours.sample
  	end
  	$board << $row
  end
  
  return $board

  # This method should return a two-dimensional $board.
  # Each element of the $board should be one of the
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

#displaying the board
def display_board
	for i in 0..$height-1
  	for j in 0..$width-1
  		print "  ".colorize(:background => $board[i][j])
  	end
  	puts
  end
end


def change_board_size
	puts "Current board size: #{$width} x #{$height}"
	puts "Please enter your desired table size below:"
	print "Width:"
	$width=gets.chomp.to_i
	print "Height:"
	$height=gets.chomp.to_i
	puts "The board size has been changed to #{$width} x #{$height}."
end

def update(color, i, j)
	oldcolor=$board[i][j]
	$board[i][j]=color
	if i+1<$height && $board[i+1][j]==oldcolor
		update(color, i+1, j)
	end
	if j+1<$width && $board[i][j+1]==oldcolor
		update(color, i, j+1)
	end
	if i>0 && $board[i-1][j]==oldcolor
		update(color, i-1, j)
	end
	if j>0 && $board[i][j-1]==oldcolor
		update(color, i, j-1)
	end
end

def play_game
	x=0
	comp=0
	while comp<100 do
		display_board
		puts "Number of turns: #{x}"
		puts "Current completion: #{comp}%"
		print "Pick a colour:"
		input=gets.chomp
		case input
		when 'r'
			choice = :red
		when 'b'
			choice = :blue
		when 'g'
			choice = :green
		when 'y'
			choice = :yellow
		when 'c'
			choice = :cyan
		when 'm'
			choice = :magenta
		else
			puts "Unrecognized colour. Try again!"
			next
		end
		fieldsCount=0
		update(choice, 0, 0)
		for i in 0..$board.length-1
			for j in 0..$board[i].length-1
				if $board[i][j]==choice
					fieldsCount+=1
				end
			end
		end
		comp=fieldsCount/($width*$height)*100
		x+=1
		# puts "\e[H\e[2J"
	end
	display_board
	puts "Congratulations! You have completed the board in #{x} steps."
	if x<$record || $record==-1
		puts "New record!"
		record=x
	end

end

#~~~~~ACTUAL PROGRAM


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
played=false #a boolean so ill change the last menu entry just once (record)

# END OF MAIN MENU

# THE GAME
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
			get_board($width, $height)
			play_game
			if played==false
				menu[4]="Best game: #{$record} turns."
				played=true
			end
		else
			puts "Undefined input. Please try again"
		end
	end	
end