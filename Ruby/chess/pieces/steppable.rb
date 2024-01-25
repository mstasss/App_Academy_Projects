require "pry"

module Stepable
  def moves
    #binding.pry
    move_diffs.
      map{ |add| [@pos[0] + add[0], @pos[1] + add[1]]}.
      filter { |move| board.valid_pos?(move) }.
      filter { |positions| self.color != board[*positions].color }
  end
  
end

# what are we yelling at (class)
# what are we yelling (method name)
# what are the inputs (args)
# what's the output(s) (return)
# what are we doing/expecting (sudo code)
# how do we make sure it's right? (testing)

