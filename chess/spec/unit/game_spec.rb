require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The game is started!' do

    game = Game.new
    
    context 'The board[:pieces][pawn][:moves] should be set.' do
      it 'Each pawn has two moves that are correct.' do

        expect(game.board[:pieces][:wP1][:moves]).to eq([:a3, :a4])
        expect(game.board[:pieces][:wP2][:moves]).to eq([:b3, :b4])
        expect(game.board[:pieces][:wP3][:moves]).to eq([:c3, :c4])
        expect(game.board[:pieces][:wP4][:moves]).to eq([:d3, :d4])
        expect(game.board[:pieces][:wP5][:moves]).to eq([:e3, :e4])
        expect(game.board[:pieces][:wP6][:moves]).to eq([:f3, :f4])
        expect(game.board[:pieces][:wP7][:moves]).to eq([:g3, :g4])
        expect(game.board[:pieces][:wP8][:moves]).to eq([:h3, :h4])
        expect(game.board[:pieces][:bP1][:moves]).to eq([:a6, :a5])
        expect(game.board[:pieces][:bP2][:moves]).to eq([:b6, :b5])
        expect(game.board[:pieces][:bP3][:moves]).to eq([:c6, :c5])
        expect(game.board[:pieces][:bP4][:moves]).to eq([:d6, :d5])
        expect(game.board[:pieces][:bP5][:moves]).to eq([:e6, :e5])
        expect(game.board[:pieces][:bP6][:moves]).to eq([:f6, :f5])
        expect(game.board[:pieces][:bP7][:moves]).to eq([:g6, :g5])
        expect(game.board[:pieces][:bP8][:moves]).to eq([:h6, :h5])

      end

      it 'Each knight has its moves set.' do
        expect(game.board[:pieces][:wN1][:moves]).to eq([:c3, :a3])
        expect(game.board[:pieces][:wN2][:moves]).to eq([:h3, :f3])
        expect(game.board[:pieces][:bN1][:moves]).to eq([:c6, :a6])
        expect(game.board[:pieces][:bN2][:moves]).to eq([:h6, :f6])        
      end
      
    end

    context 'The board[:pieces][piece][:move_count] is set.' do
      
      it 'Every piece has 0 moves.' do
        game.board[:pieces].each do |key,val|
          expect(val[:move_count]).to eq(0)
        end
      end

    end

    context 'The board[:pieces][:threats] are set.' do
    
      it 'Has no threats registered since no moves have been made.' do
        game.board[:pieces].each do |key,val|
          expect(val[:threats].class).to eq(Array)
          expect(val[:threats].count).to eq(0)
        end
      end

    end

    context 'The board[:pieces][piece][:attacks] are set.' do
      
      it 'Each piece has no attacks set' do
        game.board[:pieces].each do |key,val|
          expect(val[:attacks].class).to eq(Array)
          expect(val[:attacks].count).to eq(0)
        end
      end

    end

    context 'The board[:pieces][piece][:captured] is set.' do

      it 'No pieces are captured.' do
        game.board[:pieces].each do |key,val|
          expect(val[:captured]).to eq(false)
        end
      end

    end

  end

end
