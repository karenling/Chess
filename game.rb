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
      response_start = gets.chomp
      puts "#{@name}, where would you like to move to?"
      response_end = gets.chomp # gives 1, 2
      response = [response_start.split(",").map(&:to_i), response_end.split(",").map(&:to_i)]
      start_pos = response[0]
      end_pos = response[1]
      board.move(start_pos, end_pos)
    rescue ArgumentError => e
      puts e.message
      retry
    end

  end
end


game = Game.new
game.play
