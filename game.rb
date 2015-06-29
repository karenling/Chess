require_relative 'board'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("Alice", "white")
    @player2 = HumanPlayer.new("Jon", "black")
  end

  def play
    @board.render
    i = 0
    while !@board.checkmate?("white") && !@board.checkmate?("black")
      player = (i % 2 == 0 ? @player1 : @player2)
      player.play_turn(@board)

      @board.render

      i += 1
    end

    if @board.checkmate("white")
      puts "#{@player2.name}, you win!"
    else
      puts "#{@player1.name}, you win!"
    end
  end

end

class HumanPlayer
  attr_reader :name
  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn(board)
    begin
      puts "#{@name}, what would you like to move?"
      response_start = gets.chomp #A7
      puts "#{@name}, where would you like to move to?"
      response_end = gets.chomp # A5

      convert = {
        "A" => 0,
        "B" => 1,
        "C" => 2,
        "D" => 3,
        "E" => 4,
        "F" => 5,
        "G" => 6,
        "H" => 7
      }
      start_second = convert[response_start[0]] # A
      start_first = 8 - response_start[1].to_i # 7

      start_pos = [start_first, start_second]
      p start_pos


      end_second = convert[response_end[0]] # A
      end_first = 8 - response_end[1].to_i # 7

      end_pos = [end_first, end_second]
      p end_pos


      # response = [response_start.split("").map(&:to_i), response_end.split("").map(&:to_i)]
      # start_pos = response[0]
      # end_pos = response[1]
      board.move(start_pos, end_pos)
    rescue ArgumentError => e
      puts e.message
      retry
    end

  end
end


game = Game.new
game.play
