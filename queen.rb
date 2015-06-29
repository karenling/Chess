class Queen < SlidingPiece
  def move_dirs
    DIAGONAL_DIRS + HORIZONTAL_DIRS + VERTICAL_DIRS
  end
end
