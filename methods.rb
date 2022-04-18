

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
    #identifies if user account balance is insufficient, or if there are no fights and exits. 
    if $user.account_balance < 1.0 
        puts "You do not have sufficient credit on your account. Please make a deposit to place a bet." 
    elsif $fight_card.size == 0 
        puts "There are no upcoming fights to place bets on."
    else  
        #creates fight options to pass to tty prompt based on contents of $fight_card 
        fight_options = []
        $fight_card.each do |i| 
            fight_options.push("#{i[0].full_name} VS #{i[1].full_name}")  
        end 
        prompt = TTY::Prompt.new
        fight_select = prompt.select("Which upcoming fight would you like to bet on?", [fight_options, "Back"])
        
        #creates a fight hash which will store the selected fighters, their odds, and their index in $fight_card.
        #then populates it with relevant data based on user's fight_select pick 
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

        #creates a hash that we'll pass to tty prompt object to choose between the two fighters
        fighter_options = [
            {name: "#{fight[:fighter_1].full_name} at #{fight[:fighter_1_odds]} to 1", value: 1},
            {name: "#{fight[:fighter_2].full_name} at #{fight[:fighter_2_odds]} to 1", value: 2}
        ] 
        fighter_choice = prompt.select("Which upcoming fight would you like to bet on?", [fighter_options, "Back"])  
        
        #identifies the user's choice and stores their choice in fight hash. 
        if fighter_choice == 1 
            fight[:fighter_selection] = fight[:fighter_1]
            fight[:fighter_selection_odds] = fight[:fighter_1_odds]
        elsif fighter_choice == 2 
            fight[:fighter_selection] = fight[:fighter_2]
            fight[:fighter_selection_odds] = fight[:fighter_2_odds]
        end 

        #requests wager amount, if it exceeds account balance or is outside of the valid range it will exit back to start menu
        #otherwise if will continue execution in a nested if statement. 
        wager_amount = prompt.ask("Enter dollar value of bet between $1 and $10,000", convert: :float) do |q|
            q.convert(:float, "%{value} is not a valid bet amount. Please enter a dollar value of bet using only numbers")
        end

        if wager_amount > $user.account_balance 
            puts "You do not have sufficient funds in your account to place this bet"
        elsif wager_amount > 10000 || wager_amount < 1 
            puts "You can only place bets between $1 and $10,000"
        else 
            betslip = {
                :id => $user.bet_history.size, 
                :fighter_selected => fight[:fighter_selection],
                :wager => wager_amount,
                :odds => fight[:fighter_selection_odds],
                :won => false
            }
            $user.bet_history.push(betslip)
            $user.account_balance -= betslip[:wager]
        end 
        if fighting(fight[:fighter_1], fight[:fighter_2]) == betslip[:fighter_selected]
            $user.account_balance += (betslip[:wager] * betslip[:odds])     #this updates the account balance if they won. 
            $user.bet_history[betslip[:id]][:won] = true    #this updates the won key to true if they won 
            $fight_card.delete_at(fight[:fight_card_index])  #deletes the relevant $fight_card array. 
        end 
        $fight_card.delete_at(fight[:fight_card_index])
        puts "account balance: #{$user.account_balance}. bet_history/betslip won #{$user.bet_history[betslip[:id]][:won]}. fight card size: #{$fight_card.size}"
    end         
end 




def fighting(fighter_1, fighter_2)
    return fighter_1
end 

