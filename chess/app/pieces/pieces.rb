
module Chess
  
  #class Pieces is a "helper class" that doesn't know about the game
  #super class for methods shared by the pieces
  class Pieces

    def self.get_piece_data_from_square(board:, target_square:)
      raise "target_square must be a symbol" if target_square.class != Symbol
      target_piece = {
        piece_id: nil,
        data: nil
      }
      board[:squares].each do |square, piece|
        if square == target_square
          target_piece[:piece_id] = piece
        end
      end
      raise "target_piece[:piece_id] is nil, should be a piece or :vac" if target_piece[:piece_id] == nil
      
      target_piece[:data] = board[:pieces][target_piece[:piece_id]]

      return target_piece
      
    end

    def self.get_square_of_piece(board:, piece:)
      board[:squares].each do |square, occupant|
        return square if occupant == piece
      end
      return nil
    end

  end
  
  #this is a helper class
  class LegalMoveBuilder

    def initialize
      @squares = []
      file = "a"
      rank = 1
      
      while file != "i" do
        if rank <= 8
          @squares.push "#{file}#{rank}".to_sym
          rank += 1
        end
        if rank > 8
          rank = 1
          file = file.next
        end
      end

    end

    def get_move(file, rank)
      if file.match?(/[abcdefgh]/) && rank >= 1 && rank <= 8
        return "#{file}#{rank}".to_sym
      else
        return false
      end
    end
    
    def create_knight_moves
      #used to actually build the moves
      h_moves = {}
      @squares.each do |square|
        moves = []
        as = square.to_s.chars
        file = as[0].ord
        rank = as[1].to_i

        ##############
        # two out
        # one over
        ##############

        #up two right one
        move = get_move((file + 1).chr, rank + 2)
        moves.push(move) if move != false

        #up two left one
        move = get_move((file - 1).chr, rank + 2)
        moves.push(move) if move != false

        #right two up one
        move = get_move((file + 2).chr, rank + 1)
        moves.push(move) if move != false

        #right two down one
        move = get_move((file + 2).chr, rank - 1)
        moves.push(move) if move != false

        #down two right one
        move = get_move((file + 1).chr, rank - 2)
        moves.push(move) if move != false

        #down two left one
        move = get_move((file - 1).chr, rank - 2)
        moves.push(move) if move != false

        #left two down one
        move = get_move((file - 2).chr, rank - 1)
        moves.push(move) if move != false

        #left two up one
        move = get_move((file - 2).chr, rank + 1)
        moves.push(move) if move != false

        if moves.count > 0
          h_moves[square] = moves
       end

     end

      return h_moves
    end    

  end

end
