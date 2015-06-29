class Knight < Piece
  def moves
  end

  def move_dirs
    [[-2, -1], [-2, 1], [2, -1], [2, 1],
    [-1, -2], [-1, 2], [1, -2], [1, 2]]
  end
end
