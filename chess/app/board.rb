

#Board->Move->Game

module Chess
  class Board
   attr_reader :board, :pieces

    def initialize

      @board = { 
      squares: {
        a1: :wR1, b1: :wN1, c1: :wB1, d1: :wQ1, e1: :wK,  f1: :wB2, g1: :wN2, h1: :wR2,
        a2: :wP1, b2: :wP2, c2: :wP3, d2: :wP4, e2: :wP5, f2: :wP6, g2: :wP7, h2: :wP8,
        a3: nil,  b3: nil,  c3: nil,  d3: nil,  e3: nil,  f3: nil,  g3: nil,  h3: nil,
        a4: nil,  b4: nil,  c4: nil,  d4: nil,  e4: nil,  f4: nil,  g4: nil,  h4: nil,
        a5: nil,  b5: nil,  c5: nil,  d5: nil,  e5: nil,  f5: nil,  g5: nil,  h5: nil,
        a6: nil,  b6: nil,  c6: nil,  d6: nil,  e6: nil,  f6: nil,  g6: nil,  h6: nil,
        a7: :bP1, b7: :bP2, c7: :bP3, d7: :bP4, e7: :bP5, f7: :bP6, g7: :bP7, h7: :bP8,
        a8: :bR1, b8: :bN1, c8: :bB1, d8: :bQ1, e8: :bK,  f8: :bB2, g8: :bN2, h8: :bR2
      },
      pieces: {
        wP1: {captured: false, moves: [], attacks: [], threats: []},
        wP2: {captured: false, moves: [], attacks: [], threats: []},
        wP3: {captured: false, moves: [], attacks: [], threats: []},
        wP4: {captured: false, moves: [], attacks: [], threats: []},
        wP5: {captured: false, moves: [], attacks: [], threats: []},
        wP6: {captured: false, moves: [], attacks: [], threats: []},
        wP7: {captured: false, moves: [], attacks: [], threats: []},
        wP8: {captured: false, moves: [], attacks: [], threats: []},
        wR1: {captured: false, moves: [], attacks: [], threats: []},
        wN1: {captured: false, moves: [], attacks: [], threats: []},
        wB1: {captured: false, moves: [], attacks: [], threats: []},
        wQ1: {captured: false, moves: [], attacks: [], threats: []},
        wK:  {captured: false, moves: [], attacks: [], threats: []},
        wB2: {captured: false, moves: [], attacks: [], threats: []},
        wN2: {captured: false, moves: [], attacks: [], threats: []},
        wR2: {captured: false, moves: [], attacks: [], threats: []},
        bP1: {captured: false, moves: [], attacks: [], threats: []},
        bP2: {captured: false, moves: [], attacks: [], threats: []},
        bP3: {captured: false, moves: [], attacks: [], threats: []},
        bP4: {captured: false, moves: [], attacks: [], threats: []},
        bP5: {captured: false, moves: [], attacks: [], threats: []},
        bP6: {captured: false, moves: [], attacks: [], threats: []},
        bP7: {captured: false, moves: [], attacks: [], threats: []},
        bP8: {captured: false, moves: [], attacks: [], threats: []},
        bR1: {captured: false, moves: [], attacks: [], threats: []},
        bN1: {captured: false, moves: [], attacks: [], threats: []},
        bB1: {captured: false, moves: [], attacks: [], threats: []},
        bQ1: {captured: false, moves: [], attacks: [], threats: []},
        bK:  {captured: false, moves: [], attacks: [], threats: []},
        bB2: {captured: false, moves: [], attacks: [], threats: []},
        bN2: {captured: false, moves: [], attacks: [], threats: []},
        bR2: {captured: false, moves: [], attacks: [], threats: []}
      }}

      update_pieces

    end

    def update_pawn_attacks(pawn_id)
      
      color = pawn_id.match(/^w/) ? 'w' : 'b'
     
      attacks = []

      pawn_square = nil
      @board[:squares].each do |key, val| 
        if val == pawn_id 
          pawn_square = key
        end
      end
      raise 'pawn not found' if pawn_square == nil

      if color == 'w'
        #pawns start on rank 2
        #can move two forward if first move
        #can only move one forward if moved already
        #can capture diagonally only

        ####WHAT IS THE PATTERN???
        Pawn::WHITE_PAWN_MOVES.each do |square,moves|
          if pawn_square == square
            moves.each do |possible_square|

              #if pawn has > 1 moves, it can only move one square ahead
              #a pawn cannot move ahead if another piece is in front of it
              #a pawn can attack diagonally if the piece is of the other color
              array_possible_square = possible_square.to_s.chars
              attacks.push possible_square if @board[:squares][possible_square]
            end
          end
        end


      end

      return moves

    end

    def update_pieces
      #board[:squares] is the source of truth!!
      #build the attacks, threats, and captured based on the current board
      
      #find and address any captured pieces
      @board[:pieces].each do |key, val|
        next if @board[:squares].has_value?(key)
        @board[:pieces][key][:captured] = true
        @board[:pieces][key][:attacks] = []
        @board[:pieces][key][:threats] = []
      end
      
      @board[:pieces].each do |key, val|
        next if val[:captured]
        
        #this is where the fun happens!
        #start with the attacks
        #then build the threats off the attacks

        case key
        when /P/
          @board[:pieces][key][:attacks] = update_pawn_attacks(key)
        end

      end
    end

    def update_board(
      from_space:,
      from_space_occupant:,
      to_space:,
      to_space_occupant:,
      pgn_move:)

      @board[:squares][from_space] = from_space_occupant
      @board[:squares][to_space] = to_space_occupant 
      @board[:pieces][to_space_occupant][:moves].push pgn_move
    end

    def space_to_strings(key:, val:)
      {"loc" => "#{key}", "occ" => "#{val}"}
    end

    def print_board
      s = {}
      @board[:squares].each do |key,val|

        case val
        when nil
          val = " "
        when /wP/
          val = "\u2659".encode('utf-8')
        when /bP/
          val = "\u265f".encode('utf-8')
        when /bK/
          val = "\u265a".encode('utf-8')
        when /wK/
          val = "\u2654".encode('utf-8')
        when /bN/
          val = "\u265e".encode('utf-8')
        when /wN/
          val = "\u2658".encode('utf-8')
        when /bB/
          val = "\u265d".encode('utf-8')
        when /wB/
          val = "\u2657".encode('utf-8')
        when /wR/
          val = "\u2656".encode('utf-8')
        when /bR/
          val = "\u265c".encode('utf-8')
        when /wQ/
          val = "\u2655".encode('utf-8')
        when /bQ/
          val = "\u265b".encode('utf-8')
        end

        s[key] = val
      end

      puts "\n\n"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "8 | #{s[:a8]} | #{s[:b8]} | #{s[:c8]} | #{s[:d8]} | #{s[:e8]} | #{s[:f8]} | #{s[:g8]} | #{s[:h8]} |"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "7 | #{s[:a7]} | #{s[:b7]} | #{s[:c7]} | #{s[:d7]} | #{s[:e7]} | #{s[:f7]} | #{s[:g7]} | #{s[:h7]} |"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "6 | #{s[:a6]} | #{s[:b6]} | #{s[:c6]} | #{s[:d6]} | #{s[:e6]} | #{s[:f6]} | #{s[:g6]} | #{s[:h6]} |"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "5 | #{s[:a5]} | #{s[:b5]} | #{s[:c5]} | #{s[:d5]} | #{s[:e5]} | #{s[:f5]} | #{s[:g5]} | #{s[:h5]} |"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "4 | #{s[:a4]} | #{s[:b4]} | #{s[:c4]} | #{s[:d4]} | #{s[:e4]} | #{s[:f4]} | #{s[:g4]} | #{s[:h4]} |"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "3 | #{s[:a3]} | #{s[:b3]} | #{s[:c3]} | #{s[:d3]} | #{s[:e3]} | #{s[:f3]} | #{s[:g3]} | #{s[:h3]} |"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "2 | #{s[:a2]} | #{s[:b2]} | #{s[:c2]} | #{s[:d2]} | #{s[:e2]} | #{s[:f2]} | #{s[:g2]} | #{s[:h2]} |"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "1 | #{s[:a1]} | #{s[:b1]} | #{s[:c1]} | #{s[:d1]} | #{s[:e1]} | #{s[:f1]} | #{s[:g1]} | #{s[:h1]} |"
      puts "  +---+---+---+---+---+---+---+---+"
      puts "    a   b   c   d   e   f   g   h "
      puts "\n\n"
      true
    end

  end

end
