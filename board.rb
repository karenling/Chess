require_relative 'piece'
require_relative 'knight'
require_relative 'stepping_piece'
require_relative 'pawn'
require_relative 'king'
require_relative 'sliding_piece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'

class Board

  def initialize
    @grid = Board.setup_grid
    @piece = Piece.new
    @slidingpiece = SlidingPiece.new
    # @slidingpiece = SlidingPiece.new
    # @rook = Rook.new
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
p board
# board.render
# board.rook.move_dirs
