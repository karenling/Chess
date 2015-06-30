class Knight < SteppingPiece

  def symbols
    { white: '♘', black: '♞' }
  end

  def move_dirs
    [[-2, -1], [-2, 1], [2, -1], [2, 1],
    [-1, -2], [-1, 2], [1, -2], [1, 2]]
  end
  
end
