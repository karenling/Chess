require_relative 'sliding_piece'

class Rook < SlidingPiece
  def initialize
    p "created rook"
  end

  def move_dirs
    HORIZONTAL_DIRS + VERTICAL_DIRS
  end
end
