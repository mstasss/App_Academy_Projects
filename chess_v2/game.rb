require_relative 'board.rb'
require_relative 'cursor.rb'
require_relative './players/humanPlayer.rb'

class Game
    attr_reader :board, :display, :current_player, :players

    def initialize
      @board = Board.new
      @display = Display.new(@board)
      @players = {
          white: HumanPlayer.new(:white, @display),
          black: HumanPlayer.new(:black, @display)
      }
      @current_player = :white
    end

    def play
      until board.checkmate?(current_player)
        begin
          start_pos, end_pos = players[current_player].make_move(board)
          board.move_piece(start_pos, end_pos)
          swap_turn!

        rescue RuntimeError => e
          puts "Error: #{e.message}"
          sleep(1.5)
        end
      end
      swap_turn!
      puts "Game Over, #{current_player} wins"
    end

  private

    def notify_players
        puts "it's #{@current_player}'s turn"
    end

    def swap_turn!
        @current_player = current_player == :white ? :black : :white
    end

    if $PROGRAM_NAME == __FILE__
      puts "yay"
      Game.new.play
    end


end