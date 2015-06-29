
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

  def render
    symbols[@color.to_sym]
  end

  def move_into_check?(pos)
    duplicate_board = @board.dup
    duplicate_board.move!(self.pos, pos) # make sure to use move!
    # the problem with move is that the line "!starting_piece.valid_moves.include?(end_pos)" calls valid_moves which calls move_in_check? this is a circular loop

    duplicate_board.in_check?(@color)
  end

  def moves # returns an array of places a piece can move to
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
