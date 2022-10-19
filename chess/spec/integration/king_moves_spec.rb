require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The game is played.' do

    game = Game.new

    context 'Moves are made that make it so the king can move.' do

      it 'Some quick moves to set up the board.' do
        
        moves = [
          ["e4", "e5"],
          ["Ke2","Ke7"],
          ["Ke3","Ke6"] 
        ]
        
        moves.each do |white, black|
          expect(game.white_move(white)).to eq(true)
          expect(game.black_move(black)).to eq(true)
        end

      end

      it 'king cannot move into check' do 
        expect(game.white_move("Kd4")).to eq(false)
      end

      it 'king cannot take a piece if it puts him in check'

    end

  end

end
