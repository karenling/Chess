class Queen < SlidingPiece

  def symbols
    { white: '♕', black: '♛' }
  end

  def move_dirs
    DIAGONAL_DIRS + HORIZONTAL_DIRS + VERTICAL_DIRS
  end
end
