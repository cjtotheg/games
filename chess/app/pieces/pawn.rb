module Chess

  class Pawn < Interpreter

    WHITE_PAWN_MOVES = {
      a2: [:a3, :a4, :b3],
      a3: [:a4, :b4],
      a4: [:a5, :b5],
      a5: [:a6, :b6],
      a6: [:a7, :b7],
      a7: [:a8, :b8],
      b2: [:a3, :b3, :c3],
      b3: [:a4, :b4, :c4],
      b4: [:a5, :b5, :c5],
      b5: [:a6, :b6, :c6],
      b6: [:a7, :b7, :c7],
      b7: [:a8, :b8, :c8],
      c2: [:b3, :c3, :d3],
      c3: [:b4, :c4, :d4],
      c4: [:b5, :c5, :d5],
      c5: [:b6, :c6, :d6],
      c6: [:b7, :c7, :d7],
      c7: [:b8, :c8, :d8],
      d2: [:c3, :d3, :e3],
      d3: [:c4, :d4, :e4],
      d4: [:c5, :d5, :e5],
      d5: [:c6, :d6, :e6],
      d6: [:c7, :d7, :e7],
      d7: [:c8, :d8, :e8],
      e2: [:d3, :e3, :f3],
      e3: [:d4, :e4, :f4],
      e4: [:d5, :e5, :f5],
      e5: [:d6, :e6, :f6],
      e6: [:d7, :e7, :f7],
      e7: [:d8, :e8, :f8],
      f2: [:e3, :f3, :g3],
      f3: [:e4, :f4, :g4],
      f4: [:e5, :f5, :g5],
      f5: [:e6, :f6, :g6],
      f6: [:e7, :f7, :g7],
      f7: [:e8, :f8, :g8],
      g2: [:f3, :g3, :h3],
      g3: [:f4, :g4, :h4],
      g4: [:f5, :g5, :h5],
      g5: [:f6, :g6, :h6],
      g6: [:f7, :g7, :h7],
      g7: [:f8, :g8, :h8],
      h2: [:h3, :g3],
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
      a7: [:a6, :b6],
      b2: [:a1, :b1, :c1],
      b3: [:a2, :b2, :c2],
      b4: [:a3, :b3, :c3],
      b5: [:a4, :b4, :c4],
      b6: [:a5, :b5, :c5],
      b7: [:a6, :b6, :c6],
      c2: [:b1, :c1, :d1],
      c3: [:b2, :c2, :d2],
      c4: [:b3, :c3, :d3],
      c5: [:b4, :c4, :d4],
      c6: [:b5, :c5, :d5],
      c7: [:b6, :c6, :d6],
      d2: [:c1, :d1, :e1],
      d3: [:c2, :d2, :e2],
      d4: [:c3, :d3, :e3],
      d5: [:c4, :d4, :e4],
      d6: [:c5, :d5, :e5],
      d7: [:c6, :d6, :e6],
      e2: [:d1, :e1, :f1],
      e3: [:d2, :e2, :f2],
      e4: [:d3, :e3, :f3],
      e5: [:d4, :e4, :f4],
      e6: [:d5, :e5, :f5],
      e7: [:d6, :e6, :f6],
      f2: [:e1, :f1, :g1],
      f3: [:e2, :f2, :g2],
      f4: [:e3, :f3, :g3],
      f5: [:e4, :f4, :g6],
      f6: [:e5, :f5, :g7],
      f7: [:e6, :f6, :g8],
      g2: [:f1, :g1, :h1],
      g3: [:f2, :g2, :h2],
      g4: [:f3, :g3, :h3],
      g5: [:f4, :g4, :h4],
      g6: [:f5, :g5, :h5],
      g7: [:f6, :g6, :h6],
      h2: [:h1, :g1],
      h3: [:h2, :g2],
      h4: [:h3, :g3],
      h5: [:h4, :g4],
      h6: [:h5, :g5],
      h7: [:h6, :g6]}


    def interpret_pgn_move(board:, pgn_move:, color:)
      move = {
        valid: false,
        error: nil,
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
      pgn_a = pgn_move.chars
      pawns = []
      board[:squares].each do |key, val|
        space = space_to_strings(key: key, val: val)
        if pgn_a[0] == space["loc"].chars[0] && space["occ"].match(/P/) && space["occ"].match(color) 
          pawns.push [key,val]
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
          raise 'take not implemented'
        end

        if color == "w"
          valid_spaces = WHITE_PAWN_MOVES[pawns[0][0]]
        else
          valid_spaces = BLACK_PAWN_MOVES[pawns[0][0]]
        end

        move[:valid] = true
        move[:from_space] = pawns[0][0]
        move[:from_space_occupant] = nil
        move[:to_space] = pgn_move.to_sym
        move[:to_space_occupant] = pawns[0][1]
      end

      return move

    end

  end
  
end
