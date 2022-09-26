
require_relative '../../app/chess.rb'

module Chess
  
  RSpec.describe 'The Game class' do 
    
    let(:game) { Game.new }  

    it 'setup method returns a struct of the starting board of class ChessBoard' do 
      expect(game.setup.class).to eq(ChessBoard) 
    end

    it 'setup method struct has all the pieces in the right place to start a game' do
      board = game.setup
      expect(board[:a1]).to eq(:wR1)
      expect(board[:b1]).to eq(:wN1)
      expect(board[:c1]).to eq(:wB1)
      expect(board[:d1]).to eq(:wQ1)
      expect(board[:e1]).to eq(:wK1)
      expect(board[:f1]).to eq(:wB2)
      expect(board[:g1]).to eq(:wN2)
      expect(board[:h1]).to eq(:wR2)

      expect(board[:a2]).to eq(:wP1)
      expect(board[:b2]).to eq(:wP2)
      expect(board[:c2]).to eq(:wP3)
      expect(board[:d2]).to eq(:wP4)
      expect(board[:e2]).to eq(:wP5)
      expect(board[:f2]).to eq(:wP6)
      expect(board[:g2]).to eq(:wP7)
      expect(board[:h2]).to eq(:wP8)

      expect(board[:a3]).to eq(:vac)
      expect(board[:b3]).to eq(:vac)
      expect(board[:c3]).to eq(:vac)
      expect(board[:d3]).to eq(:vac)
      expect(board[:e3]).to eq(:vac)
      expect(board[:f3]).to eq(:vac)
      expect(board[:g3]).to eq(:vac)
      expect(board[:h3]).to eq(:vac)

      expect(board[:a4]).to eq(:vac)
      expect(board[:b4]).to eq(:vac)
      expect(board[:c4]).to eq(:vac)
      expect(board[:d4]).to eq(:vac)
      expect(board[:e4]).to eq(:vac)
      expect(board[:f4]).to eq(:vac)
      expect(board[:g4]).to eq(:vac)
      expect(board[:h4]).to eq(:vac)

      expect(board[:a5]).to eq(:vac)
      expect(board[:b5]).to eq(:vac)
      expect(board[:c5]).to eq(:vac)
      expect(board[:d5]).to eq(:vac)
      expect(board[:e5]).to eq(:vac)
      expect(board[:f5]).to eq(:vac)
      expect(board[:g5]).to eq(:vac)
      expect(board[:h5]).to eq(:vac)

      expect(board[:a6]).to eq(:vac)
      expect(board[:b6]).to eq(:vac)
      expect(board[:c6]).to eq(:vac)
      expect(board[:d6]).to eq(:vac)
      expect(board[:e6]).to eq(:vac)
      expect(board[:f6]).to eq(:vac)
      expect(board[:g6]).to eq(:vac)
      expect(board[:h6]).to eq(:vac)

      expect(board[:a7]).to eq(:bP1)
      expect(board[:b7]).to eq(:bP2)
      expect(board[:c7]).to eq(:bP3)
      expect(board[:d7]).to eq(:bP4)
      expect(board[:e7]).to eq(:bP5)
      expect(board[:f7]).to eq(:bP6)
      expect(board[:g7]).to eq(:bP7)
      expect(board[:h7]).to eq(:bP8)

      expect(board[:a8]).to eq(:bR1)
      expect(board[:b8]).to eq(:bN1)
      expect(board[:c8]).to eq(:bB1)
      expect(board[:d8]).to eq(:bQ1)
      expect(board[:e8]).to eq(:bK1)
      expect(board[:f8]).to eq(:bB2)
      expect(board[:g8]).to eq(:bN2)
      expect(board[:h8]).to eq(:bR2)                   

    end

    it 'moves the white pawn from e2 to e4 based on PGN notation "e4"'
    
  end
end
