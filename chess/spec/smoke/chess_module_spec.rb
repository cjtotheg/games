
require_relative '../../app/chess.rb'

module Chess
  RSpec.describe 'The board' do 
    
    let(:game) { Game.new }  

    it 'has all the pieces where they should be' do
      
      expected_board = {
        a1: :wR1, b1: :wN1, c1: :wB1, d1: :wQ1, e1: :wK,  f1: :wB2, g1: :wN2, h1: :wR2,
        a2: :wP1, b2: :wP2, c2: :wP3, d2: :wP4, e2: :wP5, f2: :wP6, g2: :wP7, h2: :wP8,
        a3: nil,  b3: nil,  c3: nil,  d3: nil,  e3: nil,  f3: nil,  g3: nil,  h3: nil,
        a4: nil,  b4: nil,  c4: nil,  d4: nil,  e4: nil,  f4: nil,  g4: nil,  h4: nil,
        a5: nil,  b5: nil,  c5: nil,  d5: nil,  e5: nil,  f5: nil,  g5: nil,  h5: nil,
        a6: nil,  b6: nil,  c6: nil,  d6: nil,  e6: nil,  f6: nil,  g6: nil,  h6: nil,
        a7: :bP1, b7: :bP2, c7: :bP3, d7: :bP4, e7: :bP5, f7: :bP6, g7: :bP7, h7: :bP8,
        a8: :bR1, b8: :bN1, c8: :bB1, d8: :bQ1, e8: :bK,  f8: :bB2, g8: :bN2, h8: :bR2
      }        

      expected_board.each do |key, val|
        expect(game.board[:squares][key]).to eq(val)
      end

    end

  end

end
