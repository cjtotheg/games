require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The PGN module' do

    let(:game) { Game.new }

    it 'Convert class get_move method returns piece_id, from square, to square, of the move "e4" ' do
      
      pgn = PGN::Convert.new
      move = pgn.get_move_hash(board: game.board, pgn_move: "e4", color: :white)
      p "the move returned..."
      p move

      expect(move.class).to eq(Hash)
      expect(move[:piece_id]).to eq(:wP4)
      expect(move[:from]).to eq(:e2)
      expect(move[:to]).to eq(:e4)

    end

  end

end


