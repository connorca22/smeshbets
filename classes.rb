
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


