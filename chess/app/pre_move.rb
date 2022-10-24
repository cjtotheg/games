module Chess

  class PreMove
    
    def initialize(color:, pgn_move:, board:, pieces:)

      puts "=== PreMove.new(color:, pgn_move:, board:, pieces:)"

      @color    = color
      @pgn_move = pgn_move
      @pre_move_board    = board
      @pre_move_pieces   = pieces
    end

    def report

      response = PGNMove.interpret(color: @color, pgn_move: @pgn_move, board: @pre_move_board, pieces: @pre_move_pieces)

      return response
    end

  end

end
