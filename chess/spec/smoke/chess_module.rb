
require_relative '../../app/chess.rb'

module Chess
  
  RSpec.describe 'The Chess module Game class board' do 
    
    let(:game) { Game.new }  

    it 'has a rook in position a1' do
      expect(game.board["a1"].class).to eq(Rook)
    end

    it 'the rook in position a1 is white' do
      rook = game.board["a1"]
      expect(rook.color).to eq(:white)
    end

    it 'the rook in position a1 has 0 moves' do 
      rook = game.board["a1"]
      expect(rook.moves).to eq(0)
    end

    it 'the rook in position a1 has an id of :wR1' do
      rook = game.board["a1"]
      expect(rook.id).to eq(:wR1)
    end

    it 'has a pawn in position a2' do
      expect(game.board["a2"].class).to eq(Pawn)
    end

    it 'the pawn in position a2 has an id of :wP1' do
      pawn = game.board["a2"]
      expect(pawn.id).to eq(:wP1)
    end

    it 'has a vacant a3 square' do
      expect(game.board["a3"].class).to eq(NilClass)
    end 

    it 'has all the pieces where they should be' do
      
      expected_setup = {
        "a1" => Rook,
        "b1" => Knight,
        "c1" => Bishop,
        "d1" => Queen,
        "e1" => King,
        "f1" => Bishop,
        "g1" => Knight,
        "h1" => Rook,
        "a2" => Pawn,
        "b2" => Pawn,
        "c2" => Pawn,
        "d2" => Pawn,
        "e2" => Pawn,
        "f2" => Pawn,
        "g2" => Pawn,
        "h2" => Pawn,
        "a3" => NilClass,
        "b3" => NilClass,
        "c3" => NilClass,
        "d3" => NilClass,
        "e3" => NilClass,
        "f3" => NilClass,
        "g3" => NilClass,
        "h3" => NilClass,
        "a4" => NilClass,
        "b4" => NilClass,
        "c4" => NilClass,
        "d4" => NilClass,
        "e4" => NilClass,
        "f4" => NilClass,
        "g4" => NilClass,
        "h4" => NilClass,
        "a5" => NilClass,
        "b5" => NilClass,
        "c5" => NilClass,
        "d5" => NilClass,
        "e5" => NilClass,
        "f5" => NilClass,
        "g5" => NilClass,
        "h5" => NilClass,
        "a6" => NilClass,
        "b6" => NilClass,
        "c6" => NilClass,
        "d6" => NilClass,
        "e6" => NilClass,
        "f6" => NilClass,
        "g6" => NilClass,
        "h6" => NilClass,
        "a7" => Pawn,
        "b7" => Pawn,
        "c7" => Pawn,
        "d7" => Pawn,
        "e7" => Pawn,
        "f7" => Pawn,
        "g7" => Pawn,
        "h7" => Pawn,
        "a8" => Rook,
        "b8" => Knight,
        "c8" => Bishop,
        "d8" => Queen,
        "e8" => King,
        "f8" => Bishop,
        "g8" => Knight,
        "h8" => Rook
      }

      expected_setup.each do |key, val|
        expect(game.board[key].class).to eq(val)
      end

    end

  end

end
