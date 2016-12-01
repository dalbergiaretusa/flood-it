#Flood It - Sebastian Ksiazczyk, 2016

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

width=14
height=9
$record=-1
menu = []

def get_board(width, height) #returns a randomly generated board
  colours=[:red, :blue, :green, :yellow, :cyan, :magenta]
  board=[]
	row=[]
  # creating the board with random colours
  for i in 0..height-1
  	row=[]
  	for j in 0..width-1
  		row << colours.sample
  	end
  	board << row
  end
  return board
end

def display_board(board) #displays the board in colour
	for i in 0..board.length-1
  	for j in 0..board[i].length-1
  		print "  ".colorize(:background => board[i][j])
  	end
  	puts
  end
end


def change_board_size(width, height) #changes the board size, resets the record
	puts "Current board size: #{width} x #{height}"
	puts "Please enter your desired table size below:"
	print "Width:"
	width=gets.chomp.to_i
	print "Height:"
	height=gets.chomp.to_i
	puts "The board size has been changed to #{width} x #{height}."
	ret=[width,height]
	return ret
end

def update(board, color, i, j) #updates the board according to users choice
	oldcolor=board[i][j]
	if oldcolor==color
		return
	end

	board[i][j]=color
	if i+1<board.length && board[i+1][j]==oldcolor
		update(board, color, i+1, j)
	end
	if j+1<board[0].length && board[i][j+1]==oldcolor
		update(board, color, i, j+1)
	end
	if i>0 && board[i-1][j]==oldcolor
		update(board, color, i-1, j)
	end
	if j>0 && board[i][j-1]==oldcolor
		update(board, color, i, j-1)
	end
end

def play_game(board) #lets play
	x=0 #move counter
	fieldsCount=0
	choice=board[0][0] #at the beginning of the game ill count the initial completion
	for i in 0..board.length-1
		for j in 0..board[i].length-1
			if board[i][j]==choice
				fieldsCount+=1
			end
		end
	end
	comp=fieldsCount*100/(board.length*board[0].length) #initial completion count
	
	while comp<100 do #loop while the game is not finished
		puts "\e[H\e[2J" #nice and neat
		display_board(board)
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
		update(board, choice, 0, 0) #updating the board with the colour of choice
		fieldsCount=0 #important reset!

		#counting the completion
		for i in 0..board.length-1
			for j in 0..board[i].length-1
				if board[i][j]==choice
					fieldsCount+=1
				end
			end
		end
		comp=fieldsCount*100/(board.length*board[0].length)
		
		x+=1 #move++
	end

	display_board(board) #this is just plain colour

	puts "Congratulations! You have completed the board in #{x} steps." #GJ
	if x<$record || $record==-1 #updating the record if necessary
		puts "New record!" #GJ x2
		$record=x
	end

end

#~~~~~ACTUAL PROGRAM


# SPLASH SCREEN
splash = ConsoleSplash.new(20,60)

splash.write_left_pattern("0", {:fg=>:cyan})
splash.write_right_pattern("0", {:fg=>:light_cyan})
splash.write_bottom_pattern("*-..-*", {:fg=>:cyan})
splash.write_top_pattern(".-**-.", {:fg=>:light_cyan})

splash.write_header("Flood-It", "Sebastian Ksiazczyk", "1.0.0", 
        {:nameFg=>:light_magenta, :authorFg=>:light_green, :versionFg=>:yellow})
splash.write_center(-5, "*press [ENTER] to continue*", :fg=>:light_magenta)

splash.splash
# END OF SPLASH SCREEN 

# MAIN MENU
menu << "Main Menu"
menu << "s: Start game"
menu << "c: Change board size"
menu << "q: Quit game"
menu << "No games played yet"

# END OF MAIN MENU

# THE GAME
input=gets
if input=="\n" #press enter to continue
	while true do
		puts menu
		puts "Please enter your choice:"
		input=gets.chomp
		if input=='q'
			puts "It was lovely to meet you. See you later!"
			exit
		elsif input=='c'
			temp=change_board_size(width, height)
			width=temp[0]
			height=temp[1]
			menu[4]="No games played yet"
		elsif input=='s'
			play_game(get_board(width, height)) #create a board
			menu[4]="Best game: #{$record} turns." #update the record
		else
			puts "Undefined input. Please try again"
		end
	end	
end
#Good night!