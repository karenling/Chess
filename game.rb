require_relative 'board'
require 'io/console'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("white")
    @player2 = HumanPlayer.new("black")
  end

  def play
    puts "Lets play! Positions should be entered e.g. 'A7'".colorize(:green)
    i = 0
    while !@board.checkmate?("white") && !@board.checkmate?("black")
      player = (i % 2 == 0 ? @player1 : @player2)
      player.play_turn(@board)
      i += 1
    end

    if @board.checkmate?("white")
      puts ""
      puts "#{@player1.color.capitalize} is checkmated, #{@player2.color.capitalize}, you win!".center(62).colorize(:cyan)
      puts ""
    else
      puts ""
      puts "#{@player2.color.capitalize} is checkmated, #{@player1.color.capitalize}, you win!".center(62).colorize(:light_magenta)
      puts ""
    end
  end
end

class HumanPlayer
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def play_turn(board)
    p @color
    if @color == "white"
      board.cursor_color = :light_magenta
      board.selected = [7, 0]
    else
      board.cursor_color = :cyan
      board.selected = [0, 0]
    end
    board.render

    begin
      error = nil
      response_start = nil
      selected_piece = nil
      until response_start
          if error
            puts ""
            puts error.center(62).colorize(:red)
          end
          puts ""
          puts "Current player: #{@color}".center(62).colorize(board.cursor_color)
          puts "Use a/w/s/d to select a chess piece, then press enter.".center(62).colorize(board.cursor_color)
          input = $stdin.getch
          case input
          when "q"
            exit
          when "w"
            if (board.selected[0] - 1) >= 0
              board.selected = [board.selected[0] - 1, board.selected[1]]
            end
          when "a"
            if (board.selected[1] -1) >= 0
              board.selected = [board.selected[0], board.selected[1] - 1]
            end
          when "s"
            if (board.selected[0] + 1) < 8
              board.selected = [board.selected[0] + 1, board.selected[1]]
            end
          when "d"
            if (board.selected[1] + 1) < 8
              board.selected = [board.selected[0], board.selected[1] + 1]
            end
          when "\r"
            if board.grid[board.selected[0]][board.selected[1]].nil?
              error = "Please select a piece."
            elsif board.grid[board.selected[0]][board.selected[1]].color != @color
              error = "Not your color!"
            else
              response_start = board.selected
              selected_piece = board.grid[board.selected[0]][board.selected[1]]
            end
          end

          board.render
      end

      error = nil
      response_end = nil
      until response_end
        if error
          puts ""
          puts error.center(62).colorize(:red)
        end
        puts ""
        puts "Current player: #{@color}".center(62).colorize(board.cursor_color)
        puts "You've selected one of your #{selected_piece.class}(s).".center(62).colorize(board.cursor_color)
        puts "Use a/w/s/d to select ending position, then press enter.".center(62).colorize(board.cursor_color)
        input = $stdin.getch
        case input
        when "q"
          exit
        when "w"
          board.selected = [board.selected[0] - 1, board.selected[1]]
        when "a"
          board.selected = [board.selected[0], board.selected[1] - 1]
        when "s"
          board.selected = [board.selected[0] + 1, board.selected[1]]
        when "d"
          board.selected = [board.selected[0], board.selected[1] + 1]
        when "\r"
          response_end = board.selected
        end
        board.render
      end

      board.move(response_start, response_end)

      board.render
    rescue ArgumentError => e
      puts "#{e.message} Please try again."
      retry
    end

  end
end

game = Game.new
game.play
