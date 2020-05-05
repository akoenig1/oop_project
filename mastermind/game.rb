require_relative 'row'
require_relative 'colorize_text'

# Method for computer generated code

COLORS = ["R", "G", "B", "Y", "O", "P", "M", "W" ]

def generate_code
    row = []
    for i in 0..3 do
        color_index = rand(8)
        color = COLORS[color_index]
        row[i] = Peg.new(color)
    end
    row
end

# Method to get and validate player guess

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

# Computer feedback

def give_player_feedback guess, code
    guess_array = guess.return_row.split("")
    code_array = code.return_row.split("")
    feedback_array = []
    for i in 0..3 do
        if guess_array[i] == code_array[i]
            feedback_array << "!"
            code_array[i] = ""
        elsif code_array[0..3].include?(guess_array[i])
            feedback_array << "*"
            code_array[code_array.index(guess_array[i])] = ""
        end
    end
    feedback_array.each { |fb| print fb.grey.black_text + " "}
    puts ""
    if feedback_array == ["!","!","!","!"]
        puts "CONGRATULATIONS! You cracked the code!"
        true
    else
        false
    end
end

#Codemaker Game Mode Logic
def codemaker
    #Print Game Header
    puts "-"*80
    puts "CODEMAKER".center(80)
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
        #End game if code is cracked
        if code_cracked
            break
        end
        i += 1
    end
    #End game if code is not cracked after 12 guesses
    if i == 11
        puts "GAME OVER"
        puts "You ran out of guesses and failed to crack the code."
        print "The code was: "
        print_with_color(code)
        puts "Better luck next time."
    end
end

#Menu logic
selection = 0
while selection != 3
    puts ("-"*80)
    puts "WELCOME TO MASTERMIND!".center(80)
    puts ("-"*80)
    puts "Select an option below:"
    puts "[1] START GAME"
    puts "[2] HOW TO PLAY"
    puts "[3] EXIT"
    puts ""

    valid_input = false
    while !valid_input
        print "Choice: "
        selection = gets.chomp
        if selection == "1"
            valid_input = true
        elsif selection == "2"
            how_to_text = open("how_to_play.txt")
            puts how_to_text.read.center(80)
            puts ""
            puts "Welcome to Mastermind. Select an option below."
            puts "[1] Start Game"
            puts "[2] How to Play"
            puts "[3] Exit"
            puts ""
        elsif selection == "3"
            puts "Thanks for playing. See you next time."
            return
        else
            puts "Invalid input. Please enter 1, 2, or 3."
        end
    end

    codemaker
end