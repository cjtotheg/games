class PostMove

  def initialize(move:, pieces:, board:)
    
    @move = move
    @pieces = pieces
    @board = board

  end

  def report

    LOG.debug  "=== PostMove.report"

    data = {
      valid: false,
      errors: [],
      b_check: false,
      b_mate: false,
      w_check: false,
      w_mate: false,
      move: @move    
    }

    #do some checks...
    if @pieces.data[:wK][:threats].count > 0
      data[:w_check] = true
      if @pieces.data[:wK][:moves].count == 0
        data[:w_mate] = true
      end
    end

    if @pieces.data[:bK][:threats].count > 0 
      data[:b_check] = true
      if @pieces.data[:bK][:moves].count == 0
        data[:b_mate] = true
      end
    end

    data[:valid] = true

    return data

  end

  def en_passant

      #En passant?? Update @board if so..
      a_en_passants = Pawn::get_en_passant_moves(board: @board, pieces: @pieces, pgn_move: @move[:pgn_move], color: @move[:color])

      a_en_passants.each do |en_passant|
        if en_passant[:attacks].count > 0
          @pieces.data[en_passant[:piece_id]][:ep_attacks].concat en_passant[:attacks]
        end
        if en_passant[:threats].count > 0
          @pieces.data[en_passant[:piece_id]][:ep_threats].concat en_passant[:threats]
        end
      end

  end    

end