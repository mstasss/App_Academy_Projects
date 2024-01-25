require_relative 'piece.rb'
require_relative 'slideable.rb'


class Bishop < Piece
  include Slideable
  def move_dirs
    [:diagonal]
  end

  def symbol
    return :B
  end

  def to_s
    if color == :white
      return " ♗ "
    else
      " ♝ "
    end
  end


end