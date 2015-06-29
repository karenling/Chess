class King < SteppingPiece

  def move_dirs
    DIAGONAL_DIRS + VERTICAL_DIRS + HORIZONTAL_DIRS
  end

end
