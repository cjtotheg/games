require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The board methods.' do

    board = Board.new

    it 'Gets the square of the white queen' do
      expect(board.get_square_of_piece(:wQ1)).to eq(:d1)
    end

    it 'Promotes a pawn' do 
      expect(board.promote_pawn(letter: 'Q', color: 'w')).to eq(:wQ2)
    end

  end

end
