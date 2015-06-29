class SteppingPiece < Piece
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
    available_moves = []

    self.move_dirs.each do |dir|
      # p dir
      new_position = self.add_positions(dir)
      if (new_position[0] < 8 && new_position[1] < 8 && new_position[0] >= 0 && new_position[1] >= 0)
        available_moves << new_position
      end
    end

    available_moves
  end

end
