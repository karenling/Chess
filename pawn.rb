class Pawn < SteppingPiece

  def moves
    super

  end
  def move_dirs
    if self.color === "black"
      VERTICAL_DIRS[1]
    else
      VERTICAL_DIRS[0]
    end

  end
end
