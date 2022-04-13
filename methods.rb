

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
def check_phone 
    puts "Please enter a 10 digit mobile number beginning with 04 or 05"
    phone_number = gets.gsub(/\s+/, "")
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