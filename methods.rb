

# checks if name input provided is an empty string, or if it's got characters that aren't letters, hyphens, apostrophes, spaces. 
def verify_name(name) 
    verified = false  
    while verified == false
        if !name.count("^a-zA-Z' \-").zero? || name.empty?
            puts "Please enter a valid name, using only letters, hyphens and apostrophes"
            name = gets.strip
        else 
            verified = true 
        end 
    end 
    name 
end 

#checks whether the phone number is a valid mobile number
def check_phone(phone_number) 
    verified = false
    while verified == false
        if !phone_number.count("^0-9").zero? || phone_number.empty? || phone_number.size != 10 || !phone_number.start_with?("04", "05")  
            puts "Please enter a valid 10 digit mobile phone number beginning with 04 or 05"
            phone_number = gets.gsub(/\s+/, "")
        else
            verified = true
        end
    end
    phone_number
end

def generate_odds(range, fighter_score)
    if (range / fighter_score).round(2) < 1.10 
        return 1.10  
    else
        return (range / fighter_score).round(2)  
    end 
end 

def place_bet 

    if $user.account_balance == 0 
        puts "You have no credit on your account. Please make a deposit to place a bet." 
    elsif $fight_card.size == 0 
        puts "There are no upcoming fights to place bets on."
    else  
        fight_options = []
        $fight_card.each do |i| 
            fight_options.push("#{i[0].full_name} VS #{i[1].full_name}")  

        prompt = TTY::Prompt.new
        fight_select = prompt.select("Which upcoming fight would you like to bet on?", [fight_options, "Back"])
        
        fight =  {} 
        counter = 0 
        while counter < $fight_card.size      
            if fight_select.include? $fight_card[counter][0].full_name
                fight[:fight_card_index] = counter 
                fight[:fighter_1] = $fight_card[counter][0]
                fight[:fighter_2] = $fight_card[counter][1]
                range = fight[:fighter_1].fighter_score + fight[:fighter_2].fighter_score
                fight[:fighter_1_odds] = generate_odds(range, fight[:fighter_1].fighter_score)  
                fight[:fighter_2_odds] = generate_odds(range, fight[:fighter_2].fighter_score) 
            end 
            counter += 1 
        end 
    end         
end 