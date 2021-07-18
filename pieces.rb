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
        board[pos] = val
    end
    
    def Symbol
        raise NotImplementedError
    end

    private

    def move_into_check?(end_pos)
        test_board = board.dup
        test_board.move_piece(pos, end_pos)
        test_board.in_check?(color)
    end
end