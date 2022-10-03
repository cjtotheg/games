require_relative '../../app/chess.rb'

module Chess

  game = Game.new

  RSpec.describe 'The board is printed' do

    it 'the pieces should be in the correct starting position' do
      expect(game.print_board).to eq(true)
    end

  end

  RSpec.describe 'The board[:pieces][:attacks] should be set' do
    it 'has the pawn moves set' do

      game.board[:pieces].each do |key,val|
        puts "#{key}: #{val}"
      end

      expect(game.board[:pieces][:wP1][:attacks]).to eq([:a3, :a4])
    end
    it 'has the knight moves set'
  end

  RSpec.describe 'The board[:pieces][:threats] should be set' do
    it 'has no threats registered since no moves are made' do
      game.board[:pieces].each do |key,val|
        expect(val[:threats].class).to eq(Array)
        expect(val[:threats].count).to eq(0)
      end
    end
  end

  RSpec.describe 'The board[:pieces][:moves] should be blank' do
    it 'has no moves registered yet' do
      game.board[:pieces].each do |key,val|
        expect(val[:moves].class).to eq(Array)
        expect(val[:moves].count).to eq(0)
      end
    end
  end

  RSpec.describe 'The board[:pieces][:captured] should all equal false' do 
    it 'has no captured pieces' do
      game.board[:pieces].each do |key,val|
        expect(val[:captured]).to eq(false)
      end
    end
  end

  RSpec.describe 'Making white opening move "e4"' do

    it 'is made successfully' do
      result = game.white_move(pgn_move: "e4")
      expect(result).to eq(true)
    end

    it 'updates board space :e4 to be pawn :wP5' do
      expect(game.board[:squares][:e4]).to eq(:wP5)
    end

    it 'updates board space :e2 to be nil (vacant)' do
      expect(game.board[:squares][:e2]).to eq(nil)
    end

    it 'adds the move to Game::@board[:pieces][:wP5][:moves]' do  
      expect(game.board[:pieces][:wP5][:moves].count).to eq(1)
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

    it 'updates board space :e7 to be nil (vacant)' do
      expect(game.board[:squares][:e7]).to eq(nil)
    end

    it 'adds the move to Game::@board[:pieces][:bP5][:moves]' do
      expect(game.board[:pieces][:bP5][:moves].count).to eq(1)
    end

    it 'verify printed board' do 
      expect(game.print_board).to eq(true)
    end

  end

  RSpec.describe 'White moves "d4" attacking bP5 on e5' do
  
   it 'makes the move successfully' do 
     expect(game.white_move(pgn_move: "d4")).to eq(true)
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
