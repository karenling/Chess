require_relative 'piece'
require_relative 'stepping_piece'
require_relative 'knight'
require_relative 'king'
require_relative 'sliding_piece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'pawn'
require 'colorize'

class Board
  attr_reader :grid
  attr_accessor :selected

  def initialize
    @grid = setup_grid
    @selected = [0, 0]

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
        if piece && piece.color == color && piece.is_a?(King)
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

  def checkmate?(color) #color = white. white is in checkmate if it has no other moves
    return if !self.in_check?(color)

    pieces = []

    @grid.each do |row|
      row.each do |piece|
        if piece && piece.color == color
          pieces << piece
        end
      end
    end

    pieces.each do |piece|
      if piece.valid_moves.count > 0
        return true
      end
    end

    return false
    # return true

  end

  def move!(start, end_pos)
    starting_piece = @grid[start[0]][start[1]]

    @grid[end_pos[0]][end_pos[1]] = starting_piece
    @grid[end_pos[0]][end_pos[1]].pos = end_pos
    @grid[start[0]][start[1]] = nil

  end


  def move(start, end_pos)
    # updates the 2d grid and also the moved piece's position. You'll want to raise an exception if: (a) there is no piece at start or (b) the piece cannot move to end_pos.
    starting_piece = @grid[start[0]][start[1]]

    # if starting_piece.move_into_check?(end_pos)

    # starting_piece.valid_moves

    p starting_piece
    p starting_piece.moves
    if starting_piece.nil?
      raise ArgumentError, "Not a valid selection"
      return
    elsif starting_piece.moves.nil?
      raise ArgumentError, "No available moves."
    elsif !starting_piece.moves.include?(end_pos)
      raise ArgumentError, "Not a valid move."
      return
    elsif !starting_piece.valid_moves.include?(end_pos)
      # p "here"
      raise "Cannot move into check"
      return
    else
      move!(start, end_pos)
    end

  end

  def dup
    duplicate_board = Board.new
    pieces = []
    @grid.each do |row|
      row.each do |piece|
        if piece
          type = piece.class
          color = piece.color
          position = piece.pos
          duplicate_board.grid[position[0]][position[1]] = type.new(duplicate_board, position, color)
          # p duplicate_board.grid[position[0]][position[1]]
        end
      end
    end

    duplicate_board
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

    #
    grid[7][0] = Rook.new(self, [7, 0], "white")
    grid[7][1] = Knight.new(self, [7, 1], "white")
    grid[7][2] = Bishop.new(self, [7, 2], "white")
    grid[7][3] = Queen.new(self, [7, 3], "white")
    grid[7][4] = King.new(self, [7, 4], "white")
    grid[7][5] = Bishop.new(self, [7, 5], "white")
    grid[7][6] = Knight.new(self, [7, 6], "white")
    grid[7][7] = Rook.new(self, [7, 7], "white")


# grid[5][4] = King.new(self, [5, 4], "white")
#     grid[4][4] = Rook.new(self, [4, 4], "black")
#     grid[5][5] = Rook.new(self, [5,5], "black")
#     grid[5][3] = Rook.new(self, [5,3], "black")
#     grid[6][4] = Rook.new(self, [6, 4], "black")

    # grid[4][4] = Rook.new(self, [4, 4], "black")
    # grid[5][5] = Rook.new(self, [5,5], "black")
    # grid[5][3] = Rook.new(self, [5,3], "black")
    # grid[6][4] = Rook.new(self, [6, 4], "black")


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
    # system 'clear'
    counter = 0
    i = 8
    @grid.each_with_index do |row, row_idx|
      stringed_row_top = "  "
      stringed_row = "#{i} "
      stringed_row_bottom = "  "
      i -= 1
      row.each_with_index do |item, item_idx|
        counter += 1
        background = counter.odd? ? :light_black : :light_white

        if @selected === [row_idx, item_idx]
          background = :red
        end

        if item
          stringed_row_top += "".center(7).colorize(:background => background)
          stringed_row_bottom += "".center(7).colorize(:background => background)
          stringed_row += "#{item.render}".center(7).colorize(:color => item.color.to_sym, :background => background)

        else
          stringed_row_top += "".center(7).colorize(:background => background)
          stringed_row_bottom += "".center(7).colorize(:background => background)
          stringed_row += "".center(7).colorize(:background => background)
        end
      end
      puts stringed_row_top
      puts stringed_row
      puts stringed_row_bottom
      counter+=1
    end
        puts "     A      B      C      D      E      F      G      H"
    return nil
  end

  def test
    p "testing"
  end

end


# board = Board.new
# p board.in_check?("black")
# p board.grid[6][1].valid_moves
# p board.grid[6][4].move_into_check?([5, 3])
# p board.move([6,4], [5,4])
# p board.in_check?("white")
# board.render
# p "IN CHECKMATE "
# p board.checkmate?("white")
# board.render


# board.dup
# board.rook.move_dirs
