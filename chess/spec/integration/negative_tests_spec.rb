require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The game is played, but with invalid moves.' do

    game = Game.new

    context 'Invalid move by white, then black moves, should fail, then valid white move passes.' do

      it 'White moves "e5".' do
        expect(game.white_move("e5")).to eq(false)
      end

      it 'Black does a valid move out of turn.' do
        expect(game.black_move("e5")).to eq(false)
      end

      it 'White does a valid move "e4"' do
        expect(game.white_move("e4")).to eq(true)
      end

    end

    context 'Invalid knight moves' do

      it 'Black knight does invalid move Nf7' do
        expect(game.black_move("Nf7")).to eq(false)
      end

    end

  end

end
