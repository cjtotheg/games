
module Chess

  class Move < Board

    def white_move(pgn_move)
      success = do_move(pgn_move: pgn_move, color: "w")
      handle_errors
      return success
    end

    def black_move(pgn_move)
      success = do_move(pgn_move: pgn_move, color: "b")
      handle_errors
      return success
    end

    def handle_errors
      @user_error_messages.each do |message|
        puts "ERROR: #{message}"
      end
      @user_error_messages = []
    end

    def do_move(pgn_move:, color:)

      valid = false
      
      if @next_move != color
        @user_error_messages.push "Move rejected because it is #{color == 'w' ? 'white' : 'black'} move."
        return false #hard stop here if not this color's move.
      end

      case pgn_move
      when /^[abcdefgh]/
        valid = pawn_move(pgn_move: pgn_move, color: color)
      when /^N/
        valid = knight_move(pgn_move: pgn_move, color: color)
      when /^K/
        valid = king_move(pgn_move: pgn_move, color: color)
      end

      if valid
        @board[:pgn].push pgn_move
      else
        @user_error_messages.push "Move #{pgn_move} not recognized."
        return false 
      end

      if VERBOSE || PRINT_BOARD_EVERY_MOVE
        print_board
      end
      
      return valid
    end

    def king_move(pgn_move:, color:)
      
      result = King::interpret_pgn_move(board: board, pgn_move: pgn_move, color: color)

      if result[:valid] == false
        @user_error_messages.push result[:error]
        return false
      end

      if result[:valid] == true

        ## do the move
        update_board(
          captured_piece: result[:captured_piece],
          from_square: result[:from_square],
          from_square_occupant: result[:from_square_occupant],
          to_square: result[:to_square],
          to_square_occupant: result[:to_square_occupant],
          pgn_move: result[:pgn_move])

        update_pieces

        return true
      end

      raise "Something went wrong."
    end

    def knight_move(pgn_move:, color:)
      
      result = Knight::interpret_pgn_move(board: board, pgn_move: pgn_move, color: color)
      
      if result[:valid] == false
        @user_error_messages.push result[:error]
        return false
      end

      if result[:valid] == true

        ## do the move
        update_board(
          captured_piece: result[:captured_piece],
          from_square: result[:from_square],
          from_square_occupant: result[:from_square_occupant],
          to_square: result[:to_square],
          to_square_occupant: result[:to_square_occupant],
          pgn_move: result[:pgn_move])

        update_pieces

        return true
      end

      raise "Something went wrong."

    end

    def pawn_move(pgn_move:, color:)
      
      result = Pawn::interpret_pgn_move(board: board, pgn_move: pgn_move, color: color)

      if result[:valid] == false
        @user_error_messages.push result[:error]
        return false
      end

      if result[:valid] == true
        ## do the move
        update_board(
          captured_piece: result[:captured_piece],
          from_square: result[:from_square],
          from_square_occupant: result[:from_square_occupant],
          to_square: result[:to_square],
          to_square_occupant: result[:to_square_occupant],
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
