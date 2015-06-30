require_relative 'piece'

class SlidingPiece < Piece

  def moves
    available_moves = []

    self.move_dirs.each_with_index do |dir, index|
      new_position = self.add_positions(dir)

      i = 1
      while within_board_boundaries(new_position) do
        grid_piece = self.board.grid[new_position[0]][new_position[1]]
        if grid_piece && self.same_color?(grid_piece)
          break
        elsif grid_piece && !self.same_color?(grid_piece)
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
  end

end
