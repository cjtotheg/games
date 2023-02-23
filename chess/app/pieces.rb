#module Chess

  class Pieces
    
    attr_accessor :data

    def initialize

      LOG.debug "=== Pieces.new"

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

    end

    def get_piece_data_from_square(board:, target_square:)
      raise "target_square must be a symbol" if target_square.class != Symbol
      target_piece = {
        piece_id: nil,
        data: nil
      }
      board.squares.each do |square, piece|
        if square == target_square
          target_piece[:piece_id] = piece
        end
      end
      raise "target_piece[:piece_id] is nil, should be a piece or :vac" if target_piece[:piece_id] == nil

      target_piece[:data] = @data[target_piece[:piece_id]]

      return target_piece

    end

    def get_square_of_piece(board:, piece:)
      board.squares.each do |square, occupant|
        return square if occupant == piece
      end
      return nil
    end

    def print_piece_data

      @data.each do |piece|
        LOG.debug piece
      end

    end

    def create_piece(piece_id:)
      #only for promotions Q,B,N,R - does not place it on the board!
      @data[piece_id] = {
        captured: false,
        moves: [],
        attacks: [],
        threats: []
      }
    end

   def update(board)


     LOG.debug "=== Pieces.update(board)"

     #board is the source of truth!!
     #need to know what this move is so we can see if en passant is in play
     #build the attacks, threats, and captured based on the current board

     #reset all pieces to rebuild from the board
     @data.each do |key, val|
       @data[key][:moves] = []
       @data[key][:attacks] = []
       @data[key][:threats] = []
     end

     #update moves, attacks, and threats from the current board 
     @data.each do |piece, piece_data|
       next if piece_data[:captured]
       possible_moves = nil

       case piece
       when /P/ #Pawns
         possible_moves = Pawn::get_possible_moves(board: board, pieces: self, pawn_id: piece)
       when /N/ #Knights
         possible_moves = Knight::get_possible_moves(board: board, pieces: self, knight_id: piece)
       end

       if possible_moves
         @data[piece][:attacks] = possible_moves[:attacks]
         @data[piece][:moves]   = possible_moves[:moves]
       end

       next if piece_data[:attacks].count == 0
       piece_data[:attacks].each do |attack|
         @data[board.squares[attack]][:threats].push get_square_of_piece(board: board, piece: piece)
       end

     end

    end


  end

#end
