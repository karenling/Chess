class King < SteppingPiece

  def symbols
    { white: '♔', black: '♚' }
  end

  def move_dirs
    DIAGONAL_DIRS + VERTICAL_DIRS + HORIZONTAL_DIRS
  end

end
