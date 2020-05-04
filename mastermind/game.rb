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

# Gameplay logic
selection = 0
while selection != 3
    puts ("-"*60)
    puts "WELCOME TO MASTERMIND!".center(60)
    puts ("-"*60)
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
            puts "HOW TO PLAY:
            
    Mastermind is a game of cunning and wit. The objective is simple - 
    the computer has a code and you have to break it. 

    The code consists of 4 colors in a specific order. Your goal is to guess the 
    colors in their exact order. The colors can be any one of 8 colors available
    for the computer to choose from which are as follows:
        - Red
        - Green
        - Blue
        - Yellow
        - Orange
        - Purple
        - Magenta
        - White
    The computer is allowed to repeat colors in the code, so theoretically the code
    could just be four of the same color. You will have to figure it out for yourself.

    To submit a guess, simply type in the first letter of each color, in the order you
    believe they're arranged in the code, in the format 'RGBY', then hit Enter.

    After each guess, the computer will give you feedback about how accurate your guess
    was. For each correct color, the computer will print a '*'. However if you guess the
    correct color in the correct position, the computer will print a '!'. The computer 
    will not print anything for incorrect colors. 

    As an example, if the code were 'RGBY' and you guessed 'RBWW', the computer would 
    print a '!' for correctly guessing Red in the first position, and a '*' for correctly
    guessing that there is a Blue in the code, but not getting the position right. You
    can then use that feedback to influence your next guess.

    You will be given 12 guesses to crack the code. If you match the code exactly on any
    one of those guesses, you win! But if you fail to get it after 12 guesses, you lose :(
        
    Good Luck!"

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

    puts "-"*60
    puts "CODEMAKER".center(60)
    puts "-"*60
    puts ""
    code = Row.new(generate_code)
    i = 0
    while i < 12
        puts "GUESS ##{i+1} OF 12"
        guess = Row.new(get_player_guess)
        puts "Your Guess: "
        print_with_color(guess)
        puts "Feedback: "
        if give_player_feedback guess, code
            break
        end
        i += 1
    end
    if i == 11
        puts "GAME OVER"
        puts "You ran out of guesses and failed to crack the code."
        print "The code was: "
        print_with_color(code)
        puts "Better luck next time."
    end
end