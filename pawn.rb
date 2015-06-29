class Pawn < SteppingPiece
  def moves
    super

  end
  def move_dirs
    VERTICAL_DIRS[0]
  end
end
