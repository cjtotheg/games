
# for converting PGN moves to computer moves
module PGN

  class Convert

    def get_move_hash(board:, pgn_move:, color:)

      #pawn move
      if pgn_move.match(/^[a-h]/)
        return pawn_move(board: board, pgn_move: pgn_move, color: color)
      end

      return {error: true, message: "Move not recognized."}

    end

    private

    def pawn_move(board:, pgn_move:, color:)

      move = {
        piece_id: nil,
        from: nil,
        to: nil,
        error: nil
      }

      take = false
      if pgn_move.match(/x/)
        take = true
      end

      ##### WHICH PAWN?????
      pgn_a = pgn_move.chars
      pawn_id = nil
      pawns_on_file = []
      board.each do |key, val|
        if pgn_a[0] == key.chars[0] && val.class == Pawn && val.color == color
          pawns_on_file.push key
        end
      end

      if pawns_on_file.length == 0
        move[:error] = "Invalid pawn move."
        return move
      end

      if pawns_on_file.length > 1
        raise "more than one pawn on file. not handled yet."
      end

      if pgn_move.length == 2
        
        rank = pgn_move.chars[0]

        
        move[:to] = pgn_move
      else
        from_space = "foo"
        to_space = pgn_move.slice(2,3).join
      end

      return move

    end

  end

end
