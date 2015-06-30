require_relative 'sliding_piece'

class Rook < SlidingPiece

  def symbols
    { white: '♖', black: '♜' }
  end

  def move_dirs
    HORIZONTAL_DIRS + VERTICAL_DIRS
  end
end
