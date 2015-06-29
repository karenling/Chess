
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

  def move_into_check?(pos)
    duplicate_board = @board.dup
    duplicate_board.move!(self.pos, pos)

    duplicate_board.in_check?(@color)
  end

  def moves # returns an array of places a piece can move to
  end

  def valid_moves
    moves.reject { |to_pos| move_into_check?(to_pos) }
    # self.move_into_check?([5, 2])
  #   self.moves.each do |move|
  #    p move
  #  end
    # self.moves.reject do |move|
    #   self.move_into_check?(move)
    # end
  end

  def add_positions(delta)
    [@pos[0] + delta[0], @pos[1] + delta[1]]
  end
end
