
module Chess
  
  #class Pieces is a "helper class" that doesn't know about the game
  #super class for methods shared by the pieces
  class Pieces

    def self.get_piece_data_from_square(board:, target_square:)
      raise "target_square must be a symbol" if target_square.class != Symbol
      target_piece = nil
      board[:squares].each do |square, piece|
        if square == target_square
          target_piece = piece
        end
      end
      raise "target_piece is nil, should be a piece or :vac" if target_piece == nil
      if target_piece == :vac
        return :vac
      else
        return board[:pieces][target_piece]
      end
    end

  end

end
