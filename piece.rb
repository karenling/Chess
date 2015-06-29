
class Piece
  attr_reader :pos
  def initialize(board, pos)
    @board = board
    @pos = pos
  end

  def moves # returns an array of places a piece can move to
  end

  def valid_moves

  end

  def add_positions(new_pos)
    [@pos[0] + new_pos[0], @pos[1] + new_pos[1]]
  end
end
