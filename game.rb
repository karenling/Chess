require_relative 'board'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("Alice", "white")
    @player2 = HumanPlayer.new("Jon", "black")
  end

  def play
    while !@board.checkmate?("white") && !@board.checkmate?("black")
      response = @player1.play_turn
      start_pos = response[0]
      end_pos = response[1]
      @board.move(start_pos, end_pos)

      @board.render
    end
  end

end

class HumanPlayer
  attr_reader :name
  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn
    puts "#{@name}, what would you like to move?"
    response_start = gets.chomp
    puts "#{@name}, where would you like to move to?"
    response_end = gets.chomp # gives 1, 2

    return [response_start.split(",").map(&:to_i), response_end.split(",").map(&:to_i)]
  end
end


game = Game.new
game.play
