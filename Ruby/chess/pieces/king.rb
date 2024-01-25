require_relative 'steppable.rb'
require_relative 'piece.rb'

class King < Piece
  include Stepable

  def move_diffs
    [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,0],[1,1],[1,-1]]
  end

  # def moves

  #   # what are we yelling at (class)
  #   # what are we yelling (method name)
  #   # what are the inputs (args)
  #   # what's the output(s) (return)
  #   # what are we doing/expecting (sudo code)
  #   # how do we make sure it's right? (testing)
  # end

  def to_s
    if color == :white
      return " ♔ "
    else
      " ♚ "
    end
  end

end