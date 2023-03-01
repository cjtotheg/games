class PgnMove

  def self.interpret(color:, pgn_move:, board:, pieces:)
    
    #move hash is created here
    move = {
      valid: false,
      errors: [],
      captured_piece: nil,
      from_square: nil,
      from_square_occupant: nil,
      to_square: nil,
      to_square_occupant: nil,
      pgn_move: pgn_move,
      color: color
    }      

    case pgn_move
    when /^[abcdefgh]/
      move.merge!(Pawn::interpret_pgn_move(board: board, pieces: pieces, pgn_move: pgn_move, color: color))
    when /^N/
      raise "Knight moves not implemented yet"
    when /^K/
      move.merge!(King::interpret_pgn_move(board: board, pieces: pieces, pgn_move: pgn_move, color: color))
    else
      raise "PGN Move not recognized."
    end

    LOG.debug "PgnMove.interpret(color: #{color}, pgn_move: #{pgn_move}, board: #{board}, pieces: #{pieces}) move: #{move}"

    return move

  end

  def foo_pawn_move(pgn_move:, color:)

    move = Pawn::interpret_pgn_move(board: board, pieces: pieces, pgn_move: pgn_move, color: color)

    if move[:valid] == false
      @user_error_messages.push move[:error]
      return false
    end

    if move[:valid] == true
      ## do the move
      update_board(move)

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
