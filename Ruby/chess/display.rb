require "colorize"
require_relative "cursor"

class Display

  attr_reader :board, :notifications, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    @notifications = {}
  end

  def build_grid
    @board.board.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if cursor.cursor_pos == [i, j] && cursor.selected
      bg = :light_green
    elsif cursor.cursor_pos == [i, j]
      bg = :red
    elsif (i + j).odd?
      bg = :dark_blue
    else
      bg = :white
    end
    { background: bg }
  end

  def reset!
    @notifications.delete(:error)
  end

  def uncheck!
    @notifications.delete(:check)
  end

  def set_check!
    @notifications[:check] = "Check!"
  end

  def render
    system("clear")
    puts "Use arrow keys or WASD keys to move. Use space or enter to confirm move."
    build_grid.each { |row| puts row.join }
    @notifications.each do |_key, val|
      puts val
    end
  end

end