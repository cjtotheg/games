
module Chess

  class Move < Board

    def white_move(pgn_move:)
      do_move(pgn_move: pgn_move, color: "w")
    end

    def black_move(pgn_move:)
      do_move(pgn_move: pgn_move, color: "b")
    end

    def do_move(pgn_move:, color:)
      
      valid = false
      case pgn_move
      when /^[abcdefgh]/
        valid = pawn_move(pgn_move: pgn_move, color: color)
      when /^N/
        valid = knight_move(pgn_move: pgn_move, color: color)
      end

      if valid
        @board[:pgn].push pgn_move
      end

      if VERBOSE
        print_board
      end

      return valid
    end

    def knight_move(pgn_move:, color:)
      
      result = Knight::interpret_pgn_move(board: board, pgn_move: pgn_move, color: color)
      
      if result[:valid] == false
        puts result[:error]
        return false
      end

      if result[:valid] == true

        ## do the move
        update_board(
          captured_piece: result[:captured_piece],
          from_space: result[:from_space],
          from_space_occupant: result[:from_space_occupant],
          to_space: result[:to_space],
          to_space_occupant: result[:to_space_occupant],
          pgn_move: result[:pgn_move])

        update_pieces

        return true
      end

      raise "Something went wrong."

    end

    def pawn_move(pgn_move:, color:)
      
      result = Pawn::interpret_pgn_move(board: board, pgn_move: pgn_move, color: color)

      if result[:valid] == false
        puts result[:error]
        return false
      end

      if result[:valid] == true
        ## do the move
        update_board(
          captured_piece: result[:captured_piece],
          from_space: result[:from_space],
          from_space_occupant: result[:from_space_occupant],
          to_space: result[:to_space],
          to_space_occupant: result[:to_space_occupant],
          pgn_move: result[:pgn_move])

        update_pieces

        #En passant?? Update @board if so..
        a_en_passants = Pawn::get_en_passant_moves(board: board, pgn_move: pgn_move, color: color)
       
        a_en_passants.each do |en_passant|
          if en_passant[:attacks].count > 0
            @board[:pieces][en_passant[:piece_id]][:ep_attacks].concat en_passant[:attacks]
          end
          if en_passant[:threats].count > 0
            @board[:pieces][en_passant[:piece_id]][:ep_threats].concat en_passant[:threats]
          end
        end

        return true

      end

      raise "Something went wrong!"

    end

  end

end
