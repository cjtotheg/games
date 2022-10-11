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

    context ':bP6 moves "f5" creating a threat for itself because of en passant by :wP5 on :e5' do
    
      it ':bP6 makes the move "f5" successfully' do
        expect(game.black_move(pgn_move: "f5")).to eq(true)
      end

      it ':bP6 has an en passant threat from :e5' do
        expect(game.board[:pieces][:bP6][:ep_threats]).to eq([:e5])
      end

      it 'white pawn :wP5 has an en passant attack on square :f6' do
        expect(game.board[:pieces][:wP5][:ep_attacks]).to eq([:f6])
      end

    end

    context 'White moves: exf6 - White does en passant with pawn :wP5 on :e5' do

      it 'white moves exf6 "en passant"' do
        expect(game.white_move(pgn_move: "exf6")).to eq(true)
      end

      it 'captures black pawn :bP6 on :f5' do
        expect(game.board[:pieces][:bP6][:captured]).to eq(true)
      end

      it 'board shows :wP5 on square :f6' do
        expect(game.board[:squares][:f6]).to eq(:wP5)
      end

      it 'ep_attacks for :wP5 are blank' do
        expect(game.board[:pieces][:wP5][:ep_attacks]).to eq([])
      end

      it ':wP5 now has a threat from the Queen :bQ  on :d8' do
        pending("Need to implement queen moves")
        expect(game.board[:pieces][:wP5][:threats]).to include(:d8)
      end

      it ':wP5 has a threat from :bN2 on :g8' do
        expect(game.board[:pieces][:wP5][:threats]).to include(:g8)
      end

      it ':wP5 has a threat from :bP7 on :g7' do
        expect(game.board[:pieces][:wP5][:threats]).to include(:g7)
      end 

      it ':wP5 has move :f7 only' do
        expect(game.board[:pieces][:wP5][:moves]).to eq([:f7])
      end

      it ':wP5 can attack :g7' do
        expect(game.board[:pieces][:wP5][:attacks]).to eq([:g7])
      end

    end

    context 'Black moves "d3", there are two black pawns on that file now' do

      it 'move is successful' do
        expect(game.black_move(pgn_move: "d3")).to eq(true)
      end

      it 'board has :bP5 on :d3' do
        expect(game.board[:squares][:d3]).to eq(:bP5)
      end

      it ':bP5 has :c2 as an attack' do
        expect(game.board[:pieces][:bP5][:attacks]).to eq([:c2])
      end

      it ':bP5 has bishop on :f1 as a threat' do
        pending("Bishop moves are not implemented yet")
        expect(game.board[:pieces][:bP5][:threats]).to include(:f1)
      end

      it ':wP3 has pawn on :d3 as a threat' do
        expect(game.board[:pieces][:wP3][:threats]).to eq([:d3])
      end

    end

    context 'White moves "f7", putting the black king in check and attacking knight on :g1'do

      it 'move is successful' do
        expect(game.white_move(pgn_move: "f7")).to eq(true)
      end
      
      it 'board has :wP5 on :f7' do
        expect(game.board[:squares][:f7]).to eq(:wP5)
      end
      
      it ':bK is in check due to :wP5 on :f7' do
        expect(game.board[:pieces][:bK][:threats]).to eq([:f7])
      end

      it ':wP5 has king on :e8 as an attack (check) and knight :g8 as an attack' do
        expect(game.board[:pieces][:wP5][:attacks]).to eq([:e8, :g8])
      end

    end

    context 'Black is forced to clear the check' do
      
      it 'black moves king to :e7'

      it 'Verify printed board looks correct.'      

    end

    context 'White moves "fxg8" both taking the knight on g8 and getting promoted' do

      it 'move is successful' do
        expect(game.white_move(pgn_move: "fxg8")).to eq(true)
      end

      it 'knight :bN2 on :g8 is captured' do
        expect(game.board[:pieces][:bN2][:captured]).to eq(true)
      end

      it 'pawn is promoted, board has :wQ2 on :g8' do
        expect(game.board[:squares][:g8]).to eq(:wQ2)
      end

      it 'pawn is deleted from board[:pieces]' do
        expect(game.board[:pieces][:wP5]).to eq(nil)
      end

      it 'pawn is deleted from board[:squares]' do
        expect(game.board[:squares].value?(:wP5)).to eq(false)
      end

    end

    context 'Black moves "d2", there are two pawns on that file now, king :e1 is in check, and bishop :c1 is attacked' do

      it 'move is successful' do
        expect(game.black_move(pgn_move: "d2")).to eq(true)
      end

      it 'board has :bP5 on :d2' do
        expect(game.board[:squares][:d2]).to eq(:bP5)
      end

      it 'king :e1 is in check' do
        expect(game.board[:pieces][:wK][:threats]).to eq([:d2])
      end

      it ':bP5 has queen :e1 as a threat'

      it ':bP5 has king :d1 as a threat'

      it ':bP5 has bishop :c1 as a threat'

      it ':bP5 has :c1 as an attack and king :e1 as an attack' do
        expect(game.board[:pieces][:bP5][:attacks]).to eq([:c1, :e1])
      end

    end

  end

end
