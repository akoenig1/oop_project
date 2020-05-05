require_relative 'row'
require_relative 'colorize_text'
require_relative 'codebreaker'
require_relative 'codemaker'

#Menu logic
puts ("-"*80)
puts "WELCOME TO MASTERMIND!".center(80)
puts ("-"*80)

loop do 
    puts ""
    puts "Welcome to Mastermind. Select an option below."
    puts "[1] New Codebreaker Game"
    puts "[2] New Codemaker Game"
    puts "[3] How to Play"
    puts "[4] Exit"
    puts ""
    print "Choice: "
    selection = gets.chomp
    #Codebreaker Game Mode
    if selection == "1"
        codebreaker
    #Codemaker Game Mode
    elsif selection == "2"
        codemaker
    #Print How to Play
    elsif selection == "3"
        how_to_text = open("how_to_play.txt")
        puts how_to_text.read.center(80)
    #Quit Game
    elsif selection == "4"
        puts "Thanks for playing. See you next time."
        return
    #Invalid Input Handler
    else
        puts "Invalid input. Please enter 1, 2, 3 or 4."
    end
end