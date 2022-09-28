require_relative '../../app/chess.rb'

RSpec.describe 'The Pawn class' do

  let(:game) { Game.new }
  let(:pawn) { Pawn.new(id: :wP5, color: :white) }

  it 'move "e4" moves pawn on "e2" to "e4" ' do
      
    result = pawn.move(pgn_move: "e4", color: :white)

    expect(result).to eq(true)
    expect(BOARD["e4"].class).to eq(Pawn)
    pawn = BOARD["e4"]
    expect(pawn.moves).to eq(1)
    expect(pawn.id).to eq(:wP5)
    expect(pawn.color).to eq(:white)
    expect(BOARD["e2"]).to eq(nil)

  end

end

