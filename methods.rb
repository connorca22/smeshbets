

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