require_relative "classes.rb"
require_relative "methods.rb"
require "tty-font"

#writes app name in stylised writing 
font = TTY::Font.new(:doom)
puts font.write("WELCOME TO")
puts font.write("SMESH BETS")

#create tty prompt object 
prompt = TTY::Prompt.new

#ARGV tests
command_line_login = "No"

if ARGV.size == 3 
    puts "You have provided the following account details:" 
    puts "Name: #{ARGV[0]} #{ARGV[1]}"
    puts "Phone: #{ARGV[2]}"
    command_line_login = prompt.select("Is this correct?", ["Yes", "No"])

    if command_line_login == "Yes"
        first_name = ARGV[0] if ARGV[0]
        last_name = ARGV[1] if ARGV[1]
        phone_number = ARGV[2] if ARGV[2]
        first_name = verify_name(first_name)
        last_name = verify_name(last_name)
        phone_number = check_phone(phone_number)
        system("clear")
    end 
end 

if command_line_login == "No"
    system("clear")
    puts "Please enter your details to register an account"
    first_name = prompt.ask("What is your first name?", required: true)
    first_name = verify_name(first_name)
    last_name = prompt.ask("What is your last name?", required: true)
    last_name = verify_name(last_name)
    phone_number = prompt.ask("Please enter a 10 digit mobile number beginning with 04 or 05", required: true).gsub(/\s+/, "")
    phone_number = check_phone(phone_number)
end 

$user = User.new(first_name, last_name, phone_number)

system("clear")
puts "Welcome #{$user.first_name}!"
sleep(2)

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