
require "faker"
require "tty-prompt"

class Fighter
    attr_reader :first_name, :last_name, :grappling_score, :striking_score, :power_score, :full_name
    attr_accessor :fight_complete, :damage, :fighter_score
    def initialize 
        @first_name = Faker::Name.male_first_name
        @last_name = Faker::Name.last_name
        @full_name = "#{@first_name} #{@last_name}" 
        @grappling_score = Faker::Number.within(range: 4.0..10.0)
        @striking_score = Faker::Number.within(range: 4.0..10.0)
        @power_score = Faker::Number.within(range: 4.0..10.0)
        @fighter_score = 0.0 
        @fight_complete = false 
        @damage = 0
    end 
    
    def set_fighter_score 
        @fighter_score = @grappling_score +  @striking_score + @power_score
    end 
end 


class User
    attr_reader :first_name, :last_name, :phone_number, :account_balance, :credit_card
    def initialize(f_name, l_name, phone_no) 
        @first_name =  f_name
        @last_name =  l_name
        @phone_number =  phone_no
        @account_balance =  0
        @credit_card = []
    end 

    def check_card(number, digits)
        while !number.count("^0-9").zero? || number.empty? || number.size != digits
            puts "Please enter a valid #{digits} digit number"
            number = gets.gsub(/\s+/, "")
        end
    end

    def deposit
            prompt = TTY::Prompt.new
            deposit_amount = prompt.select("Please enter deposit amount", ["5", "10", "20", "35", "50", "75", "100"]).to_f
           
            if @credit_card.length != 3
            puts "Please enter your 16 digit credit card number"
            credit_card_no = gets.gsub(/\s+/, "")
            check_card(credit_card_no, 16)
            credit_card_no = credit_card_no.to_i
            @credit_card[0] = credit_card_no

            puts "Please enter your 4 digit expiry date"
            expiry_date = gets.gsub(/\s+/, "")
            check_card(expiry_date, 4)
            expiry_date = expiry_date.to_i
            @credit_card[1] = expiry_date
        #ideally would need to ensure that would print error if it was past expiry date. would need to figure out how to use current date. 

            puts "Please enter your 3 digit CVV"
            cvv = gets.gsub(/\s+/, "")
            check_card(cvv, 3)
            cvv = cvv.to_i
            @credit_card[2] = cvv
        end
        @account_balance = deposit_amount
        puts "Transaction successful. #{deposit_amount} added to account balance."        
    end 

    #lets users withdraw money from their account. Gets float as withdraw value & exits once they've withdrawn, or if they've requested more than they have, or if their account balance is $0. 
    def cash_out
        prompt = TTY::Prompt.new
        withdraw_value = prompt.ask("How much would you like to withdraw? Enter a number.", convert: :float, required: true) do |q|
            q.convert(:float, "%{value} is not a valid withdrawal amount. Please enter a number.")
        end
            
        if @account_balance == 0
            puts "Your account balance is $0. You cannot withdraw funds."
        elsif withdraw_value > @account_balance
            puts "Your requested cash out value of #{withdraw_value} is greater than your account value."
        elsif withdraw_value == 0.0 
            puts "You cannot withdraw $0 from your account balance."
        else
            @account_balance -= withdraw_value
            puts "We have transferred $#{withdraw_value} to the pay id associated with the phone number #{@phone_number}. Your remaining account balance is $#{@account_balance}."
        end
           
    end 

end 
