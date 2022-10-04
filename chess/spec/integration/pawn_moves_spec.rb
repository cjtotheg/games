require_relative '../../app/chess.rb'

module Chess

  game = Game.new

  RSpec.describe 'Making white opening move "e4"' do

    it 'is made successfully' do
      result = game.white_move(pgn_move: "e4")
      expect(result).to eq(true)
    end

    it 'updates board space :e4 to be pawn :wP5' do
      expect(game.board[:squares][:e4]).to eq(:wP5)
    end

    it 'updates board space :e2 to be vacant' do
      expect(game.board[:squares][:e2]).to eq(:vac)
    end

    it 'updates board[:pieces][:wP5][:moves] to equal [:e5]' do  
      expect(game.board[:pieces][:wP5][:moves]).to eq([:e5])
    end

    it 'updates board[:pieces][:wP5][:attacks] to []' do
      expect(game.board[:pieces][:wP5][:attacks]).to eq([])
    end

    it 'verify printed board' do 
      expect(game.print_board).to eq(true)
    end

  end

  RSpec.describe 'Making black opening move "e5"' do
  
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

    it 'verify printed board' do 
      expect(game.print_board).to eq(true)
    end

  end

  RSpec.describe 'White moves "d4" attacking bP5 on e5' do
  
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

    it 'verify printed board' do
      expect(game.print_board).to eq(true)
    end

  end


  RSpec.describe 'Black moves "exd4" to take white pawn on d4' do

    it 'makes the move successfully' do
      expect(game.black_move(pgn_move: "exd4")).to eq(true)
    end 

    it 'black pawn :bP5 is on space :d4' do 
      expect(game.board[:squares][:d4]).to eq(:bP5)
    end

    it 'black pawn :bP5 has two moves in its count'

    it 'verify printed board' do
      expect(game.print_board).to eq(true)
    end

  end

end
