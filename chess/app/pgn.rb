
# for converting PGN moves to computer moves
# does not know what the status of the board is, and does not validate
# moves other than "theoretically possible" ie - pawn can move one, two, or take diag
# king can move one
# rook can move ranks or files etc.
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
      pawns = []
      board.each do |key, val|
        if pgn_a[0] == key.chars[0] && val.class == Pawn && val.color == color
          pawns.push key
        end
      end

      if pawns.length == 0
        move[:error] = "Invalid pawn move."
        return move
      end

      if pawns.length > 1
        raise "more than one pawn on file. not handled yet."
      end
  
      if pawns.length == 1
        move[:piece_id] = board[pawns[0]].id
        move[:from] = pawns[0]
        move[:to] = pgn_move
      end

      return move

    end

  end

end
