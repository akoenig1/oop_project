require_relative 'row'
require_relative 'colorize_text'
require_relative 'codebreaker'

#Menu logic
puts ("-"*80)
puts "WELCOME TO MASTERMIND!".center(80)
puts ("-"*80)

loop do 
    puts ""
    puts "Welcome to Mastermind. Select an option below."
    puts "[1] Start Game"
    puts "[2] How to Play"
    puts "[3] Exit"
    puts ""
    print "Choice: "
    selection = gets.chomp
    #Codebreaker Game Mode
    if selection == "1"
        codebreaker
    #Print How to Play
    elsif selection == "2"
        how_to_text = open("how_to_play.txt")
        puts how_to_text.read.center(80)
    #Quit Game
    elsif selection == "3"
        puts "Thanks for playing. See you next time."
        return
    #Invalid Input Handler
    else
        puts "Invalid input. Please enter 1, 2, or 3."
    end
end