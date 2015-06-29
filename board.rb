require_relative 'piece'
# require_relative 'knight'
require_relative 'stepping_piece'
require_relative 'pawn'
# require_relative 'king'
require_relative 'sliding_piece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'

class Board

  def initialize
    @grid = Board.setup_grid
    # @pawn = Pawn.new([0, 0])
    # add_piece(@pawn)
  # p  @pawn.moves
    # @piece = Piece.new
    # @slidingpiece = SlidingPiece.new
    # @rook = Rook.new
    # @slidingpiece = SlidingPiece.new
    # @rook = Rook.new
  end

  def in_check?(color)
    # returns whether a player is in check
    # You can implement this by (1) finding the position of the king on the board then (2) seeing if any of the opposing pieces can move to that position.
  end

  def move(start, end_pos)
    # updates the 2d grid and also the moved piece's position. You'll want to raise an exception if: (a) there is no piece at start or (b) the piece cannot move to end_pos.
  end

  def self.setup_grid
    grid = Array.new(8) { Array.new(8) }


    grid[0][0] = Rook.new(self, [0, 0], "black")
    grid[0][7] = Rook.new(self, [0, 7], "black")
    grid[0][2] = Bishop.new(self, [0, 2], "black")
    grid[0][5] = Bishop.new(self, [0, 5], "black")
    grid[0][3] = Queen.new(self, [0, 3], "black")

    grid[7][0] = Rook.new(self, [7, 0], "white")
    grid[7][7] = Rook.new(self, [7, 7], "white")
    grid[7][2] = Bishop.new(self, [7, 2], "white")
    grid[7][5] = Bishop.new(self, [7, 5], "white")
    grid[7][3] = Queen.new(self, [7, 3], "white")

    # pawn_rows = [1, 6]
    # pawn_cols = (0..7).to_a
    #
    # pawn_rows.each do |row|
    #   pawn_cols.each do |col|
    #     color = "black"
    #     if row == 6
    #       color = "white"
    #     end
    #
    #     grid[row][col] = Pawn.new(self, [row, col], color)
    #     p grid[row][col].moves
    #   end
    # end

    grid
  end

  def add_piece(piece)
    @grid[piece.pos[0]][piece.pos[1]] = piece
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
# board.render
# board.rook.move_dirs
