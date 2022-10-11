module Chess

  class Knight < Pieces
    
    KNIGHT_MOVES = {
      a1: [:b3, :c2],
      a2: [:b4, :c3, :c1],
      a3: [:b5, :c4, :c2, :b1],
      a4: [:b6, :c5, :c3, :b2],
      a5: [:b7, :c6, :c4, :b3],
      a6: [:b8, :c7, :c5, :b4],
      a7: [:c8, :c6, :b5],
      a8: [:c7, :b6],
      b1: [:c3, :a3, :d2],
      b2: [:c4, :a4, :d3, :d1],
      b3: [:c5, :a5, :d4, :d2, :c1, :a1],
      b4: [:c6, :a6, :d5, :d3, :c2, :a2],
      b5: [:c7, :a7, :d6, :d4, :c3, :a3],
      b6: [:c8, :a8, :d7, :d5, :c4, :a4],
      b7: [:d8, :d6, :c5, :a5],
      b8: [:d7, :c6, :a6],
      c1: [:d3, :b3, :e2, :a2],
      c2: [:d4, :b4, :e3, :e1, :a1, :a3],
      c3: [:d5, :b5, :e4, :e2, :d1, :b1, :a2, :a4],
      c4: [:d6, :b6, :e5, :e3, :d2, :b2, :a3, :a5],
      c5: [:d7, :b7, :e6, :e4, :d3, :b3, :a4, :a6],
      c6: [:d8, :b8, :e7, :e5, :d4, :b4, :a5, :a7],
      c7: [:e8, :e6, :d5, :b5, :a6, :a8],
      c8: [:e7, :d6, :b6, :a7],
      d1: [:e3, :c3, :f2, :b2],
      d2: [:e4, :c4, :f3, :f1, :b1, :b3],
      d3: [:e5, :c5, :f4, :f2, :e1, :c1, :b2, :b4],
      d4: [:e6, :c6, :f5, :f3, :e2, :c2, :b3, :b5],
      d5: [:e7, :c7, :f6, :f4, :e3, :c3, :b4, :b6],
      d6: [:e8, :c8, :f7, :f5, :e4, :c4, :b5, :b7],
      d7: [:f8, :f6, :e5, :c5, :b6, :b8],
      d8: [:f7, :e6, :c6, :b7],
      e1: [:f3, :d3, :g2, :c2],
      e2: [:f4, :d4, :g3, :g1, :c1, :c3],
      e3: [:f5, :d5, :g4, :g2, :f1, :d1, :c2, :c4],
      e4: [:f6, :d6, :g5, :g3, :f2, :d2, :c3, :c5],
      e5: [:f7, :d7, :g6, :g4, :f3, :d3, :c4, :c6],
      e6: [:f8, :d8, :g7, :g5, :f4, :d4, :c5, :c7],
      e7: [:g8, :g6, :f5, :d5, :c6, :c8],
      e8: [:g7, :f6, :d6, :c7],
      f1: [:g3, :e3, :h2, :d2],
      f2: [:g4, :e4, :h3, :h1, :d1, :d3],
      f3: [:g5, :e5, :h4, :h2, :g1, :e1, :d2, :d4],
      f4: [:g6, :e6, :h5, :h3, :g2, :e2, :d3, :d5],
      f5: [:g7, :e7, :h6, :h4, :g3, :e3, :d4, :d6],
      f6: [:g8, :e8, :h7, :h5, :g4, :e4, :d5, :d7],
      f7: [:h8, :h6, :g5, :e5, :d6, :d8],
      f8: [:h7, :g6, :e6, :d7],
      g1: [:h3, :f3, :e2],
      g2: [:h4, :f4, :e1, :e3],
      g3: [:h5, :f5, :h1, :f1, :e2, :e4],
      g4: [:h6, :f6, :h2, :f2, :e3, :e5],
      g5: [:h7, :f7, :h3, :f3, :e4, :e6],
      g6: [:h8, :f8, :h4, :f4, :e5, :e7],
      g7: [:h5, :f5, :e6, :e8],
      g8: [:h6, :f6, :e7],
      h1: [:g3, :f2],
      h2: [:g4, :f1, :f3],
      h3: [:g5, :g1, :f2, :f4],
      h4: [:g6, :g2, :f3, :f5],
      h5: [:g7, :g3, :f4, :f6],
      h6: [:g8, :g4, :f5, :f7],
      h7: [:g5, :f6, :f8],
      h8: [:g6, :f7]    
    }
  
    def self.get_possible_moves(board:, knight_id:)
      color = knight_id.match(/^w/) ? 'w' : 'b'

      possible_moves = {
        attacks: [],
        moves: []
      }      

      knight_square = get_square_of_piece(board: board, piece: knight_id)
      KNIGHT_MOVES[knight_square].each do |square|
        
        if board[:squares][square] == :vac
          possible_moves[:moves].push square
        else 
          possible_moves[:attacks].push square unless board[:squares][square].to_s.chars[0].match(color)
        end

      end 

      return possible_moves

    end

    def self.interpret_pgn_move(board:, pgn_move:, color:)
      
      # Knight moves can be either: Nf3, Nbd7, Nxd6, 
      # What if two knights are attacking the same square? Nxbd6 ??:
      #    
      #[Event "F/S Return Match"]
      #[Site "Belgrade, Serbia JUG"]
      #[Date "1992.11.04"]
      #[Round "29"]
      #[White "Fischer, Robert J."]
      #[Black "Spassky, Boris V."]
      #[Result "1/2-1/2"]
      #
      #1. e4 e5 2. Nf3 Nc6 3. Bb5 a6 {This opening is called the Ruy Lopez.}
      #4. Ba4 Nf6 5. O-O Be7 6. Re1 b5 7. Bb3 d6 8. c3 O-O 9. h3 Nb8 10. d4 Nbd7
      #11. c4 c6 12. cxb5 axb5 13. Nc3 Bb7 14. Bg5 b4 15. Nb1 h6 16. Bh4 c5 17. dxe5
      #Nxe4 18. Bxe7 Qxe7 19. exd6 Qf6 20. Nbd2 Nxd6 21. Nc4 Nxc4 22. Bxc4 Nb6
      #23. Ne5 Rae8 24. Bxf7+ Rxf7 25. Nxf7 Rxe1+ 26. Qxe1 Kxf7 27. Qe3 Qg5 28. Qxg5
      #hxg5 29. b3 Ke6 30. a3 Kd6 31. axb4 cxb4 32. Ra5 Nd5 33. f3 Bc8 34. Kf2 Bf5
      #35. Ra7 g6 36. Ra6+ Kc5 37. Ke1 Nf4 38. g3 Nxh3 39. Kd2 Kb5 40. Rd6 Kc5 41. Ra6
      #Nf2 42. g4 Bd3 43. Re6 1/2-1/2      
      #
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

      ## Which knight?
      a_pgn = pgn_move.chars
      candidates = []
      board[:squares].each do |square, occupant|
        next if occupant == :vac
        if occupant.match(/N/) && occupant.to_s.chars[0].match(color)
          big_stud = {:square => square, :id => occupant}
          candidates.push big_stud
        end
      end

      if candidates.count == 0
        raise "no knights found"
        move[:error] = "no knights were found"
      end
      
      #what can we set in move so far??
      if a_pgn.length == 3
        move[:to_space] = "#{a_pgn[1]}#{a_pgn[2]}".to_sym
      end
      if a_pgn.length == 4 && take == true
        move[:to_space] = "#{a_pgn[2]}#{a_pgn[3]}".to_sym
      end
      if a_pgn.length == 4 && take == false
        move[:to_space] = "#{a_pgn[2]}#{a_pgn[3]}".to_sym
      end
      if a_pgn.length > 5
        raise "Error, not handled. Is this a double attack move like: Ndxd6???"
      end

      puts "============= KNIGHTS =============="
      knights = []
      puts "pgn: #{pgn_move}"
      puts "color: #{color}"
      puts "candidates:"
      p candidates
      candidates.each do |candidate|
        KNIGHT_MOVES.each do |on_square, moves|
          if on_square == candidate[:square]
            moves.each do |to_square|
              if to_square == move[:to_space]
                knights.push candidate
              end
            end
          end
        end 
      end
      puts "knight(s) that can do the move"
      p knights
      
      if knights.length > 1
        raise "More than one knight can do this move. Not handled yet."
      end

      knight = knights.first

      move[:valid] = true
      move[:from_space] = knight[:square]
      move[:from_space_occupant] = :vac
      move[:to_space_occupant] = knight[:id]

      puts "move:"
      move.each do |key, val|
        print "  #{key}: #{val}\n"
      end
      puts "===================================="
      
      if take
        raise "Not handled yet"
      end

      return move

    end

  end

end

