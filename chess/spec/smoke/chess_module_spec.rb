
require_relative '../../app/chess.rb'

module Chess
  RSpec.describe 'The board' do 
    
    let(:game) { Game.new }  

    it 'has all the pieces where they should be' do
      
      expected_setup = {

      }

      expected_setup.each do |key, val|
        expect(game.board[key]).to eq(val)
      end

    end

  end

end
