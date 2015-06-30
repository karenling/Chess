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
  attr_accessor :selected, :cursor_color

  def initialize
    @grid = setup_grid
    @selected = [7, 0]
    @cursor_color = nil
  end

  def in_check?(color)
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

  def checkmate?(color)
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
  end

  def move!(start, end_pos)
    starting_piece = @grid[start[0]][start[1]]

    @grid[end_pos[0]][end_pos[1]] = starting_piece
    @grid[end_pos[0]][end_pos[1]].pos = end_pos
    @grid[start[0]][start[1]] = nil
  end


  def move(start, end_pos)
    starting_piece = @grid[start[0]][start[1]]

    if starting_piece.nil?
      raise ArgumentError, "Not a valid selection"
      return
    elsif starting_piece.moves.nil?
      raise ArgumentError, "No available moves."
    elsif !starting_piece.moves.include?(end_pos)
      raise ArgumentError, "Not a valid move."
      return
    elsif !starting_piece.valid_moves.include?(end_pos)
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
          duplicate_board.grid[position[0]][position[1]] =
            type.new(duplicate_board, position, color)
        end
      end
    end

    duplicate_board
  end

  def setup_grid
    grid = Array.new(8) { Array.new(8) }

    [0, 7].each do |row|
      color = ( row == 0 ? "black" : "white" )

      grid[row][0] = Rook.new(self, [row, 0], color)
      grid[row][1] = Knight.new(self, [row, 1], color)
      grid[row][2] = Bishop.new(self, [row, 2], color)
      grid[row][3] = Queen.new(self, [row, 3], color)
      grid[row][4] = King.new(self, [row, 4], color)
      grid[row][5] = Bishop.new(self, [row, 5], color)
      grid[row][6] = Knight.new(self, [row, 6], color)
      grid[row][7] = Rook.new(self, [row, 7], color)
    end

    pawn_rows = [1, 6]
    pawn_cols = (0..7).to_a

    pawn_rows.each do |row|
      pawn_cols.each do |col|
        color = (row == 6 ? "white" : "black")
        grid[row][col] = Pawn.new(self, [row, col], color)
      end
    end

    grid
  end

  def add_piece(piece)
    @grid[piece.pos[0]][piece.pos[1]] = piece
  end

  def render
    system 'clear'
    puts ""
    puts "Chess! Press 'q' to quit.".center(62).colorize(color: :yellow)
    puts ""
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
          background = @cursor_color
        end

        if item
          stringed_row_top += "".center(7).colorize(
            :background => background
          )
          stringed_row_bottom += "".center(7).colorize(
            :background => background
          )
          stringed_row += "#{item.render}".center(7).colorize(
            :color => item.color.to_sym,
            :background => background
          )

        else
          stringed_row_top += "".center(7).colorize(
            :background => background
          )
          stringed_row_bottom += "".center(7).colorize(
            :background => background
          )
          stringed_row += "".center(7).colorize(
            :background => background
          )
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

end
