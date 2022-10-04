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

      expect(game.board[:pieces][:wP1][:attacks]).to eq([:a3, :a4])
      expect(game.board[:pieces][:wP2][:attacks]).to eq([:b3, :b4])
      expect(game.board[:pieces][:wP3][:attacks]).to eq([:c3, :c4])
      expect(game.board[:pieces][:wP4][:attacks]).to eq([:d3, :d4])
      expect(game.board[:pieces][:wP5][:attacks]).to eq([:e3, :e4])
      expect(game.board[:pieces][:wP6][:attacks]).to eq([:f3, :f4])
      expect(game.board[:pieces][:wP7][:attacks]).to eq([:g3, :g4])
      expect(game.board[:pieces][:wP8][:attacks]).to eq([:h3, :h4])
      expect(game.board[:pieces][:bP1][:attacks]).to eq([:a6, :a5])
      expect(game.board[:pieces][:bP2][:attacks]).to eq([:b6, :b5])
      expect(game.board[:pieces][:bP3][:attacks]).to eq([:c6, :c5])
      expect(game.board[:pieces][:bP4][:attacks]).to eq([:d6, :d5])
      expect(game.board[:pieces][:bP5][:attacks]).to eq([:e6, :e5])
      expect(game.board[:pieces][:bP6][:attacks]).to eq([:f6, :f5])
      expect(game.board[:pieces][:bP7][:attacks]).to eq([:g6, :g5])
      expect(game.board[:pieces][:bP8][:attacks]).to eq([:h6, :h5])

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

end
