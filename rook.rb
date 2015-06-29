require_relative 'sliding_piece'

class Rook < SlidingPiece
  def initialize
    p "created rook"
  end

  def move_dirs
    p DIAGONAL_DIRS
  end
end
