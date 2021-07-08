class Piece
    attr_accessor :color, :board, :pos

    def initialize(color, board, pos)
       @color, @board, @pos = color, board, pos
    end

    def to_s

    end

    def empty?

    end

    def valid_moves

    end

    def pos=(val)

    end

    def Symbol

    end

    private

    def move_into_check?(end_pos)

    end
end