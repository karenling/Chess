require_relative 'piece'

class SlidingPiece < Piece
  DIAGONAL_DIRS = [
    [-1, -1], [-1, 1], [1, -1], [1, 1]
  ]
  HORIZONTAL_DIRS = [
    [0, -1], [0, 1]
  ]
  VERTICAL_DIRS = [
    [-1, 0], [1, 0]
  ]

  def position_empty(pos)
    !self.board.grid[pos[0]][pos[1]].nil?
  end

  def moves
    available_moves = []



    self.move_dirs.each_with_index do |dir, index|
      new_position = self.add_positions(dir)

      i = 1
      while (new_position[0] < 8 && new_position[1] < 8 && new_position[0] >= 0 && new_position[1] >= 0) do
    
        grid_piece = self.board.grid[new_position[0]][new_position[1]]

        if !grid_piece.nil? && grid_piece.color == self.color
          break
        elsif !grid_piece.nil? && grid_piece.color != self.color
          available_moves << new_position
          break
        elsif grid_piece.nil?
          available_moves << new_position
          new_dir = [dir[0]*i, dir[1]*i]
          new_position = self.add_positions(new_dir)
        end
        i+=1
      end
    end


    available_moves.uniq!
    #
    # cleaned_moves = []
    #
    # available_moves.each do |move|
    #   potential_pos = board.grid[move[0]][move[1]]
    #   if !self.potential_pos.nil? && potential_pos.color == self.color # if it's the same color
    #
    #   end
    # end

    # available_moves.each do |move|
    #   potential_pos = grid[move[0]][move[1]]
    #   if (!potential_pos.nil) # if i find an occupied position
    #
    #     if (potential_pos.color != self.color) # if it's the opp color
    #
    #     end
    #   end
    # end


    #
    #
    # self.move_dirs.each do |dir|
    # end
  end


end
