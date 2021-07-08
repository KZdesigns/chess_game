require_relative 'pieces'

class Board
 
    def initialize
        @rows = Array.new(8) { Array.new(8) }
        fill_board
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @rows[row][col] = val
    end

    def move_piece(start_pos, end_pos)
        # will need #valid move later
        raise "That is not a valid play" if self[start_pos].is_a?(NullPiece)
        self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    end


    def fill_board
        (0..7).each do |row|
            (0..7).each do |col|
                if row == 0 || row == 1 || row == 6 || row == 7
                    @rows[row][col] = Piece.new
                else 
                    @rows[row][col] = NullPiece.new
                end
            end
        end
    end


end