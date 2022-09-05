require "./game.rb"
require "./pieces.rb"
require "./pawn_move.rb"

class Chess
	def initialize
		@game = Game.new
		play
	end

	private

	def play

		@game.print_board

		game_over = false

		moves = 0
		until game_over do
			moves += 1
			color = moves % 2 == 0 ? :b : :w
			valid_move = false
            until valid_move do 
                valid_move = @game.move(color: color)
            end
			@game.print_board
		end
	end

end

Chess.new