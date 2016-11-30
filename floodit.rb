#Flood It - Sebastian Ksiazczyk, 2016

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)


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

