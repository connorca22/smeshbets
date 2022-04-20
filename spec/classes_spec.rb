require_relative "../src/classes.rb"

describe "Fighter class: set_fighter_score method" do 
    let(:fighter) {Fighter.new}
    it "checks that fighter_score variable is set to a floating point number once method is called" do
        expect(fighter.set_fighter_score).to be_a_kind_of(Float)
    end 

    it "checks that fighter score is within the possible range (9.0-30.0)" do
        expect(fighter.set_fighter_score).to be >= 9 
        expect(fighter.set_fighter_score).to be <= 30 
    end 
end 

describe "User class: check_card method" do 
    let(:user) {User.new('first', 'last', '0400000000')}
    it "checks whether check_card method only proceeds if relevant conditions are met" do
        expect(user.check_card('123', 3)).not_to match(/[^0-9]/) #checks if number string only contains digits. 
        expect(user.check_card('123', 3)).not_to be_empty #checks whether string is empty. 
        expect(user.check_card('123', 3).length).to be(3) #checks if card number length is equal to digits provided.
    end 
end 