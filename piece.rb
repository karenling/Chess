
class Piece
  DIAGONAL_DIRS = [
    [-1, -1], [-1, 1], [1, -1], [1, 1]
  ]
  HORIZONTAL_DIRS = [
    [0, -1], [0, 1]
  ]
  VERTICAL_DIRS = [
    [-1, 0], [1, 0]
  ]

  attr_accessor :pos, :board, :color

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def inspect
    "{ #{self.class} #{self.pos}  #{self.color} }"
  end

  def render
    symbols[@color.to_sym]
  end

  def move_into_check?(pos)
    duplicate_board = @board.dup
    duplicate_board.move!(self.pos, pos)
    duplicate_board.in_check?(@color)
  end

  def valid_moves
    self.moves.reject do |move|
      self.move_into_check?(move)
    end
  end

  def add_positions(delta)
    [@pos[0] + delta[0], @pos[1] + delta[1]]
  end

end
