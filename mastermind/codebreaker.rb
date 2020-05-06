#Constants
COLORS = ["R", "G", "B", "Y", "O", "P", "M", "W" ]

#Randomly generate computer's code for this game
def generate_code
    row = []
    for i in 0..3 do
        color_index = rand(8)
        color = COLORS[color_index]
        row[i] = Peg.new(color)
    end
    row
end

#Get and validate user guess
def get_player_guess
    puts "Enter your guess: " + "R".red.black_text + "G".green.black_text +
    "B".blue.black_text + "Y".yellow.black_text + "O".orange.black_text + 
    "P".purple.black_text + "M".magenta.black_text + "W".white.black_text
    
    valid_input = false
    until valid_input
        player_guess = gets.chomp.split("")
        valid_input = player_guess.all? { |color| COLORS.include?(color) } && (player_guess.length == 4)
        if !valid_input
            puts "Invalid input. Please enter your guess in the format 'RGBY'."
        end
    end
    
    row = []
    player_guess.each_with_index { |color, i|  row[i] = Peg.new(color) }
    row
end

#Give feedback to player's most recent guess
def give_player_feedback guess, code
    #Retrieve peg colors from row objects and store in arrays
    guess_array = guess.return_row.split("")
    code_array = code.return_row.split("")
    #Initialize empty array to put feedback in
    feedback_array = []
    
    #Compare each user guess peg color to that of the computer's code
    for i in 0..3 do
        #If correct color in correct position, add '!' to feedback array
        #and remove that color from the code array so it is not counted again
        if guess_array[i] == code_array[i]
            feedback_array << "!"
            code_array[i] = ""
        #If correct color but not in correct position, add '*' to feedback
        #array and remove that color from the code array so it is not counted
        #again
        elsif code_array[0..3].include?(guess_array[i])
            feedback_array << "*"
            code_array[code_array.index(guess_array[i])] = ""
        end
    end
    
    #Print stylized feedback array
    feedback_array.each { |fb| print fb.grey.black_text + " "}
    puts ""
    
    #Indicate if guess was fully correct or not
    if feedback_array == ["!","!","!","!"]
        puts "CONGRATULATIONS! You cracked the code!"
        true
    else
        false
    end
end

#Codebreaker Game Mode Logic
def codebreaker
    #Print Game Header
    puts "-"*80
    puts "CODEBREAKER".center(80)
    puts "-"*80
    puts ""

    #Generate Code
    code = Row.new(generate_code)
    
    #Guessing Loop (12 Rounds)
    i = 0
    code_cracked = false
    while i < 12
        puts "GUESS ##{i+1} OF 12"
        guess = Row.new(get_player_guess)
        puts "Your Guess: "
        print_with_color(guess)
        puts "Feedback: "
        code_cracked = give_player_feedback(guess, code)
        puts ""
        #End game if code is cracked
        if code_cracked
            break
        end
        i += 1
    end
    #End game if code is not cracked after 12 guesses
    if i == 12
        puts "GAME OVER"
        puts "You ran out of guesses and failed to crack the code."
        print "The code was: "
        print_with_color(code)
        puts "Better luck next time."
    end
end