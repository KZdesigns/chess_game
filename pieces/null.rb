require 'singleton'
require_relative 'piece'

class NullPiece < Piece
    include Singleton
    attr_accessor :color, :board, :pos
    
    def initialize
        
    end

    def moves

    end

    def symbol

    end
end