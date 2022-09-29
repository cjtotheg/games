module Chess

  class Pawn < Interpreter

    def interpret_pgn_move(board:, pgn_move:, color:)
      move = {
        valid: false,
        error: nil,
        from_space: nil,
        from_space_occupant: nil,
        to_space: nil,
        to_space_occupant: nil,
      }
  
      take = false
      if pgn_move.match(/x/)
        take = true
      end
  
      ##### WHICH PAWN?????
      pgn_a = pgn_move.chars
      pawns = []
      board.each do |key, val|
        space = space_to_strings(key: key, val: val)
        if pgn_a[0] == space["loc"].chars[0] && space["occ"].match(/P/) && space["occ"].match(/w/) 
          pawns.push [key,val]
        end
      end
      
      if pawns.length == 0
        move[:error] = "invalid pawn move"
      end
  
      if pawns.length > 1
        move[:error] = "more than one pawn on file. not handled yet."
      end
  
      if pawns.length == 1
        move[:valid] = true
        move[:from_space] = pawns[0][0]
        move[:from_space_occupant] = :vac
        move[:to_space] = pgn_move.to_sym
        move[:to_space_occupant] = pawns[0][1]
      end

      return move

    end

  end
  
end
