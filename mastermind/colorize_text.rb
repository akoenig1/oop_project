class String
    def colorize_bg(color_code)
        "\e[48;5;#{color_code}m  #{self}  \e[0m"
    end

    def colorize_text(color_code)
        "\e[#{color_code}m#{self}\e[0m"
    end

    def red
        colorize_bg(9)
    end

    def green
        colorize_bg(28)
    end

    def blue
        colorize_bg(21)
    end

    def yellow
        colorize_bg(11)
    end

    def orange
        colorize_bg(208)
    end

    def purple
        colorize_bg(56)
    end

    def magenta
        colorize_bg(13)
    end

    def white
        colorize_bg(15)
    end

    def grey
        colorize_bg(8)
    end

    def black_text
        colorize_text(30)
    end
end

def print_with_color row
    pegs = row.return_row.split("")
    pegs.each do |peg|
        case peg
        when "R"
            print peg.red.black_text
        when "G"
            print peg.green.black_text
        when "B"
            print peg.blue.black_text
        when "Y"
            print peg.yellow.black_text
        when "O"
            print peg.orange.black_text
        when "P"
            print peg.purple.black_text
        when "M"
            print peg.magenta.black_text
        when "W"
            print peg.white.black_text
        end
        print " "
    end
    puts ""
end