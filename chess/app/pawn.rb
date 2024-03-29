#module Chess

  class Pawn

    WHITE_PAWN_MOVES = {
      a2: [:a3, :a4, :b3],
      a3: [:a4, :b4],
      a4: [:a5, :b5],
      a5: [:a6, :b6],
      a6: [:a7, :b7],
      a7: [:a8, :b8],
      b2: [:a3, :b3, :b4, :c3],
      b3: [:a4, :b4, :c4],
      b4: [:a5, :b5, :c5],
      b5: [:a6, :b6, :c6],
      b6: [:a7, :b7, :c7],
      b7: [:a8, :b8, :c8],
      c2: [:b3, :c3, :c4, :d3],
      c3: [:b4, :c4, :d4],
      c4: [:b5, :c5, :d5],
      c5: [:b6, :c6, :d6],
      c6: [:b7, :c7, :d7],
      c7: [:b8, :c8, :d8],
      d2: [:c3, :d3, :d4, :e3],
      d3: [:c4, :d4, :e4],
      d4: [:c5, :d5, :e5],
      d5: [:c6, :d6, :e6],
      d6: [:c7, :d7, :e7],
      d7: [:c8, :d8, :e8],
      e2: [:d3, :e3, :e4, :f3],
      e3: [:d4, :e4, :f4],
      e4: [:d5, :e5, :f5],
      e5: [:d6, :e6, :f6],
      e6: [:d7, :e7, :f7],
      e7: [:d8, :e8, :f8],
      f2: [:e3, :f3, :f4, :g3],
      f3: [:e4, :f4, :g4],
      f4: [:e5, :f5, :g5],
      f5: [:e6, :f6, :g6],
      f6: [:e7, :f7, :g7],
      f7: [:e8, :f8, :g8],
      g2: [:f3, :g3, :g4, :h3],
      g3: [:f4, :g4, :h4],
      g4: [:f5, :g5, :h5],
      g5: [:f6, :g6, :h6],
      g6: [:f7, :g7, :h7],
      g7: [:f8, :g8, :h8],
      h2: [:h3, :h4, :g3],
      h3: [:h4, :g4],
      h4: [:h5, :g5],
      h5: [:h6, :g6],
      h6: [:h7, :g7],
      h7: [:h8, :g8]}

    BLACK_PAWN_MOVES = {
      a2: [:a1, :b1],
      a3: [:a2, :b2],
      a4: [:a3, :b3],
      a5: [:a4, :b4],
      a6: [:a5, :b5],
      a7: [:a6, :a5, :b6],
      b2: [:a1, :b1, :c1],
      b3: [:a2, :b2, :c2],
      b4: [:a3, :b3, :c3],
      b5: [:a4, :b4, :c4],
      b6: [:a5, :b5, :c5],
      b7: [:a6, :b6, :b5, :c6],
      c2: [:b1, :c1, :d1],
      c3: [:b2, :c2, :d2],
      c4: [:b3, :c3, :d3],
      c5: [:b4, :c4, :d4],
      c6: [:b5, :c5, :d5],
      c7: [:b6, :c6, :c5, :d6],
      d2: [:c1, :d1, :e1],
      d3: [:c2, :d2, :e2],
      d4: [:c3, :d3, :e3],
      d5: [:c4, :d4, :e4],
      d6: [:c5, :d5, :e5],
      d7: [:c6, :d6, :d5, :e6],
      e2: [:d1, :e1, :f1],
      e3: [:d2, :e2, :f2],
      e4: [:d3, :e3, :f3],
      e5: [:d4, :e4, :f4],
      e6: [:d5, :e5, :f5],
      e7: [:d6, :e6, :e5, :f6],
      f2: [:e1, :f1, :g1],
      f3: [:e2, :f2, :g2],
      f4: [:e3, :f3, :g3],
      f5: [:e4, :f4, :g6],
      f6: [:e5, :f5, :g7],
      f7: [:e6, :f6, :f5, :g8],
      g2: [:f1, :g1, :h1],
      g3: [:f2, :g2, :h2],
      g4: [:f3, :g3, :h3],
      g5: [:f4, :g4, :h4],
      g6: [:f5, :g5, :h5],
      g7: [:f6, :g6, :g5, :h6],
      h2: [:h1, :g1],
      h3: [:h2, :g2],
      h4: [:h3, :g3],
      h5: [:h4, :g4],
      h6: [:h5, :g5],
      h7: [:h6, :h5, :g6]}


    def self.interpret_pgn_move(board:, pieces:, pgn_move:, color:)

      LOG.debug "============= Pawn.interpret_pgn_move #{color} #{pgn_move} =============="

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

      take = false
      if pgn_move.match(/x/)
        take = true
      end
  
      ##### WHICH PAWN?????
      a_pgn = pgn_move.chars
      pawn = {:square => nil, :id => nil} 
      pawns = []
      board.squares.each do |square, occupant|
        next if occupant == :vac
        if a_pgn[0].match(square.to_s.chars[0]) && occupant.match(/P/) && occupant.match(color) 
          pawns.push [square, occupant]
        end
      end
      
      if pawns.length == 0
        move[:error] = "Invalid pawn move."
      end
  
      if pawns.length > 1
        pawns.each do |square, occupant|
          target_square = take ? "#{a_pgn[2]}#{a_pgn[3]}".to_sym : pgn_move.to_sym
          if pieces.data[occupant][:moves].bsearch{|m| m == target_square} ||
             pieces.data[occupant][:attacks].bsearch{|m| m == target_square} ||
             pieces.data[occupant][:ep_attacks].bsearch{|m| m == target_square}
            pawn[:square] = square
            pawn[:id] = occupant
          end
        end
      end
  
      if pawns.length == 1
        pawn[:square] = pawns[0][0]
        pawn[:id]     = pawns[0][1]
      end

      if pawn == nil
      
        move[:error] = "invalid pawn move"
      
      else #build the move

        if take

          en_passant = false
          attacked_square = "#{a_pgn[2]}#{a_pgn[3]}".to_sym

          #En passant?
          #board[:pieces].each do |piece, data|
          pieces.data.each do |piece, data|
            next unless piece.match(/P/) #only looking at pawns here
            if data[:ep_attacks].bsearch{|square| square == attacked_square }
              #board[:pieces].each do |attacked_piece, attacked_piece_data|
              pieces.data.each do |attacked_piece, attacked_piece_data|
                next unless attacked_piece.match(/P/) #only looking at pawns still
                attacking_piece_square = pieces.get_square_of_piece(board: board, piece: piece)
                if attacked_piece_data[:ep_threats].bsearch{|square| square == attacking_piece_square}

                  LOG.info "En passant!"

                  en_passant = true

                  move[:valid] = true
                  move[:captured_piece] = attacked_piece
                  move[:from_square] = attacking_piece_square
                  move[:from_square_occupant] = :vac
                  move[:to_square] = attacked_square
                  move[:to_square_occupant] = pawn[:id]
                end
              end
            end
          end

          unless en_passant #regular pawn take move
            
            if pieces.data[pawn[:id]][:attacks].bsearch{|square| square == attacked_square}
              move[:valid] = true
              move[:captured_piece] = board.squares[attacked_square]
              move[:from_square] = pawn[:square]
              move[:from_square_occupant] = :vac
              move[:to_square] = attacked_square
              move[:to_square_occupant] = pawn[:id]
            else
              move[:valid] = false
              move[:error] = "Invalid pawn take move."
            end

          end

        else #regular pawn forward move

  
          LOG.debug "regular forward pawn move: #{pawn}"
          

          
          if pieces.data[pawn[:id]][:moves].bsearch{|square| square == pgn_move.to_sym}
            move[:valid] = true
            move[:from_square] = pawn[:square]
            move[:from_square_occupant] = :vac
            move[:to_square] = pgn_move.to_sym
            move[:to_square_occupant] = pawn[:id]
          else
            move[:valid] = false
            move[:error] = "invalid pawn move. pawn.rb regular pawn forward move."
          end

        end

      end


      LOG.debug "complete pawn move data structure: #{move}"

      return move

    end

    def self.get_possible_moves(board:, pieces:, pawn_id:)

      #LOG.debug "=== Pawn.get_possible_moves(board: #{board}, pieces: #{pieces}, pawn_id: #{pawn_id})"

      color = pawn_id.match(/^w/) ? 'w' : 'b'

      possible_moves = {
        attacks: [],
        moves: []
      }

      pawn_square = nil
      board.squares.each do |key, val|
        if val == pawn_id
          pawn_square = key
        end
      end
      raise 'pawn not found' if pawn_square == nil

      a_pawn_square = pawn_square.to_s.chars

      one_square_ahead =
        color == 'w' ?
        "#{a_pawn_square[0]}#{a_pawn_square[1].to_i + 1}".to_sym :
        "#{a_pawn_square[0]}#{a_pawn_square[1].to_i - 1}".to_sym

      two_squares_ahead =
        color == 'w' ?
        "#{a_pawn_square[0]}#{a_pawn_square[1].to_i + 2}".to_sym :
        "#{a_pawn_square[0]}#{a_pawn_square[1].to_i - 2}".to_sym

      lt_diagonal_attack = nil
      rt_diagonal_attack = nil

      if color == 'w'
        lt_diagonal_attack = a_pawn_square[0] == "a" ? nil : "#{(a_pawn_square[0].ord - 1).chr}#{a_pawn_square[1].to_i + 1}".to_sym
        rt_diagonal_attack = a_pawn_square[0] == "h" ? nil : "#{a_pawn_square[0].next}#{a_pawn_square[1].to_i + 1}".to_sym
      end

      if color == 'b'
        lt_diagonal_attack = a_pawn_square[0] == "h" ? nil : "#{(a_pawn_square[0].ord + 1).chr}#{a_pawn_square[1].to_i - 1}".to_sym #this is buggy
        rt_diagonal_attack = a_pawn_square[0] == "a" ? nil : "#{(a_pawn_square[0].ord - 1).chr}#{a_pawn_square[1].to_i - 1}".to_sym
      end


      #LOG.debug "pawn_id: #{pawn_id} pawn_square: #{pawn_square} color: #{color} one_square_ahead: #{one_square_ahead} two_squares_ahead: #{two_squares_ahead} lt_diagonal_attack: #{lt_diagonal_attack} rt_diagonal_attack: #{rt_diagonal_attack}" if VERBOSE

      pawn_moves = color == 'w' ? WHITE_PAWN_MOVES : BLACK_PAWN_MOVES
      pawn_moves.each do |square,moves|
        if pawn_square == square
          moves.each do |possible_square|
            array_possible_square = possible_square.to_s.chars

            #ONE AHEAD
            #a pawn can move 1 ahead if another piece is not in front of it
            if possible_square == one_square_ahead && board.squares[one_square_ahead] == :vac
              possible_moves[:moves].push possible_square
            end

            #TWO AHEAD
            #a pawn can move 2 ahead if another piece is not in front of it, and it has not moved yet
            if possible_square == two_squares_ahead &&
               board.squares[one_square_ahead] == :vac &&
               board.squares[two_squares_ahead] == :vac
              possible_moves[:moves].push possible_square
            end

            #DIAGONAL ATTACK
            #a pawn can attack diagonally if the piece is of the other color
            # highest letter is a, which is "a".ord => 97
            # lowest letter is h, which is "h".ord => 104
            if possible_square == lt_diagonal_attack &&
                board.squares[possible_square] != :vac &&
                board.squares[possible_square].to_s.chars[0] != color
              possible_moves[:attacks].push possible_square
            end

            if possible_square == rt_diagonal_attack &&
                board.squares[possible_square] != :vac &&
                board.squares[possible_square].to_s.chars[0] != color
              possible_moves[:attacks].push possible_square
            end

          end

        end

      end

      return possible_moves

    end


    #en passant possible? get attack squares. this has to be run AFTER the board is updated with the last move.
    def self.get_en_passant_moves(board:, pieces:, pgn_move:, color:)

      en_passant_moves = [] #should be array of hashes like: {piece_id, threats, attacks}
      a_pgn_move = pgn_move.to_s.chars

      board.squares.each do |square, piece|
        
        a_square = square.to_s.chars
        a_piece  = piece.to_s.chars

        #if any white pawns on 5, check if en passant in play due to a black pawn moving two squares on first move (this move)
        if a_square[1] == "5" && a_piece[0] == "w" && color == "b"

          #check if moves_count is 1
          pawn_that_moved = pieces.get_piece_data_from_square(board: board, target_square: pgn_move.to_sym)
          if pawn_that_moved[:data][:move_count] == 1
                        
            #possible for this pawn if black pawn on rank 5 next to this pawn with one move, who just moved! lol
            if VERBOSE
              LOG.debug "EN PASSANT POSSIBLE"
              LOG.debug "this move: #{color} #{pgn_move}"
              LOG.debug "#{piece} on #{square} can attack #{pgn_move} en passant by moving to #{a_pgn_move[0]}#{a_square[1].to_i + 1} "
              LOG.debug "#{pawn_that_moved[:piece_id]} on #{square} has a threat from #{piece}"
            end

            #attacks
            en_passant = {
              piece_id: piece,
              attacks: ["#{a_pgn_move[0]}#{a_square[1].to_i + 1}".to_sym],
              threats: []
            }
            en_passant_moves.push(en_passant)

            #threats
            en_passant = {
              piece_id: pawn_that_moved[:piece_id],
              attacks: [],
              threats: [square]
            }
            en_passant_moves.push(en_passant)
            

          end

        end

      end

      return en_passant_moves

    end

    def self.update_en_passant(move:, pieces:, board:)

      #En passant?? Update @board if so..
      a_en_passants = Pawn::get_en_passant_moves(board: board, pieces: pieces, pgn_move: move[:pgn_move], color: move[:color])

      a_en_passants.each do |en_passant|
        if en_passant[:attacks].count > 0
          pieces.data[en_passant[:piece_id]][:ep_attacks].concat en_passant[:attacks]
        end
        if en_passant[:threats].count > 0
          pieces.data[en_passant[:piece_id]][:ep_threats].concat en_passant[:threats]
        end
      end

    end 

  end
  
#end
