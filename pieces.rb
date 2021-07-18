require_relative 'board'

class Piece
    def initialize(color, board, pos)
        @color, board, pos = color, board, pos
    end

    def to_s
        " #{symbol} "
    end

    def empty?
        false
    end

    def valid_moves
        moves.reject { |end_pos| move_into_check?(end_pos) }
    end

    def pos=(val)

    end
    
    def Symbol

    end

    private

    def move_into_check?(end_pos)

    end
end