require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The board is setup.' do
 
    game = Game.new

    context 'The four knights game is played.' do

      it 'White opens with "d4".' do
        expect(game.white_move(pgn_move: "d4")).to eq(true)
      end

      it 'Black opens with "d5".' do
        expect(game.black_move(pgn_move: "d5")).to eq(true)
      end

      it 'White moves knight to Nc3.' do
        expect(game.white_move(pgn_move: "Nc3")).to eq(true)
      end

    end

  end

end
