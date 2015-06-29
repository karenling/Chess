class Pawn < Piece

  DIAGONAL_DIRS = [
    [-1, -1], [-1, 1], [1, -1], [1, 1],
    [-2, -2], [-2, 2], [2, -2], [2, 2]
  ]
  # HORIZONTAL_DIRS = [
  #   [0, -1], [0, 1], [0, -2], [0, 2]
  # ]
  VERTICAL_DIRS = [
    [-1, 0], [1, 0], [-2, 0], [2, 0]
  ]

  def symbols
    {white: '♙', black: '♟'}
  end

  def moves
    available_moves = []
    # p self.move_dirs
    self.move_dirs.each do |dir|
      # p dir
      new_position =  self.add_positions(dir)

      if ((self.color == "black" && self.pos[0] == 1) || (self.color == "white" && self.pos[0] == 6))
        end_i = 3
      else
        end_i = 2
      end

      i = 1
      while (i <= end_i && new_position[0] < 8 && new_position[1] < 8 && new_position[0] >= 0 && new_position[1] >= 0) do
        grid_piece = self.board.grid[new_position[0]][new_position[1]]
  # p grid_piece.pos
        if !grid_piece.nil? && grid_piece.color == self.color
          break
        elsif !grid_piece.nil? && grid_piece.color != self.color
          available_moves << new_position
          break
        else
          available_moves << new_position
          new_dir = [dir[0]*i, dir[1]*i]
          # p new_position
          new_position = self.add_positions(new_dir)
          # p new_position
        end
        i+=1
      end
    end

    available_moves.uniq!
    #
    # self.move_dirs
  end
  def move_dirs
    final = []
    # if ((self.color == "black" && self.pos[0] == 1) || (self.color == "white" && self.pos[0] == 6))
    #   if self.color == "black"
    #     final << VERTICAL_DIRS[1] << VERTICAL_DIRS[3] << DIAGONAL_DIRS[2] << DIAGONAL_DIRS[3] << DIAGONAL_DIRS[6] << DIAGONAL_DIRS[7]
    #   else
    #     final << VERTICAL_DIRS[0] << VERTICAL_DIRS[2] << DIAGONAL_DIRS[0] << DIAGONAL_DIRS[1] << DIAGONAL_DIRS[4] << DIAGONAL_DIRS[5]
    #   end
    # else
      if self.color === "black"
        final << VERTICAL_DIRS[1] << DIAGONAL_DIRS[2] << DIAGONAL_DIRS[3]
      else
        final << VERTICAL_DIRS[0] << DIAGONAL_DIRS[0] << DIAGONAL_DIRS[1]
      end

    # end

  end
end
