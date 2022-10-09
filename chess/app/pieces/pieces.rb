
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

end
