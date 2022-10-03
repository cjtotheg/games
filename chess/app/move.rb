
module Chess

  class Move < Board
    
    def white_move(pgn_move:)
      pawn_move(pgn_move: pgn_move, color: "w")
    end
    
    def black_move(pgn_move:)
      pawn_move(pgn_move: pgn_move, color: "b")
    end

    def pawn_move(pgn_move:, color:)
      
      pawn = Pawn.new
      result = pawn.interpret_pgn_move(board: board, pgn_move: pgn_move, color: color)

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
          to_space_occupant: result[:to_space_occupant],
          pgn_move: result[:pgn_move])
        return true
      end

    end

  end

end
