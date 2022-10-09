require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The game is played.' do
 
    game = Game.new

    context 'White opens with "e4".' do

      it 'Move is made successfully.' do
        result = game.white_move(pgn_move: "e4")
        expect(result).to eq(true)
      end

      it ':wP5 is on :e4' do
        expect(game.board[:squares][:e4]).to eq(:wP5)
      end

      it 'space :e2 is :vac' do
        expect(game.board[:squares][:e2]).to eq(:vac)
      end

      it 'board[:pieces][:wP5][:moves] equals [:e5]' do  
        expect(game.board[:pieces][:wP5][:moves]).to eq([:e5])
      end

      it 'board[:pieces][:wP5][:attacks] equals []' do
        expect(game.board[:pieces][:wP5][:attacks]).to eq([])
      end

      it 'board[:pieces][:wP5][:move_count] is now one' do
        expect(game.board[:pieces][:wP5][:move_count]).to eq(1)
      end

    end

     context 'The board is printed.' do

      it 'Verify printed board looks correct.' do
        expect(game.print_board).to eq(true)
      end

    end

    context 'Black moves "e5".' do
  
      it 'is made successfully' do 
        result = game.black_move(pgn_move: "e5")
        expect(result).to eq(true)
      end

      it 'updates board space :e5 to be pawn :bP5' do
        expect(game.board[:squares][:e5]).to eq(:bP5)
      end

      it 'updates board space :e7 to be vacant' do
        expect(game.board[:squares][:e7]).to eq(:vac)
      end

      it 'updates board[:pieces][:bP5][:moves] to equal []' do
        expect(game.board[:pieces][:bP5][:moves]).to eq([])
      end

      it 'updates board[:pieces][:bP5][:attacks] to equal []' do
        expect(game.board[:pieces][:bP5][:attacks]).to eq([])
      end
  
      it 'updates board[:pieces][:bP5][:move_count] to equal 1' do
        expect(game.board[:pieces][:bP5][:move_count]).to eq(1)
      end

    end

    context 'The board is printed.' do

      it 'Verify printed board looks correct.' do
        expect(game.print_board).to eq(true)
      end

    end

    context 'White moves "d4"' do
  
      it 'makes the move successfully' do 
        expect(game.white_move(pgn_move: "d4")).to eq(true)
      end

      it 'updates board[:pieces][:wP4][:attacks] to equal [:e5]' do
        expect(game.board[:pieces][:wP4][:attacks]).to eq([:e5])
      end
    
      it 'updates board[:pieces][:wP4][:moves] to equal [:d5]' do
        expect(game.board[:pieces][:wP4][:moves]).to eq([:d5])
      end

      it 'updates board[:pieces][:bP5][:threats] to equal [:d4]' do 
        expect(game.board[:pieces][:bP5][:threats]).to eq([:d4])
      end

      it 'updates board[:pieces][:wP4][:threats] to equal [:e5]' do
        expect(game.board[:pieces][:wP4][:threats]).to eq([:e5])
      end

      it 'updates board[:pieces][:wP4][:move_count] to equal 1' do
        expect(game.board[:pieces][:wP4][:move_count]).to eq(1)
      end

    end

    context 'The board is printed.' do

      it 'Verify printed board looks correct.' do
        expect(game.print_board).to eq(true)
      end

    end

    context 'Black moves "exd4" to take white pawn on d4' do

      it 'makes the move successfully' do
        expect(game.black_move(pgn_move: "exd4")).to eq(true)
      end 

      it 'white pawn :wP4 is captured' do
        expect(game.board[:pieces][:wP4][:captured]).to eq(true)
      end

      it 'black pawn :bP5 is on space :d4' do 
        expect(game.board[:squares][:d4]).to eq(:bP5)
      end

      it 'black pawn :bP5 has no threats' do
        expect(game.board[:pieces][:bP5][:threats].count).to eq(0)
      end

      it 'black pawn :bP5 has one move to :d3' do
        expect(game.board[:pieces][:bP5][:moves]).to eq([:d3])
      end

      it 'black pawn :bP5 has two moves counted' do
        expect(game.board[:pieces][:bP5][:move_count]).to eq(2)
      end

    end

    context 'The board is printed.' do

      it 'Verify printed board looks correct.' do
        expect(game.print_board).to eq(true)
      end      

    end


    context 'White moves "e5"' do
    
      it 'makes the move successfully' do
        expect(game.white_move(pgn_move: "e5")).to eq(true)
      end

      it 'pawn :wP5 is on :e5' do
        expect(game.board[:squares][:e5]).to eq(:wP5)
      end

      it 'square :e4 is :vac' do
        expect(game.board[:squares][:e4]).to eq(:vac)
      end

      it 'pawn :wP5 has no threats' do
        expect(game.board[:pieces][:wP5][:threats].count).to eq(0)
      end

      it 'pawn :wP5 has one move to :e6' do
        expect(game.board[:pieces][:wP5][:moves]).to eq([:e6])
      end

      it 'pawn :wP5 has two moves in its count' do
        expect(game.board[:pieces][:wP5][:move_count]).to eq(2)
      end      

      it 'pawn :wP5 has no attacks' do
        expect(game.board[:pieces][:wP5][:attacks].count).to eq(0)
      end

    end

    context 'The board is printed.' do

      it 'Verify printed board looks correct.' do
        expect(game.print_board).to eq(true)
      end      

    end

    context ':bP6 moves "f5" creating a threat for itself because of en passant by :wP5 on :e5' do
    
      it ':bP6 makes the move "f5" successfully' do
        expect(game.black_move(pgn_move: "f5")).to eq(true)
      end

      it ':bP6 has a threat from :e5' do
        expect(game.board[:pieces][:bP6][:threats]).to eq([:e5])
      end

      it 'white pawn :wP5 has an attack on square :f6 because of en passant' do
        expect(game.board[:pieces][:wP5][:attacks]).to eq([:f6])
      end

    end

    context 'The board is printed.' do

      it 'Verify printed board looks correct.' do
        expect(game.print_board).to eq(true)
      end

    end

    context 'White moves: exf6 - White does en passant with pawn :wP5 on :e5' do

      it 'white moves exf6 "en passant"' do
        expect(game.white_move(pgn_move: "exf6")).to eq(true)
      end

      it 'captures black pawn :bP6 on :f5'

      it 'board shows :wP5 on square :f6'

      it ':wP5 now has threats from :d8(:bQ), :g7(:bP7), and :g8(:bN2)'

      it ':wP5 has move :f7 only'

      it ':wP5 can attack :g7'

    end

    context 'The board is printed.' do

      it 'Verify printed board looks correct.' do
        expect(game.print_board).to eq(true)
      end      

    end

  end

end
