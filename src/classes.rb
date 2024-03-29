
require "faker"
require "tty-prompt"


#custom error classes 

class InvalidCharacters  < StandardError 
end 

class PhoneInvalid < StandardError
end 

class CardInvalid < StandardError 
end 


# Fighter class sets fighter's name and fighting scores using data generated by Faker ruby gem. 
class Fighter
    attr_reader :first_name, :last_name, :grappling_score, :striking_score, :power_score, :full_name
    attr_accessor :damage, :fighter_score
    def initialize 
        @first_name = Faker::Name.male_first_name
        @last_name = Faker::Name.last_name
        @full_name = "#{@first_name} #{@last_name}" 
        @grappling_score = Faker::Number.within(range: 3.0..10.0)
        @striking_score = Faker::Number.within(range: 3.0..10.0)
        @power_score = Faker::Number.within(range: 3.0..10.0)
        @fighter_score = 0.0 
        @damage = 0
    end 

# Sets fighter score using grappling, striking, and power score values. 
    def set_fighter_score 
        @fighter_score = @grappling_score +  @striking_score + @power_score
        return @fighter_score
    end 
end 


# User class is initialized using data collected from either command line arguments, or user data gathered with TTY prompt in index.rb.  
class User
    attr_reader :first_name, :last_name, :phone_number, :account_balance, :credit_card
    attr_accessor :bet_history, :account_balance
    def initialize(f_name, l_name, phone_no) 
        @first_name =  f_name
        @last_name =  l_name
        @phone_number =  phone_no
        @account_balance =  0
        @credit_card = []
        @bet_history = []
    end 

    ## Checks whether credit card numbers are made up only of numbers, if they're empty, and if they're the correct amount of digits. 
    ## If they match any of these conditions we request new input from the user. 
    def check_card(number, digits)
        begin 
            raise CardInvalid if !number.count("^0-9").zero? || number.empty? || number.size != digits
        rescue CardInvalid 
            puts "Please enter a valid #{digits} digit number"
            number = STDIN.gets.gsub(/\s+/, "")
            retry
        end 
        return number 
    end 

    def deposit
        prompt = TTY::Prompt.new
        deposit_amount = 0 
        
        while deposit_amount > 5000 || deposit_amount < 5
            deposit_amount = prompt.ask("Please enter a deposit amount between $5 and $5,000", convert: :float, required: true) do |q|
            q.convert(:float, "%{value} is not a valid withdrawal amount. Please enter a number between $5 and $5,000.")
            end  
        end 
    
        deposit_amount = deposit_amount.round(2)
            if @credit_card.length != 3
            puts "Please enter your 16 digit credit card number"
            credit_card_no = STDIN.gets.gsub(/\s+/, "")
            check_card(credit_card_no, 16)
            credit_card_no = credit_card_no.to_i
            @credit_card[0] = credit_card_no

            puts "Please enter your 4 digit expiry date"
            expiry_date = STDIN.gets.gsub(/\s+/, "")
            check_card(expiry_date, 4)
            expiry_date = expiry_date.to_i
            @credit_card[1] = expiry_date

            puts "Please enter your 3 digit CVV"
            cvv = STDIN.gets.gsub(/\s+/, "")
            check_card(cvv, 3)
            cvv = cvv.to_i
            @credit_card[2] = cvv
        end
        @account_balance += deposit_amount
        system("clear")
        puts "Transaction successful. $#{deposit_amount} deposited. Your account balance is $#{@account_balance}"        
    end 

    ## lets users withdraw money from their account. Exits if account_balance is $0. Otherwise gets a withdraw value. If they've requested
    ## more than they have, or if withdraw value is less than min. $1, then we alert user and exit. Otherwise we subtract deposit amount
    ## from account balance and alert user that we've processed the payment. 
    def cash_out
        if @account_balance == 0
            system("clear")
            puts "Your account balance is $0. You cannot withdraw funds." 
        else
            prompt = TTY::Prompt.new
            puts "Your account balance is #{@account_balance.round(2)}"
            withdraw_value = prompt.ask("How much would you like to withdraw? Enter a number.", convert: :float, required: true) do |q|
            q.convert(:float, "%{value} is not a valid withdrawal amount. Please enter a number.")
            end 
            
            withdraw_value = withdraw_value.round(2) 

            if withdraw_value > @account_balance
                system("clear")
                puts "Your requested cash out value of #{withdraw_value} is greater than your account value."
            elsif withdraw_value < 1  
                system("clear")
                puts "You cannot withdraw less than $1 from your account balance."
            else
                @account_balance -= withdraw_value
                system("clear")
                puts "We have transferred $#{withdraw_value} to the pay id associated with the phone number #{@phone_number}."  
                puts "Your remaining account balance is $#{@account_balance.round(2)}" 
            end
        end    
    end 

end 
