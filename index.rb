require_relative "classes.rb"
require_relative "methods.rb"
require "tty-font"

#writes app name in stylised writing 
font = TTY::Font.new(:doom)
puts font.write("WELCOME TO")
puts font.write("SMESH BETS")

#requests user data then creates new user from User class
prompt = TTY::Prompt.new
puts "Please enter your details to register an account"
first_name = prompt.ask("What is your first name?", required: true)
first_name = verify_name(first_name)
last_name = prompt.ask("What is your last name?", required: true)
last_name = verify_name(last_name)
phone_number = prompt.ask("Please enter a 10 digit mobile number beginning with 04 or 05", required: true).gsub(/\s+/, "")
phone_number = check_phone(phone_number)

$user = User.new(first_name, last_name, phone_number)

#Creates all fighters 
$fight_card = [[Fighter.new, Fighter.new], [Fighter.new, Fighter.new], [Fighter.new, Fighter.new], [Fighter.new, Fighter.new], [Fighter.new, Fighter.new]]

#sets their fighter_scores using the Fighter class method. 
$fight_card.each do |i| 
    i[0].set_fighter_score 
    i[1].set_fighter_score
end 