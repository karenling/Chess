

class SlidingPiece < Piece
  DIAGONAL_DIRS = [
    [-1, -1], [-1, 1], [1, -1], [1, 1]
  ]
  HORIZONTAL_DIRS = [
    [0, -1], [0, 1]
  ]
  VERTICAL_DIRS = [
    [-1, 0], [1, 0]
  ]
  def moves
    p "something"
  end
end
