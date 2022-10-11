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

      it 'Black moves knight to Nc6' do 
        expect(game.black_move(pgn_move: "Nc6")).to eq(true)
      end

      it 'White moves "e4"' do 
        expect(game.white_move(pgn_move: "e4")).to eq(true)
      end

      it 'Black moves "e5"' do
        expect(game.black_move(pgn_move: "e5")).to eq(true)
      end

      it 'White moves "Nf3"' do
        expect(game.white_move(pgn_move: "Nf3")).to eq(true)
      end

      it 'Black moves "Nf6"' do
        expect(game.black_move(pgn_move: "Nf6")).to eq(true)
      end

    end

  end

end
