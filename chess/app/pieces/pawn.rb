module Chess

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


    def self.interpret_pgn_move(board:, pgn_move:, color:)
      move = {
        valid: false,
        error: nil,
        captured_piece: nil,
        from_space: nil,
        from_space_occupant: nil,
        to_space: nil,
        to_space_occupant: nil,
        pgn_move: pgn_move,
      }
  
      take = false
      if pgn_move.match(/x/)
        take = true
      end
  
      ##### WHICH PAWN?????
      a_pgn = pgn_move.chars
      pawns = []
      board[:squares].each do |square, occupant|
        next if occupant == :vac
        if a_pgn[0].match(square.to_s.chars[0]) && occupant.match(/P/) && occupant.match(color) 
          pawns.push [square, occupant]
        end
      end
      
      if pawns.length == 0
        move[:error] = "invalid pawn move"
      end
  
      if pawns.length > 1
        move[:error] = "more than one pawn on file. not handled yet."
      end
  
      if pawns.length == 1

        if take 
          attacked_square = "#{a_pgn[2]}#{a_pgn[3]}".to_sym
          if board[:pieces][pawns[0][1]][:attacks].bsearch{|square| square == attacked_square}
            move[:valid] = true
            move[:captured_piece] = board[:squares][attacked_square]
            move[:from_space] = pawns[0][0]
            move[:from_space_occupant] = :vac
            move[:to_space] = attacked_square
            move[:to_space_occupant] = pawns[0][1]
          else
            move[:valid] = false
            move[:error] = "Invalid pawn take move."
          end
        else
          if board[:pieces][pawns[0][1]][:moves].bsearch{|square| square == pgn_move.to_sym}
            move[:valid] = true
            move[:from_space] = pawns[0][0]
            move[:from_space_occupant] = :vac
            move[:to_space] = pgn_move.to_sym
            move[:to_space_occupant] = pawns[0][1]
          else
            move[:valid] = false
            move[:error] = "Invalid pawn take move."
          end

        end

      end

      return move

    end

    def self.get_possible_moves(board:, pawn_id:)

      color = pawn_id.match(/^w/) ? 'w' : 'b'

      possible_moves = {
        attacks: [],
        moves: []
      }

      pawn_square = nil
      board[:squares].each do |key, val|
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
        lt_diagonal_attack = a_pawn_square[0] == "h" ? nil : "#{(a_pawn_square[0].ord - 1).chr}#{a_pawn_square[1].to_i - 1}".to_sym
        rt_diagonal_attack = a_pawn_square[0] == "a" ? nil : "#{a_pawn_square[0].next}#{a_pawn_square[1].to_i - 1}".to_sym
      end

      #puts "pawn_id: #{pawn_id} pawn_square: #{pawn_square} color: #{color} one_square_ahead: #{one_square_ahead} two_squares_ahead: #{two_squares_ahead} lt_diagonal_attack: #{lt_diagonal_attack} rt_diagonal_attack: #{rt_diagonal_attack}"

      pawn_moves = color == 'w' ? WHITE_PAWN_MOVES : BLACK_PAWN_MOVES
      pawn_moves.each do |square,moves|
        if pawn_square == square
          moves.each do |possible_square|
            array_possible_square = possible_square.to_s.chars

            #ONE AHEAD
            #a pawn can move 1 ahead if another piece is not in front of it
            if possible_square == one_square_ahead && board[:squares][one_square_ahead] == :vac
              possible_moves[:moves].push possible_square
            end

            #TWO AHEAD
            #a pawn can move 2 ahead if another piece is not in front of it, and it has not moved yet
            if possible_square == two_squares_ahead &&
               board[:squares][one_square_ahead] == :vac &&
               board[:squares][two_squares_ahead] == :vac
              possible_moves[:moves].push possible_square
            end

            #DIAGONAL ATTACK
            #a pawn can attack diagonally if the piece is of the other color
            # highest letter is a, which is "a".ord => 97
            # lowest letter is h, which is "h".ord => 104
            if possible_square == lt_diagonal_attack &&
                board[:squares][possible_square] != :vac &&
                board[:squares][possible_square].to_s.chars[0] != color
              possible_moves[:attacks].push possible_square
            end

            if possible_square == rt_diagonal_attack &&
                board[:squares][possible_square] != :vac &&
                board[:squares][possible_square].to_s.chars[0] != color
              possible_moves[:attacks].push possible_square
            end


            #EN PASSANT
            #a pawn can attack a pawn in passing if pawn is next to it and it moves two (en passant)

          end

        end

      end

      return possible_moves

    end

  end
  
end
