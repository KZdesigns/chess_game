require_relative 'pieces' #give access to the pieces

class Board
  attr_reader :rows #give read access to the @rowws

  def initialize(fill_board = true) #initialize the board and sets fill_board to default value to true
    @sentinel = NullPiece.instance #sentinel is set to an instance of singleton class Null Piece
    make_starting_grid(fill_board) #creates the starting grid
  end

  def [](pos) #gets the position the value at a praticular position
    raise 'invalid pos' unless valid_pos?(pos) #raises error if pos in not valid

    row, col = pos #sets row and col variables
    @rows[row][col] #indexes the @rows array at the row and col
  end

  def []=(pos, piece) #sets a position on the board = to a piece
    raise 'invalid pos' unless valid_pos?(pos) #raise error if the pos is not valid

    row, col = pos #setting the row and col variable
    @rows[row][col] = piece #setting the pos to the piece
  end

  def add_piece(piece, pos) #adds a to a pos
    raise 'position not empty' unless empty?(pos) #raises error if piece is not empty

    self[pos] = piece #sets baord at pos to the piece
  end

  def checkmate?(color) #checks if the move put the other player in checkmate
    return false unless in_check?(color) #returns false if the players color is not in check

    pieces.select { |p| p.color == color }.all? do |piece| #if in check select the pieces that and see if there are any valid moves
      piece.valid_moves.empty?
    end
  end

  def dup #dup board 
    new_board = Board.new(false) #create new board sets the fill_board to false

    pieces.each do |piece| #loop through the pieces
      piece.class.new(piece.color, new_board, piece.pos) #adds the pieces to the new_board
    end

    new_board #returns the new board
  end

  def empty?(pos) #checks if a pos on the board is empty
    self[pos].empty?
  end

  def in_check?(color) #checks whether the color passed is in check
    king_pos = find_king(color).pos #finds the color pass king
    pieces.any? do |p|
      p.color != color && p.moves.include?(king_pos) #checks if any pieces of the other colors include the kinds pos if it does then in check
    end
  end

  def move_piece(turn_color, start_pos, end_pos) #moves pieces around the board
    raise 'start position is empty' if empty?(start_pos) # raises error if the start_pos is empty

    piece = self[start_pos] #if statement validates the start_pos
    if piece.color != turn_color
      raise 'You must move your own piece'
    elsif !piece.moves.include?(end_pos)
      raise 'Piece does not move like that'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'You cannot move into check'
    end

    move_piece!(start_pos, end_pos) #moves the piece
  end

  # move without performing checks
  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    raise 'piece cannot move like that' unless piece.moves.include?(end_pos) #check to make sure it's a valid move

    self[end_pos] = piece #moves the piece
    self[start_pos] = sentinel
    piece.pos = end_pos

    nil
  end

  def pieces #returns an array of pieces
    @rows.flatten.reject(&:empty?)
  end

  def valid_pos?(pos) #checks is pos is a valid pos on the board
    pos.all? { |coord| coord.between?(0, 7) }
  end

  private

  attr_reader :sentinel #give read only to sentinel

  def fill_back_row(color) #fills the back row
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ] #array of back row pieces

    i = color == :white ? 7 : 0
    back_pieces.each_with_index do |piece_class, j| #iterator to fill the back row
      piece_class.new(color, self, [i, j])
    end
  end

  def fill_pawns_row(color) #fills the pawn row
    i = color == :white ? 6 : 1
    8.times { |j| Pawn.new(color, self, [i, j]) } #iterator to fill the pawn row
  end

  def find_king(color) #method for finding the king
    king_pos = pieces.find { |p| p.color == color && p.is_a?(King) } #looks through the board and returns the king position
    king_pos || (raise 'king not found?') #return pos or raises error saying king not found
  end

  def make_starting_grid(fill_board) #makes starting grid
    @rows = Array.new(8) { Array.new(8, sentinel) } #creates grid with 8 sentinel pieces
    return unless fill_board
    %i(white black).each do |color| #for each color fill in the back row and the pawn row
      fill_back_row(color)
      fill_pawns_row(color)
    end
  end

end
