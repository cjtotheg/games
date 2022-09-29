require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'Making white opening move "e4"' do

    #let(:game) { Game.new }
    game = Game.new

    it 'is made successfully' do
      result = game.white_move(pgn_move: "e4")
      expect(result).to eq(true)
    end

    it 'updates board space :e4 to be pawn :wP5' do
      expect(game.board[:e4]).to eq(:wP5)
    end

    it 'updates board space :e2 to be :vac (vacant)' do
      expect(game.board[:e2]).to eq(:vac)
    end

    it 'increases the move count for pawn :wP5 by one'
      #expect(game.pieces[:wP5].moves).to eq(1)

  end

end
