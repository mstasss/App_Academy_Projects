require_relative 'piece.rb'

WHITE_SIDE_ATTACKS = [[1,-1],[1,1]]
BLACK_SIDE_ATTACKS = [[-1,-1],[-1,1]]

class Pawn < Piece
  def symbol
    return :P
  end

  def moves
    forward_steps + side_attacks
  end

  def to_s
    if color == :white
      return " ♙ "
    else
      " ♟️ "
    end
  end

  private

  def at_start_row?
    (color == :white && pos[0] == 1) || (color == :black && pos[0] == 6)
  end

  def forward_dir
    color == :white ? 1 : -1
  end

  def forward_steps
    i, j = pos
    one_step = [i + forward_dir, j]
    steps = []
    steps << one_step if board.empty?(one_step) && board.valid_pos?(one_step)

    if at_start_row?
      two_step = [i + 2 * forward_dir, j]
      steps << two_step if board.empty?(two_step) && board.valid_pos?(two_step)
    end

    steps
  end

  def side_attacks
    i, j = pos
    moves = []

    attack_dirs = color == :black ? BLACK_SIDE_ATTACKS : WHITE_SIDE_ATTACKS
    attack_dirs.each do |(row_change, col_change)|
      new_pos = [i + row_change, j + col_change]
      next unless board.valid_pos?(new_pos) # This unpacks new_pos into two arguments

      next if board.empty?(*new_pos)
      moves << new_pos if board[*new_pos].color != color
    end

    moves
  end

end