
module Chess

  class Move < Board
    
    def white_move(pgn_move:)
      pawn_move(pgn_move: pgn_move, color: "w")
    end
    
    def black_move(pgn_move:)
      pgn_move
    end

    def pawn_move(pgn_move:, color:)
      
      pawn = Pawn.new
      result = pawn.describe_pgn_move(board: board, pgn_move: pgn_move, color: color)

      if result[:valid] == false
        puts result[:error]
        return false
      end

      if result[:valid] == true
        ## do the move
        update_board(
          from_space: result[:from_space],
          from_space_occupant: result[:from_space_occupant],
          to_space: result[:to_space],
          to_space_occupant: result[:to_space_occupant]) 
        return true
      end

    end

  end

end
