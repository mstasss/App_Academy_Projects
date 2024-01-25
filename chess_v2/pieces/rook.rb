require_relative 'piece.rb'
require_relative 'slideable.rb'


class Rook < Piece
  include Slideable
  def move_dirs
    [:horizontal]
  end

  def symbol
     return :R
  end

  def to_s
    if color == :white
      return " ♖ "
    else
      " ♜ "
    end
  end

end