
require_relative '../../app/chess.rb'

module Chess
  RSpec.describe 'The board' do 
    
    let(:game) { Game.new }  

    it 'has all the pieces where they should be' do
      
      expected_board = {
        a1: :wR1, b1: :wN1, c1: :wB1, d1: :wQ1, e1: :wK,  f1: :wB2, g1: :wN2, h1: :wR2,
        a2: :wP1, b2: :wP2, c2: :wP3, d2: :wP4, e2: :wP5, f2: :wP6, g2: :wP7, h2: :wP8,
        a3: :vac, b3: :vac, c3: :vac, d3: :vac, e3: :vac, f3: :vac, g3: :vac, h3: :vac,
        a4: :vac, b4: :vac, c4: :vac, d4: :vac, e4: :vac, f4: :vac, g4: :vac, h4: :vac,
        a5: :vac, b5: :vac, c5: :vac, d5: :vac, e5: :vac, f5: :vac, g5: :vac, h5: :vac,
        a6: :vac, b6: :vac, c6: :vac, d6: :vac, e6: :vac, f6: :vac, g6: :vac, h6: :vac,
        a7: :bP1, b7: :bP2, c7: :bP3, d7: :bP4, e7: :bP5, f7: :bP6, g7: :bP7, h7: :bP8,
        a8: :bR1, b8: :bN1, c8: :bB1, d8: :bQ1, e8: :bK,  f8: :bB2, g8: :bN2, h8: :bR2
      }        

      expected_board.each do |key, val|
        expect(game.board.squares[key]).to eq(val)
      end

    end

  end

end
