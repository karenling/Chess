class SteppingPiece < Piece

  def moves
    available_moves = []

    self.move_dirs.each do |dir|
      new_position = self.add_positions(dir)
      if within_board_boundaries(new_position)
        grid_piece = self.board.grid[new_position[0]][new_position[1]]
        if grid_piece && self.same_color?(grid_piece)
          next
        elsif grid_piece && !self.same_color?(grid_piece)
          available_moves << new_position
        else
          available_moves << new_position
        end
      end
    end

    available_moves
  end

end
