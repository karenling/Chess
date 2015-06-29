require_relative 'piece'

class Board

  def initialize
    @grid = Board.setup_grid
  end

  def self.setup_grid
    Array.new(8) { Array.new(8) { "-" }}
  end

  def render
    @grid.each do |row|
      p row
    end
  end

  def test
    p "testing"
  end

end


board = Board.new
board.render
