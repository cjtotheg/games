

class Board
  
  attr_reader :squares

  def initialize

    #LOG.debug "=== Board.new"

    @squares = {
      a1: :wR1, b1: :wN1, c1: :wB1, d1: :wQ1, e1: :wK,  f1: :wB2, g1: :wN2, h1: :wR2,
      a2: :wP1, b2: :wP2, c2: :wP3, d2: :wP4, e2: :wP5, f2: :wP6, g2: :wP7, h2: :wP8,
      a3: :vac, b3: :vac, c3: :vac, d3: :vac, e3: :vac, f3: :vac, g3: :vac, h3: :vac,
      a4: :vac, b4: :vac, c4: :vac, d4: :vac, e4: :vac, f4: :vac, g4: :vac, h4: :vac,
      a5: :vac, b5: :vac, c5: :vac, d5: :vac, e5: :vac, f5: :vac, g5: :vac, h5: :vac,
      a6: :vac, b6: :vac, c6: :vac, d6: :vac, e6: :vac, f6: :vac, g6: :vac, h6: :vac,
      a7: :bP1, b7: :bP2, c7: :bP3, d7: :bP4, e7: :bP5, f7: :bP6, g7: :bP7, h7: :bP8,
      a8: :bR1, b8: :bN1, c8: :bB1, d8: :bQ1, e8: :bK,  f8: :bB2, g8: :bN2, h8: :bR2
    }

  end
  
  def get_square_of_piece(piece)
    @squares.each do |square, occupant| 
      return square if occupant == piece
    end
    return nil
  end

  def promote_pawn(letter:, color:)
    raise "Invalid promotion" unless letter.match(/[QBNR]/) && color.match(/[wb]/)
    existing = []
    @squares.each do |square, piece|
      next if piece == :vac
      a_piece = piece.to_s.chars
      if a_piece[0] == color && a_piece[1] == letter
        existing.push piece
      end
    end
    promoted = existing.sort.last
    return "#{color}#{letter}#{promoted.to_s.chars[2].to_i + 1}".to_sym
  end

  def update_board(move:, board:, pieces:)

    LOG.debug "=== Board.update_board(move: below, board: below, pieces: below)"

    required_keys = [ 
      :captured_piece,
      :from_square,
      :from_square_occupant,
      :to_square,
      :to_square_occupant,
      :pgn_move,
      :color]

    required_keys.each do |key|
      raise "move argument missing key" unless move.has_key?(key)
    end

    #move the piece (set it in place!)
    @squares[move[:from_square]] = move[:from_square_occupant]
    @squares[move[:to_square]] = move[:to_square_occupant]

    #===============
    #
    #board[:squares] is the source of truth!!
    #
    #==============

    #en passant is a special case, so we'll sweep through again since its the only move in chess
    #where the captured piece is not occupied by the attacking piece.
    pieces.data.each do |piece, data|
      if data[:captured] && @squares.has_value?(piece)
        @squares[get_square_of_piece(piece)] = :vac
      end
    end
    
    #build the attacks, threats, and captured based on the current board

    #reset all pieces to rebuild later
    pieces.data.each do |key, val|
      pieces.data[key][:moves] = []
      pieces.data[key][:attacks] = []
      pieces.data[key][:threats] = []
      
      if key.match(/P/) #pawns
        pieces.data[key][:ep_attacks] = []
        pieces.data[key][:ep_threats] = []
      end
    end

    #update moves, attacks, and threats
    pieces.data.each do |piece, piece_data|
      next if piece_data[:captured]

      case piece
      when /P/
        possible_moves = Pawn::get_possible_moves(board: board, pieces: pieces, pawn_id: piece)
        pieces.data[piece][:attacks] = possible_moves[:attacks]
        pieces.data[piece][:moves] = possible_moves[:moves]
      end

      next if piece_data[:attacks].count == 0
      piece_data[:attacks].each do |attack|
        pieces.data[@squares[attack]][:threats].push get_square_of_piece(piece)
      end

    end

  end

  def square_to_strings(key:, val:)
    {"loc" => "#{key}", "occ" => "#{val}"}
  end

  def print_board
    s = {}
    @squares.each do |key,val|

      case val
      when :vac
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

    LOG.debug "\n"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "    8 | #{s[:a8]} | #{s[:b8]} | #{s[:c8]} | #{s[:d8]} | #{s[:e8]} | #{s[:f8]} | #{s[:g8]} | #{s[:h8]} |"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "    7 | #{s[:a7]} | #{s[:b7]} | #{s[:c7]} | #{s[:d7]} | #{s[:e7]} | #{s[:f7]} | #{s[:g7]} | #{s[:h7]} |"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "    6 | #{s[:a6]} | #{s[:b6]} | #{s[:c6]} | #{s[:d6]} | #{s[:e6]} | #{s[:f6]} | #{s[:g6]} | #{s[:h6]} |"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "    5 | #{s[:a5]} | #{s[:b5]} | #{s[:c5]} | #{s[:d5]} | #{s[:e5]} | #{s[:f5]} | #{s[:g5]} | #{s[:h5]} |"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "    4 | #{s[:a4]} | #{s[:b4]} | #{s[:c4]} | #{s[:d4]} | #{s[:e4]} | #{s[:f4]} | #{s[:g4]} | #{s[:h4]} |"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "    3 | #{s[:a3]} | #{s[:b3]} | #{s[:c3]} | #{s[:d3]} | #{s[:e3]} | #{s[:f3]} | #{s[:g3]} | #{s[:h3]} |"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "    2 | #{s[:a2]} | #{s[:b2]} | #{s[:c2]} | #{s[:d2]} | #{s[:e2]} | #{s[:f2]} | #{s[:g2]} | #{s[:h2]} |"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "    1 | #{s[:a1]} | #{s[:b1]} | #{s[:c1]} | #{s[:d1]} | #{s[:e1]} | #{s[:f1]} | #{s[:g1]} | #{s[:h1]} |"
    LOG.debug "      +---+---+---+---+---+---+---+---+"
    LOG.debug "        a   b   c   d   e   f   g   h "
    LOG.debug "\n"
    
    if VERBOSE || PRINT_PIECES_EVERY_MOVE
      print_piece_data
    end

    return true
  end

end
