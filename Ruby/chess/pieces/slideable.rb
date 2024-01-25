require 'pry'
module Slideable
  HORIZONTAL_DIRS = [[0,1],[-1,0],[0,-1],[1,0]]
  DIAGONAL_DIRS = [[1,1], [-1,-1],[-1,1],[1,-1]]

  def moves
      moves = []
      if self.move_dirs.include?(:diagonal)
        moves.concat(diagonal_moves(pos))
      end
      if self.move_dirs.include?(:horizontal)
        moves.concat(horizontal_dirs(pos))
      end
      moves
        .filter { |move| board.valid_pos?(move) }
        .filter { |positions| self.color != board[*positions].color }
      moves
  end

  def get_dirs(pos,dirs)
    moves = []
    starting_row = pos[0]
    starting_col = pos[1]
    dirs.each do |(row_change,col_change)|
      new_row,new_col = starting_row + row_change,starting_col + col_change
      while board.valid_pos?([new_row,new_col])
        if self.color == board[new_row,new_col].color
          break
        end
        moves << [new_row, new_col]
        new_row += row_change
        new_col += col_change
      end
    end
    moves
  end

  def horizontal_dirs(pos)
    get_dirs(pos,HORIZONTAL_DIRS)
  end

  def diagonal_moves(pos)
    get_dirs(pos,DIAGONAL_DIRS)
  end

  #CHESSBOARD IN POSITIONS
  # [0,0] [0,1] [0,2] [0,3] [0,4] [0,5] [0,6] [0,7]
  # [1,0] [1,1] [1,2] [1,3] [1,4] [1,5] [1,6] [1,7]
  # [2,0] [2,1] [2,2] [2,3] [2,4] [2,5] [2,6] [2,7]
  # [3,0] [3,1] [3,2] [3,3] [3,4] [3,5] [3,6] [3,7]
  # [4,0] [4,1] [4,2] [4,3] [4,4] [4,5] [4,6] [4,7]
  # [5,0] [5,1] [5,2] [5,3] [5,4] [5,5] [5,6] [5,7]
  # [6,0] [6,1] [6,2] [6,3] [6,4] [6,5] [6,6] [6,7]
  # [7,0] [7,1] [7,2] [7,3] [7,4] [7,5] [7,6] [7,7]

end

# {up_left=>[1,2],[3,4]; down_left=>[3,4],[5,6]}

