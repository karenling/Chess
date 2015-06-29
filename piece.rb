
class Piece
  attr_accessor :pos, :board, :color
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def inspect
    "{ #{self.class} #{self.pos}  #{self.color} }"
  end
  
  def moves # returns an array of places a piece can move to
  end

  def valid_moves

  end

  def add_positions(delta)
    [@pos[0] + delta[0], @pos[1] + delta[1]]
  end
end
