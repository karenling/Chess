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

    self.move_dirs.each do |dir|

      new_position = self.pos;
      i = 1
      while (new_position[0] < 8 && new_position[1] < 8 && new_position[0] >= 0 && new_position[1] >= 0) do
        new_dir = [dir[0]*i, dir[1]*i]
        available_moves << new_position
        new_position = self.add_positions(new_dir)
        i+=1
      end
    end


    available_moves.uniq
    #
    #
    # self.move_dirs.each do |dir|
    # end
  end
end
