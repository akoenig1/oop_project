#Constants
COLORS = ["R", "G", "B", "Y", "O", "P", "M", "W" ]

#Get and validate user code
def get_player_code
    #Reset global variables
    $correct_positions = ["", "", "", ""]
    $correct_colors = ["", "", "", ""]
    
    puts "Enter your code: " + "R".red.black_text + "G".green.black_text +
    "B".blue.black_text + "Y".yellow.black_text + "O".orange.black_text + 
    "P".purple.black_text + "M".magenta.black_text + "W".white.black_text
    
    valid_input = false
    until valid_input
        player_code = gets.chomp.split("")
        valid_input = player_code.all? { |color| COLORS.include?(color) } && (player_code.length == 4)
        if !valid_input
            puts "Invalid input. Please enter your guess in the format 'RGBY'."
        end
    end
    
    row = []
    player_code.each_with_index { |color, i|  row[i] = Peg.new(color) }
    row
end

#Randomly generate computer's guess for this round
def generate_guess
    row = []
    j = 0
    for i in 0..3 do
        unless $correct_positions[i] == ""
            color = $correct_positions[i]
        else
            if $correct_colors[j] != ""
                color = $correct_colors[j]
                $correct_colors[j] = ""
                j += 1
            else
                color_index = rand(8)
                color = COLORS[color_index]
            end
        end
        row[i] = Peg.new(color)
    end
    row
end

#Give feedback to computer's most recent guess
def give_computer_feedback guess, code
    #Retrieve peg colors from row objects and store in arrays
    guess_array = guess.return_row.split("")
    code_array = code.return_row.split("")
    #Initialize empty array to put feedback in
    feedback_array = []
    
    #Compare each computer guess peg color to that of the player's code
    for i in 0..3 do
        #If correct color in correct position, add '!' to feedback array
        #and remove that color from the code array so it is not counted again
        if guess_array[i] == code_array[i]
            feedback_array << "!"
            code_array[i] = ""
            $correct_positions[i] = guess_array[i]
        end
    end
    for i in 0..3 do
        #If correct color but not in correct position, add '*' to feedback
        #array and remove that color from the code array so it is not counted
        #again
        if (code_array[0..3].include?(guess_array[i])) && ($correct_positions[i] == "")
            feedback_array << "*"
            code_array[code_array.index(guess_array[i])] = ""
            $correct_colors << guess_array[i]
        end
    end
    
    #Print stylized feedback array
    feedback_array.each { |fb| print fb.grey.black_text + " "}
    puts ""
    
    #Indicate if guess was fully correct or not
    if feedback_array == ["!","!","!","!"]
        puts "Not this time! The computer cracked your code!"
        true
    else
        false
    end
end

def codemaker
    #Print Game Header
    puts "-"*80
    puts "CODEMAKER".center(80)
    puts "-"*80
    puts ""

    #Get Player Code
    code = Row.new(get_player_code)
        
    #Guessing Loop (12 Rounds)
    i = 0
    code_cracked = false
    while i < 12
        sleep 0.5
        puts "GUESS ##{i+1} OF 12"
        guess = Row.new(generate_guess)
        puts "Your Code: "
        print_with_color(code)
        puts "Computer Guess: "
        print_with_color(guess)
        puts "Feedback: "
        code_cracked = give_computer_feedback(guess, code)
        puts ""
        #End game if code is cracked
        if code_cracked
            break
        end
        i += 1
    end
    #End game if code is not cracked after 12 guesses
    if i == 12
        puts "GAME OVER! YOU WIN!"
        puts "The computer ran out of guesses and failed to crack your code."
        puts "Nice job! You know they could use someone like you at the CIA."
    end
end

