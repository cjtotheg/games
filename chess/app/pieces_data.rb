module Chess

  class PiecesData
    
    attr_accessor :data

    def initialize(board)

      @data = {
        wP1: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        wP2: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        wP3: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        wP4: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        wP5: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        wP6: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        wP7: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        wP8: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        wR1: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        wN1: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        wB1: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        wQ1: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        wK:  {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        wB2: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        wN2: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        wR2: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        bP1: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        bP2: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        bP3: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        bP4: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        bP5: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        bP6: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        bP7: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        bP8: {captured: false, move_count: 0, moves: [], attacks: [], threats: [], ep_attacks: [], ep_threats: []},
        bR1: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        bN1: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        bB1: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        bQ1: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        bK:  {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        bB2: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        bN2: {captured: false, move_count: 0, moves: [], attacks: [], threats: []},
        bR2: {captured: false, move_count: 0, moves: [], attacks: [], threats: []}
      }

      update_pieces

    end

    def print_piece_data

      @board[:pieces].each do |piece|
        p piece
      end

    end

    def create_piece(piece_id:)
      #only for promotions Q,B,N,R - does not place it on the board!
      @board[:pieces][piece_id] = {
        captured: false,
        moves: [],
        attacks: [],
        threats: []
      }
    end

   def update_pieces
      #board[:squares] is the source of truth!!
      #need to know what this move is so we can see if en passant is in play
      #build the attacks, threats, and captured based on the current board

      #reset all pieces to rebuild from the board
      @board[:pieces].each do |key, val|
        @board[:pieces][key][:moves] = []
        @board[:pieces][key][:attacks] = []
        @board[:pieces][key][:threats] = []
      end

      #update moves, attacks, and threats from the current board 
      @board[:pieces].each do |piece, piece_data|
        next if piece_data[:captured]
        possible_moves = nil

        case piece
        when /P/ #Pawns
          possible_moves = Pawn::get_possible_moves(board: @board, pawn_id: piece)
        when /N/ #Knights
          possible_moves = Knight::get_possible_moves(board: @board, knight_id: piece)
        end

        if possible_moves
          @board[:pieces][piece][:attacks] = possible_moves[:attacks]
          @board[:pieces][piece][:moves]   = possible_moves[:moves]
        end

        next if piece_data[:attacks].count == 0
        piece_data[:attacks].each do |attack|
          @board[:pieces][@board[:squares][attack]][:threats].push get_square_of_piece(piece)
        end

      end

    end


  end

end
