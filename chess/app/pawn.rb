module Chess

  class Pawn < Game 
  
    attr_reader :id, :color, :moves
    attr_writer :moves
  
    def initialize(id:, color:)
      @id = id
      @color = color
      @moves = 0
    end
  
    def move(pgn_move:, color:)
     
      #board = super(board)

      move = {
        from: nil,
        to: nil,
      }
  
      take = false
      if pgn_move.match(/x/)
        take = true
      end
  
      ##### WHICH PAWN?????
      pgn_a = pgn_move.chars
      pawns = []
      game.board.each do |key, val|
        if pgn_a[0] == key.chars[0] && val.class == Pawn && val.color == color 
          pawns.push key
        end
      end
      
      if pawns.length == 0
        p "Invalid pawn move."
        return false
      end
  
      if pawns.length > 1
        raise "more than one pawn on file. not handled yet."
      end
  
      if pawns.length == 1
        move[:from] = pawns[0]
        move[:to] = pgn_move
      end
  
      ###### DO THE MOVE
      BOARD[move[:to]] = BOARD[move[:from]]
      BOARD[move[:to]].moves += 1
      BOARD[move[:from]] = nil
  
      return true 
  
    end
  
  end
  
end
