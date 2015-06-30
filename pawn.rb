class Pawn < Piece

  def symbols
    { white: '♙', black: '♟' }
  end

  def moves
    available_moves = []

    self.move_dirs.each do |dir|
      new_position =  self.add_positions(dir)

      if ((self.color == "black" && self.pos[0] == 1) || (self.color == "white" && self.pos[0] == 6))
        end_i = 3
      else
        end_i = 2
      end

      i = 1
      while (i <= end_i && new_position[0] < 8 && new_position[1] < 8 && new_position[0] >= 0 && new_position[1] >= 0) do
        grid_piece = self.board.grid[new_position[0]][new_position[1]]
        if !grid_piece.nil? && grid_piece.color == self.color
          break
        elsif !grid_piece.nil? && grid_piece.color != self.color
          available_moves << new_position
          break
        else
          available_moves << new_position
          new_dir = [dir[0]*i, dir[1]*i]
          new_position = self.add_positions(new_dir)
        end
        i+=1
      end
    end

    available_moves.uniq!
  end

  def move_dirs
    final = []

      if self.color === "black"
        final << VERTICAL_DIRS[1] << DIAGONAL_DIRS[2] << DIAGONAL_DIRS[3]
      else
        final << VERTICAL_DIRS[0] << DIAGONAL_DIRS[0] << DIAGONAL_DIRS[1]
      end
  end
end
