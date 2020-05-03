require_relative 'row'

# Computer generated code

COLORS = ["R", "G", "B", "Y", "O", "P", "M", "W" ]

def generate_row
    row = []
    for i in 0..3 do
        color_index = rand(8)
        color = COLORS[color_index]
        row[i] = Peg.new(color)
    end
    row
end

code = Row.new(generate_row)

# User guesses

def get_player_guess
    puts "Enter your guess:"
    valid_input = false
    until valid_input
        player_guess = gets.chomp.split("")
        valid_input = player_guess.all? { |color| COLORS.include?(color) } && (player_guess.length == 4)
        if !valid_input
            puts "Invalid input. Please enter your guess in the format 'RGBY'."
        end
    end
    player_guess
end

# Computer feedback


# Gameplay logic

get_player_guess
#code.print_row