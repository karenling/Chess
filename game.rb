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
    @board.render
    puts "Lets play! Positions should be entered e.g. 'A7'".colorize(:green)
    i = 0
    while !@board.checkmate?("white") && !@board.checkmate?("black")
      player = (i % 2 == 0 ? @player1 : @player2)
      player.play_turn(@board)
      i += 1
    end

    if @board.checkmate?("white")
      puts "#{@player1.color.capitalize} is checkmated, #{@player2.color.capitalize}, you win!".colorize(:light_magenta)
    else
      puts "#{@player2.color.capitalize} is checkmated, #{@player1.color.capitalize}, you win!".colorize(:light_magenta)
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
      board.selected = [7, 0]
    else
      board.selected = [0, 0]
    end
    board.render

    begin


      # puts "From where:"
      # response_start = gets.chomp #A7
      # puts "To where:"
      # response_end = gets.chomp # A5
      #
      # convert = {
      #   "A" => 0,
      #   "B" => 1,
      #   "C" => 2,
      #   "D" => 3,
      #   "E" => 4,
      #   "F" => 5,
      #   "G" => 6,
      #   "H" => 7
      # }




      error = nil
      response_start = nil
      selected_piece = nil
      until response_start
          puts error.colorize(:red) if error
          puts "Current player: #{@color}".colorize(:green)
          puts "Use awsd to select a position to start at, then press enter.".colorize(:green)
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
            if board.grid[board.selected[0]][board.selected[1]].color != @color
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
        puts error.colorize(:red) if error
        puts "Current player: #{@color}".colorize(:green)
        puts "You've selected one of your #{selected_piece.class}(s).".colorize(:green)
        puts "Use awsd to select a position to end at, then press enter.".colorize(:green)
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




      p response_start
      p response_end

      # start_second = convert[response_start[0].upcase] # A
      # start_first = 8 - response_start[1].to_i # 7
      #
      # start_pos = [start_first, start_second]
      # p start_pos
      #
      #
      # end_second = convert[response_end[0].upcase] # A
      # end_first = 8 - response_end[1].to_i # 7
      #
      # end_pos = [end_first, end_second]
      # p end_pos


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
