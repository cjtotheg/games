require_relative '../../app/chess.rb'

module Chess

  RSpec.describe 'The pieces data is set.' do

    board = Board.new
    pieces = Pieces.new
    pieces.update(board)
    
    
    context 'The pieces.data[pawn][:moves] should be set.' do
      it 'Each pawn has two moves that are correct.' do

        expect(pieces.data[:wP1][:moves]).to eq([:a3, :a4])
        expect(pieces.data[:wP2][:moves]).to eq([:b3, :b4])
        expect(pieces.data[:wP3][:moves]).to eq([:c3, :c4])
        expect(pieces.data[:wP4][:moves]).to eq([:d3, :d4])
        expect(pieces.data[:wP5][:moves]).to eq([:e3, :e4])
        expect(pieces.data[:wP6][:moves]).to eq([:f3, :f4])
        expect(pieces.data[:wP7][:moves]).to eq([:g3, :g4])
        expect(pieces.data[:wP8][:moves]).to eq([:h3, :h4])
        expect(pieces.data[:bP1][:moves]).to eq([:a6, :a5])
        expect(pieces.data[:bP2][:moves]).to eq([:b6, :b5])
        expect(pieces.data[:bP3][:moves]).to eq([:c6, :c5])
        expect(pieces.data[:bP4][:moves]).to eq([:d6, :d5])
        expect(pieces.data[:bP5][:moves]).to eq([:e6, :e5])
        expect(pieces.data[:bP6][:moves]).to eq([:f6, :f5])
        expect(pieces.data[:bP7][:moves]).to eq([:g6, :g5])
        expect(pieces.data[:bP8][:moves]).to eq([:h6, :h5])

      end

      it 'Each knight has its moves set.' do
        expect(pieces.data[:wN1][:moves]).to eq([:c3, :a3])
        expect(pieces.data[:wN2][:moves]).to eq([:h3, :f3])
        expect(pieces.data[:bN1][:moves]).to eq([:c6, :a6])
        expect(pieces.data[:bN2][:moves]).to eq([:h6, :f6])        
      end
      
    end

    context 'The pieces move count is set to zero.' do
      
      it 'Every piece has 0 moves.' do
        pieces.data.each do |key,val|
          expect(val[:move_count]).to eq(0)
        end
      end

    end

    context 'The threats are set.' do
    
      it 'Has no threats registered since no moves have been made.' do
        pieces.data.each do |key,val|
          expect(val[:threats].class).to eq(Array)
          expect(val[:threats].count).to eq(0)
        end
      end

    end

    context 'The attacks are set.' do
      
      it 'Each piece has no attacks set' do
        pieces.data.each do |key,val|
          expect(val[:attacks].class).to eq(Array)
          expect(val[:attacks].count).to eq(0)
        end
      end

    end

    context 'The pieces show no captured.' do

      it 'No pieces are captured.' do
        pieces.data.each do |key,val|
          expect(val[:captured]).to eq(false)
        end
      end

    end

    context 'The pieces class can add a new piece (promotion)' do

      it 'Adds a white queen' do
        pieces.create_piece(piece_id: :wQ2)
        expect(pieces.data[:wQ2][:captured]).to eq(false)
      end

    end

  end

end
