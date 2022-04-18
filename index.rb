require_relative "classes.rb"
require_relative "methods.rb"
require "tty-font"

#writes app name in stylised writing 
font = TTY::Font.new(:doom)
puts font.write("WELCOME TO")
puts font.write("SMESH BETS")