
require "faker"
require "tty-prompt"

class Fighter
    attr_accessor :fight_complete, :damage 
    attr_reader :first_name, :last_name, :grappling_score, :striking_score, :power_score
    def initialize 
        @first_name = Faker::Name.male_first_name
        @last_name = Faker::Name.last_name
        @grappling_score = Faker::Number.within(range: 5.0..10.0)
        @striking_score = Faker::Number.within(range: 5.0..10.0)
        @power_score = Faker::Number.within(range: 5.0..10.0)
        @fight_complete = false 
        @damage = 0
    end 
end 


class User(f_name, l_name, phone_no) 
    attr_reader :first_name, :last_name, :phone_number, :account_balance  
    def initialize
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

end 
