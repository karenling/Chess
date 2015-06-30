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
      new_position = self.add_positions(dir)
      if (new_position[0] < 8 && new_position[1] < 8 && new_position[0] >= 0 && new_position[1] >= 0)
        grid_piece = self.board.grid[new_position[0]][new_position[1]]

        if !grid_piece.nil? && grid_piece.color == self.color
          next
        elsif !grid_piece.nil? && grid_piece.color != self.color
          available_moves << new_position
        else
          available_moves << new_position
        end
      end
    end

    available_moves
  end

end
