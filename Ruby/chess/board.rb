require_relative './pieces/bishop.rb'
require_relative './pieces/king.rb'
require_relative './pieces/knight.rb'
require_relative './pieces/nullpiece.rb'
require_relative './pieces/pawn.rb'
require_relative './pieces/piece.rb'
require_relative './pieces/queen.rb'
require_relative './pieces/rook.rb'
require_relative './pieces/slideable.rb'
require_relative './pieces/steppable.rb'


class Board

  attr_accessor :pieces, :rows, :board

  LENGTH = 8

  def initialize
    @np = NullPiece.instance()
    @board = Array.new(8) { Array.new(LENGTH, @np) }
    self.place_pieces
  end

  def place_non_pawns_row(color)
    row_i = color == :white ? 0 : 7
    order = ["Rook","Knight","Bishop","King","Queen","Bishop","Knight","Rook"]
    order.each_with_index do |piece_type,i|
      position = [row_i,i]
      piece_class = Kernel.const_get(piece_type)
      @board[row_i][i] = piece_class.new(color,self,position)
    end
  end

  def place_pawns_row(color)
    row_i = color == :white ? 1 : 6
    8.times do |i|
      position = [row_i,i]
      @board[row_i][i] = Pawn.new(color,self,position)
    end
  end

  def place_pieces
    [:black,:white].each do |color|
      self.place_non_pawns_row(color)
      self.place_pawns_row(color)
    end
  end

  def board
    @board.each do |row|
      p row
    end
  end

  def move_piece(start_pos, end_pos)
    raise "that's not a valid move" unless self[*start_pos].valid_moves.include?(end_pos)
    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    raise 'thats not a valid position' if start_pos.nil? || valid_pos?(end_pos) == false
    self[*end_pos] = self[*start_pos]
    self[*start_pos] = @np
    self[*end_pos].pos = end_pos
  end

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, value)
    @board[row][col] = value
  end

  def valid_pos?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def length
    LENGTH
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    @board.flatten.any? do |piece|
      piece.color != color && piece.is_a?(Piece) && piece.moves&.include?(king_pos)
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)

    if find_king(color).valid_moves.empty?
      "Game over"
    end
  end

  def find_king(color)
    @board.each do |row|
      row.each do |piece|
        return piece if piece.color == color && piece.is_a?(King)
      end
    end
    raise 'King not found?'
  end

  def dup
    new_board = Board.new
    @board.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        next if piece.is_a?(NullPiece)
        new_board[row_idx, col_idx] = piece.dup_with_new_board(new_board)
      end
    end
    new_board
  end

  def empty?(*args)
    pos = args.length == 1 ? args[0] : args
    row, col = pos
    self[row, col].is_a?(NullPiece)
  end

  attr_reader :board

end
