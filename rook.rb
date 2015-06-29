require_relative 'sliding_piece'

class Rook < SlidingPiece
  def move_dirs
    p DIAGONAL_DIRS
  end
end

rook1 = Rook.new
rook1.move_dirs
