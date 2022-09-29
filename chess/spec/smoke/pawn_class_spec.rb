require_relative '../../app/chess.rb'

module Chess
  RSpec.describe 'The Pawn class' do

    let(:game) { Game.new }

    it 'white opens with move "e4" moves pawn on "e2" to "e4" ' do
      
      result = game.move(pgn_move: "e4", color: :white)

      expect(result).to eq(true)
      expect(game.board[:e4]).to eq(:wP5)
      expect(game.board[:e2]).to eq(:vac)
      expect(game.pieces[:wP5].moves).to eq(1)
      expect(game.pieces[:wP5].id).to eq(:wP5)
      expect(game.pieces[:wP5].color).to eq(:white)

    end

  end

end
