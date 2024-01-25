require_relative 'steppable.rb'
require_relative 'piece.rb'


class Knight < Piece
  include Stepable

    def move_diffs
      [[-2,1],[-1,2],[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1]]
    end

  def to_s
    if color == :white
      return " ♘ "
    else
      " ♞ "
    end
  end

end