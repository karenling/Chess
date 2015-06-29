require_relative 'piece'
require_relative 'stepping_piece'
require_relative 'knight'
require_relative 'king'
require_relative 'sliding_piece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'pawn'

class Board
  attr_reader :grid

  def initialize
    @grid = setup_grid

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

    #find the king

    # get all opposing pieces
    king = nil
    pieces = []
     @grid.each do |row|
      row.each do |piece|
        if piece && piece.color === color && piece.is_a?(King)
          king = piece
        end
        if piece && piece.color != color
          pieces << piece
        end
      end
    end

    pieces.each do |piece|
      if piece.moves
        piece.moves.each do |position|
          if king.pos === position
            return true
          end
        end
      end
    end

    return false
  end

  def move(start, end_pos)
    # updates the 2d grid and also the moved piece's position. You'll want to raise an exception if: (a) there is no piece at start or (b) the piece cannot move to end_pos.
    starting_piece = @grid[start[0]][start[1]]

    if starting_piece.nil?
      raise ArgumentError, "You didn't select a piece"
    elsif !starting_piece.moves.include?(end_pos)
      raise ArgumentError, "Not a valid move."
    else

      @grid[end_pos[0]][end_pos[1]] = starting_piece
      @grid[end_pos[0]][end_pos[1]].pos = end_pos
      @grid[start[0]][start[1]] = nil
    end

  end

  def setup_grid

    grid = Array.new(8) { Array.new(8) }


    grid[0][0] = Rook.new(self, [0, 0], "black")
    grid[0][1] = Knight.new(self, [0, 1], "black")
    grid[0][2] = Bishop.new(self, [0, 2], "black")
    grid[0][3] = Queen.new(self, [0, 3], "black")
    grid[0][4] = King.new(self, [0, 4], "black")
    grid[0][5] = Bishop.new(self, [0, 5], "black")
    grid[0][6] = Knight.new(self, [0, 6], "black")
    grid[0][7] = Rook.new(self, [0, 7], "black")


    grid[7][0] = Rook.new(self, [7, 0], "white")
    grid[7][1] = Knight.new(self, [7, 1], "white")
    grid[7][2] = Bishop.new(self, [7, 2], "white")
    grid[7][3] = Queen.new(self, [7, 3], "white")
    grid[7][4] = King.new(self, [7, 4], "white")
    grid[7][5] = Bishop.new(self, [7, 5], "white")
    grid[7][6] = Knight.new(self, [7, 6], "white")
    grid[7][7] = Rook.new(self, [7, 7], "white")
    # grid[2][5] = Knight.new(self, [2, 5], "white")

    # grid[2][6] = Rook.new(self, [2, 6], "black")

# grid[5][5] = Bishop.new(self, [5, 5], "white")


    pawn_rows = [1, 6]
    pawn_cols = (0..7).to_a

    pawn_rows.each do |row|
      pawn_cols.each do |col|
        color = "black"
        if row == 6
          color = "white"
        end

        grid[row][col] = Pawn.new(self, [row, col], color)
        # p grid[row][col].moves
      end
    end

    grid
  end

  def add_piece(piece)
    @grid[piece.pos[0]][piece.pos[1]] = piece
  end



  def render
    # p grid[7][4].moves
    @grid.each do |row|
      p row
    end
  end

  def test
    p "testing"
  end

end


board = Board.new
# p board.in_check?("black")
board.move([4,7], [7,7])
board.render
# board.rook.move_dirs
