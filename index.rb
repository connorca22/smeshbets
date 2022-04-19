require_relative "classes.rb"
require_relative "methods.rb"
require "tty-font"

#writes app name in stylised writing 
font = TTY::Font.new(:doom)
puts font.write("WELCOME   TO   SMESH   BETS")

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


#home menu 
system("clear")
program_active = true 
puts "What would you like to do?"
while program_active 
home_menu_select = prompt.select("", ["Place Bet", "Deposit Funds", "Withdraw Funds", "Exit"]) 
    if home_menu_select == "Place Bet"
        place_bet 
    elsif home_menu_select == "Deposit Funds"
        $user.deposit 
    elsif home_menu_select == "Withdraw Funds"
        $user.cash_out 
    elsif home_menu_select == "Exit"
        program_active = false 
        system("clear")
        puts font.write("GOODBYE")
    end 
end 