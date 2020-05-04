require_relative 'peg'

class Row
    
    def initialize peg_array
        @peg_array = peg_array
    end

    def return_row
        row = @peg_array.map do |peg| 
            peg.color
        end.join("")
        row
    end

end