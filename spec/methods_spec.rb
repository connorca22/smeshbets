require_relative "../src/methods.rb"
require_relative "../src/classes.rb"

describe "verify_name" do 
    it "checks that the verify_name method is only returning strings that contain letters, spaces, hyphens and apostrophes" do
        expect(verify_name("Al' Laeson-li")).not_to match(/[^a-zA-z' \-]/)
    end 
end 

describe "check_phone" do 
    it "checks that chec_phone method is only returning a string with numbers contained inside." do
        expect(check_phone('0407264036')).not_to match(/[^0-9]/)
    end 
end 

describe "generate odds method" do 
    it "takes range and fighter_score returns the odds as a floating point number" do 
        expect(generate_odds(35.0, 16.0)).to be_a_kind_of(Float)
    end 

    it "the range and the fighter score should never produce results outside of the minimum odds (1.10) and the highest potential odds (4.33)" do 
        expect(generate_odds(39.0, 30.0)).to be_between(1.10, 4.33)
        expect(generate_odds(39.0, 9.0)).to be_between(1.10, 4.33)
    end 
end 


describe "fighting method" do 
    let(:fighter_1) {Fighter.new} 
    let(:fighter_2) {Fighter.new} 
    it "fighting method should take fighter objects and return one of them as the winner" do
        expect(fighting(fighter_1, fighter_2, fighter_1)).to be(fighter_1).or be(fighter_2) 
    end 
end 