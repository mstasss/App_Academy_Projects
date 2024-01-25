require 'singleton'

class Piece
  attr_reader :color, :board
  attr_accessor :pos, :pieces

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def symbol
    nil #returns nil for NullPiece
  end

  def moves(new_row,new_col)
    #this class will inherit from subclasses
    raise NotImplementedError, "This method should be overridden in the subclass."
  end

  def move_into_check?(end_pos)
    temp_board = board.dup
    temp_board.move_piece!(self.pos, end_pos)
    temp_board.in_check?(self.color)
  end

  def valid_moves
    raise "That is not a piece. Select one of your pieces to move" if moves.nil?
    moves.reject do |pos|
      move_into_check?(pos)
    end
  end

  def dup_with_new_board(new_board)
    self.class.new(self.color, new_board, self.pos.dup)
  end

end


