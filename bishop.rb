class Bishop < SlidingPiece

  def symbols
    {white: '♗', black: '♝'}
  end


  def move_dirs
    DIAGONAL_DIRS
  end

end
