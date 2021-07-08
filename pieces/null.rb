require 'singleton'
require_relative 'piece'

class NullPiece < Piece
    include Singleton
    attr_accessor :color, :board, :pos
    
    def initialize
        @color = :none
    end

    def moves

    end

    def symbol

    end
end