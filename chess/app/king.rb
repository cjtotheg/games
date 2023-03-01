  
#module Chess
  
  class King
    
    KING_MOVES = {
      a1: [:a2, :b2, :b1],
      a2: [:a3, :b3, :b2, :b1, :a1],
      a3: [:a4, :b4, :b3, :b2, :a2],
      a4: [:a5, :b5, :b4, :b3, :a3],
      a5: [:a6, :b6, :b5, :b4, :a4],
      a6: [:a7, :b7, :b6, :b5, :a5],
      a7: [:a8, :b8, :b7, :b6, :a6], 
      a8: [:b8, :b7, :a7],
      b1: [:b2, :c2, :c1, :a1],
      b2: [:b3, :c3, :c2, :c1, :b1, :a1, :a2, :a3],
      b3: [:b4, :c4, :c3, :c2, :b2, :a2, :a3, :a4],
      b4: [:b5, :c5, :c4, :c3, :b3, :a3, :a4, :a5],
      b5: [:b6, :c6, :c5, :c4, :b4, :a4, :a4, :a6],
      b6: [:b7, :c7, :c6, :c5, :b5, :a5, :a5, :a7],
      b7: [:b8, :c8, :c7, :c6, :b6, :a6, :a6, :a8],
      b8: [:c8, :c7, :b7, :a7, :a8],
      c1: [:c2, :d2, :d1, :b1, :b2],
      c2: [:c3, :d3, :d3, :d1, :c1, :b1, :b2, :b3],
      c3: [:c4, :d4, :d4, :d2, :c2, :b2, :b3, :b4],
      c4: [:c5, :d5, :d5, :d3, :c3, :b3, :b4, :b5],
      c5: [:c6, :d6, :d6, :d4, :c4, :b4, :b5, :b6],
      c6: [:c7, :d7, :d7, :d5, :c5, :b5, :b6, :b7],
      c7: [:c8, :d8, :d8, :d6, :c6, :b6, :b7, :b8],
      c8: [:d8, :d7, :c7, :b7, :b8],
      d1: [:d2, :e2, :e1, :c1, :c2],
      d2: [:d3, :e3, :e2, :e1, :d1, :c1, :c2, :c3],
      d3: [:d4, :e4, :e3, :e2, :d2, :c2, :c3, :c4],
      d4: [:d5, :e5, :e4, :e3, :d3, :c3, :c4, :c5],
      d5: [:d6, :e6, :e5, :e4, :d4, :c4, :c5, :c6],
      d6: [:d7, :e7, :e6, :e5, :d5, :c5, :c6, :c7],
      d7: [:d8, :e8, :e7, :e6, :d6, :c6, :c7, :c8],
      d8: [:e8, :e7, :d7, :c7, :c8],
      e1: [:e2, :f2, :f1, :d1, :d2],
      e2: [:e3, :f3, :f2, :f1, :e1, :d1, :d2, :d3],
      e3: [:e4, :f4, :f3, :f2, :e2, :d2, :d3, :d4],
      e4: [:e5, :f5, :f4, :f3, :e3, :d3, :d4, :d5],
      e5: [:e6, :f6, :f5, :f4, :e4, :d4, :d5, :d6],
      e6: [:e7, :f7, :f6, :f5, :e5, :d5, :d6, :d7],
      e7: [:e8, :f8, :f7, :f6, :e6, :d6, :d7, :d8],
      e8: [:f8, :f7, :e7, :d7, :d8],
      f1: [:f2, :g2, :g1, :e1, :e2],
      f2: [:f3, :g3, :g2, :g1, :f1, :e1, :e2, :e3],
      f3: [:f4, :g4, :g3, :g2, :f2, :e2, :e3, :e4],
      f4: [:f5, :g5, :g4, :g3, :f3, :e3, :e4, :e5],
      f5: [:f6, :g6, :g5, :g4, :f4, :e4, :e5, :e6],
      f6: [:f7, :g7, :g6, :g5, :f5, :e5, :e6, :e7],
      f7: [:f8, :g8, :g7, :g6, :f6, :e6, :e7, :e8],
      f8: [:g8, :g7, :f7, :e7, :e8],
      g1: [:g2, :h2, :h1, :f1, :f2],
      g2: [:g3, :h3, :h2, :h1, :g1, :f1, :f2, :f3],
      g3: [:g5, :h4, :h3, :h2, :g2, :f2, :f3, :f4],
      g4: [:g6, :h5, :h4, :h3, :g3, :f3, :f4, :f5],
      g5: [:g7, :h6, :h5, :h4, :g4, :f4, :f5, :f6],
      g6: [:g8, :h7, :h6, :h5, :g5, :f5, :f6, :f7],
      g7: [:g9, :h8, :h7, :h6, :g6, :f6, :f7, :f8],
      g8: [:h8, :h7, :g7, :f7, :f8],
      h1: [:h2, :g1, :g2],
      h2: [:h3, :h1, :g1, :g2, :g3],
      h3: [:h4, :h2, :g2, :g3, :g4],
      h4: [:h5, :h3, :g3, :g4, :g5],
      h5: [:h6, :h4, :g4, :g5, :g6],
      h6: [:h7, :h5, :g5, :g6, :g7],
      h7: [:h8, :h6, :g6, :g7, :g8],
      h8: [:h7, :g7, :g8]}
  
    def self.interpret_pgn_move(board:, pieces:, pgn_move:, color:)
  
        LOG.debug "============= King.interpret_pgn_move #{color} #{pgn_move} =============="

        move = {
          valid: false,
          error: "",
          captured_piece: nil,
          from_square: pieces.get_square_of_piece(board: board, piece: "#{color}K".to_sym),
          from_square_occupant: :vac,
          to_square: nil,
          to_square_occupant: nil,
          pgn_move: pgn_move,
          color: color
        }
  
        take = false
        if pgn_move.match(/x/)
          take = true
        end
  
        a_pgn = pgn_move.chars
        king_id = "#{color}K".to_sym
  
        #set move[:to_square]
        if a_pgn.length == 3
          move[:to_square] = "#{a_pgn[1]}#{a_pgn[2]}".to_sym
        end
        if a_pgn.length == 4 && take == true
          move[:to_square] = "#{a_pgn[2]}#{a_pgn[3]}".to_sym
        end
        if a_pgn.length > 4
          move[:error] += "Invalid king move. PGN length is more than 4."
        end

        KING_MOVES.each do |on_square, moves|
          if on_square == move[:from_square] 
            moves.each do |to_square|
              if to_square == move[:to_square] #king can do this move but....
                
                #REJECT CASE: is the square occupied by friendly forces?
                occupied_friendly = false
                if board.squares[to_square].to_s.chars[0] == color
                  move[:error] += "Invalid king move. square occupied by friendly forces."
                  occupied_friendly = true
                end
  
                #REJECT CASE: would moving into vacant square put the king in check?
                moving_into_check = false
                 
                #reject if any active opposing piece can 
                #hit the move[:to_square] from its current square

                #pawn
                pawn_moves = color == 'w' ? Pawn::BLACK_PAWN_MOVES : Pawn::WHITE_PAWN_MOVES
                pawn_moves.each do |square, this_pawns_moves|
                  occupant = board.squares[square].to_s.chars
                  next if occupant[0] == color || occupant[1] != 'P' 
                  this_pawns_moves.each do |this_pawn_move|
                    if this_pawn_move == move[:to_square]
                      move[:error] += "Cannot move king into check. Pawn on #{square} is attacking #{move[:to_square]}."
                      moving_into_check = true
                    end
                  end
                end

                #knight
                #bishop
                #rook
                #queen
                #king

                #REJECT CASE: would taking a piece put the king in check?
  
                if occupied_friendly || moving_into_check
                  return move
                end
  
              end
            end
          end
        end
  
        move[:to_square_occupant] = king_id
  
        if take
          move[:valid] = true
          move[:captured_piece] = board[:squares][move[:to_square]]
        else
          move[:valid] = true
        end
  
        LOG.debug "take: #{take}" if VERBOSE
        LOG.debug "move:" if VERBOSE
        move.each do |k,v|
          LOG.debug "#{k}: #{v}" if VERBOSE
        end
        LOG.debug "====================================" if VERBOSE
  
        return move
  
    end
  
  
  end
  
#end
