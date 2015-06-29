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

  def moves
    available_moves = []

    self.move_dirs.each_with_index do |dir, index|

      new_position = [self.pos[0] + dir[0], self.pos[1] + dir[1]];
      i = 1
      while (new_position[0] < 8 && new_position[1] < 8 && new_position[0] >= 0 && new_position[1] >= 0) do
        # return if !grid[new_position[0]][new_position[1]].nil?
        # potential_pos = self.board.grid[new_position[0]][new_position[1]]
        # if !potential_pos.nil?
        #   if potential_pos.color != self.color
        #     available_moves << new_position
        #     return
        #   else
        #     return
        #   end
        #
        #
        # end
        available_moves << new_position
        new_dir = [dir[0]*i, dir[1]*i]
        new_position = self.add_positions(new_dir)
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
