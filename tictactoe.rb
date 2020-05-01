require 'colorize'

class GameBoard
    attr_reader :board
    attr_accessor :valid_input, :occupied_cells

    # Create blank game board
    def initialize 
        @board = [["_","_","_"],["_","_","_"],[" "," "," "]]
        @valid_input = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
        @occupied_cells = []
        display_board
        puts "Welcome to Tic Tac Toe. Player X - you're up first!"
    end

    def play_turn player
        cell = get_user_input player
        row = cell[1].to_i - 1
        case cell[0]
        when "A"
            column = 0
        when "B"
            column = 1
        when "C"
            column = 2
        end
        self.board[row][column] = player#.underline
        display_board
        check_for_winner
    end

    private

    # Display current state of game board with column and row labels
    def display_board
        i = 1
        puts "  A   B   C "
        self.board.each do |line|
            puts "#{i} #{line[0]} | #{line[1]} | #{line[2]} "
            i += 1
        end
    end

    def get_user_input player
        valid = false
        # Ensure user input matches list of valid inputs
        until valid do
            occupied = false
            puts "Player #{player}, select a cell:"
            cell = gets.chomp
            self.valid_input.each do |input| 
                if cell == input
                    valid = true
                    break
                end
            end
            if valid
                self.valid_input.delete(cell)
                self.occupied_cells << cell
                break
            else
                # Check if invalid input because cell does not exist or because cell is already occupied
                self.occupied_cells.each do |occ_cell|
                    if cell == occ_cell
                        occupied = true
                    end
                end
                if occupied
                    puts "Cell occupied. Enter a different cell: "
                else
                    puts "Invalid input. Enter a cell in the following format: 'A1'."
                end
            end
        end
        cell
    end

    def check_for_winner
        winner = false
        
        winning_conditions = [  [self.board[0][0], self.board[0][1], self.board[0][2]],
                                [self.board[1][0], self.board[1][1], self.board[1][2]],
                                [self.board[2][0], self.board[2][1], self.board[2][2]],
                                [self.board[0][0], self.board[1][0], self.board[2][0]],
                                [self.board[0][1], self.board[1][1], self.board[2][1]],
                                [self.board[1][2], self.board[1][2], self.board[2][2]],
                                [self.board[0][0], self.board[1][1], self.board[2][2]],
                                [self.board[2][0], self.board[1][1], self.board[0][2]], ]
        
        winning_conditions.each do |condition|
            if condition.all? { |cell| cell == "X" }
                puts "Three in a row! Player X wins!"
                winner = true
                break
            elsif
                condition.all? { |cell| cell == "O" }
                puts "Three in a row! Player O wins!"
                winner = true
                break
            end
        end
        winner
    end
end

new_game = GameBoard.new
i = 0
loop do
    if i.even?
        if new_game.play_turn("X") 
            break
        end
    else
        if new_game.play_turn("O") 
            break
        end
    end
    i += 1
    if i >= 9
        puts "It's a draw."
        break
    end
end
