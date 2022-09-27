class Pawn
  attr_reader :id, :color, :moves
  def initialize(id:, color:)
    @id = id
    @color = color
    @moves = 0
  end
  def move(pgn:)
    #verify move is possible and valid
    raise "not yet implemented"
  end
end
