require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The game is played.' do
 
    game = Game.new

    context 'White opens with "e4".' do

      it 'Move is made successfully.' do
        expect(game.white_move("e4")).to eq(true)
      end

      it ':wP5 is on :e4' do
        expect(game.board.squares[:e4]).to eq(:wP5)
      end

     it 'square :e2 is :vac' do
       expect(game.board.squares[:e2]).to eq(:vac)
     end

     it 'game.pieces.data[:wP5][:moves] equals [:e5]' do  
       expect(game.pieces.data[:wP5][:moves]).to eq([:e5])
     end

     it 'game.pieces.data[:wP5][:attacks] equals []' do
       expect(game.pieces.data[:wP5][:attacks]).to eq([])
     end

     it 'game.pieces.data[:wP5][:move_count] is now one' do
       expect(game.pieces.data[:wP5][:move_count]).to eq(1)
     end

   end

   context 'Black moves "e5".' do
 
     it 'is made successfully' do 
       result = game.black_move("e5")
       expect(result).to eq(true)
     end

     it 'updates board square :e5 to be pawn :bP5' do
       expect(game.board.squares[:e5]).to eq(:bP5)
     end

     it 'updates board square :e7 to be vacant' do
       expect(game.board.squares[:e7]).to eq(:vac)
     end

     it 'updates board[:pieces][:bP5][:moves] to equal []' do
       expect(game.pieces.data[:bP5][:moves]).to eq([])
     end

     it 'updates board[:pieces][:bP5][:attacks] to equal []' do
       expect(game.pieces.data[:bP5][:attacks]).to eq([])
     end
 
     it 'updates board[:pieces][:bP5][:move_count] to equal 1' do
       expect(game.pieces.data[:bP5][:move_count]).to eq(1)
     end

    end

  end

end
