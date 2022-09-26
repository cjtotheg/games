
module Chess

  class Game
    
    attr_reader :board

    def initialize
      @board = setup
    end

    def setup
      CHESS_BOARD_SETUP  
    end

    def move(pgn:, comment: "") #accepts PGN notation
      if pgn.match(/^(a..h)/) #pawn move
        raise "need to implement pawn moves"
      end
    end

  end

  class Rook < Game
    attr_reader :id, :color, :moves
    def initialize(id:, color:)
      @id = id
      @color = color
      @moves = 0
    end
    def move(pgn:)
      #verify move is possible and valid

    end
  end

  class Knight < Game
    attr_reader :id, :color, :moves
    def initialize(id:, color:)
      @id = id
      @color = color
      @moves = 0
    end
    def move(pgn:)
      #verify move is possible and valid

    end
  end

  class Bishop < Game
    attr_reader :id, :color, :moves
    def initialize(id:, color:)
      @id = id
      @color = color
      @moves = 0
    end
    def move(pgn:)
      #verify move is possible and valid

    end
  end

  class Queen < Game
    attr_reader :id, :color, :moves
    def initialize(id:, color:)
      @id = id
      @color = color
      @moves = 0
    end
    def move(pgn:)
      #verify move is possible and valid

    end
  end

  class King < Game
    attr_reader :id, :color, :moves
    def initialize(id:, color:)
      @id = id
      @color = color
      @moves = 0
    end
    def move(pgn:)
      #verify move is possible and valid

    end
  end

  class Pawn < Game
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

  ChessBoard = Struct.new(
    :a1,:b1,:c1,:d1,:e1,:f1,:g1,:h1,
    :a2,:b2,:c2,:d2,:e2,:f2,:g2,:h2,
    :a3,:b3,:c3,:d3,:e3,:f3,:g3,:h3,
    :a4,:b4,:c4,:d4,:e4,:f4,:g4,:h4,
    :a5,:b5,:c5,:d5,:e5,:f5,:g5,:h5,
    :a6,:b6,:c6,:d6,:e6,:f6,:g6,:h6,
    :a7,:b7,:c7,:d7,:e7,:f7,:g7,:h7,
    :a8,:b8,:c8,:d8,:e8,:f8,:g8,:h8)

  CHESS_BOARD_SETUP = ChessBoard.new(
    :wR1, :wN1, :wB1, :wQ1, :wK1, :wB2, :wN2, :wR2,
    :wP1, :wP2, :wP3, :wP4, :wP5, :wP6, :wP7, :wP8,
    :vac, :vac, :vac, :vac, :vac, :vac, :vac, :vac,
    :vac, :vac, :vac, :vac, :vac, :vac, :vac, :vac,
    :vac, :vac, :vac, :vac, :vac, :vac, :vac, :vac,
    :vac, :vac, :vac, :vac, :vac, :vac, :vac, :vac,
    :bP1, :bP2, :bP3, :bP4, :bP5, :bP6, :bP7, :bP8,
    :bR1, :bN1, :bB1, :bQ1, :bK1, :bB2, :bN2, :bR2)

  Pieces = Struct.new(
    :wR1, :wN1, :wB1, :wQ1, :wK1, :wB2, :wN2, :wR2,
    :wP1, :wP2, :wP3, :wP4, :wP5, :wP6, :wP7, :wP8,
    :bP1, :bP2, :bP3, :bP4, :bP5, :bP6, :bP7, :bP8,
    :bR1, :bN1, :bB1, :bQ1, :bK1, :bB2, :bN2, :bR2)

  PIECES = Pieces.new(
    #white pieces
    Rook.new(id: :wR1, color: :white),
    Knight.new(id: :wN1, color: :white),
    Bishop.new(id: :wB1, color: :white),
    Queen.new(id: :wQ1, color: :white),
    King.new(id: :wK1, color: :white),
    Bishop.new(id: :wB2, color: :white),
    Knight.new(id: :wN2, color: :white),
    Rook.new(id: :wR2, color: :white),
    Pawn.new(id: :wP1, color: :white),
    Pawn.new(id: :wP2, color: :white),
    Pawn.new(id: :wP3, color: :white),
    Pawn.new(id: :wP4, color: :white),
    Pawn.new(id: :wP5, color: :white),
    Pawn.new(id: :wP6, color: :white),
    Pawn.new(id: :wP7, color: :white),
    Pawn.new(id: :wP8, color: :white),

    #black pieces
    Pawn.new(id: :bP1, color: :black),
    Pawn.new(id: :bP2, color: :black),
    Pawn.new(id: :bP3, color: :black),
    Pawn.new(id: :bP4, color: :black),
    Pawn.new(id: :bP5, color: :black),
    Pawn.new(id: :bP6, color: :black),
    Pawn.new(id: :bP7, color: :black),
    Pawn.new(id: :bP8, color: :black),
    Rook.new(id: :bR1, color: :black),
    Knight.new(id: :bN1, color: :black),
    Bishop.new(id: :bB1, color: :black),
    Queen.new(id: :bQ1, color: :black),
    King.new(id: :bK1, color: :black),
    Bishop.new(id: :bB2, color: :black),
    Knight.new(id: :bN2, color: :black),
    Rook.new(id: :bR2, color: :black))

end
