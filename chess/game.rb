
#Tracks the game
class Game
	attr_reader :moves
	attr_writer 
	def initialize

		@moves = [] 

		@@captured = []

		@@board = {
			a1: Rook.new(color: :w, file:  "a", rank: 1),
			a2: Pawn.new(color: :w, file:  "a", rank: 2),
			a3: Vacant.new(file:  "a", rank: 3),
			a4: Vacant.new(file:  "a", rank: 4),
			a5: Vacant.new(file:  "a", rank: 5),
			a6: Vacant.new(file:  "a", rank: 6),
			a7: Pawn.new(color: :b, file:  "a", rank: 7), 
			a8: Rook.new(color: :b, file:  "a", rank: 8),
			b1: Knight.new(color: :w, file:  "b", rank: 1),
			b2: Pawn.new(color: :w, file:  "b", rank: 2),
			b3: Vacant.new(file:  "b", rank: 3),
			b4: Vacant.new(file:  "b", rank: 4),
			b5: Vacant.new(file:  "b", rank: 5),
			b6: Vacant.new(file:  "b", rank: 6),
			b7: Pawn.new(color: :b, file:  "b", rank: 7),
			b8: Knight.new(color: :b, file:  "a", rank: 8),
			c1: Bishop.new(color: :w, file:  "c", rank: 1),
			c2: Pawn.new(color: :w, file:  "c", rank: 2),
			c3: Vacant.new(file:  "c", rank: 3),
			c4: Vacant.new(file:  "c", rank: 4),
			c5: Vacant.new(file:  "c", rank: 5),
			c6: Vacant.new(file:  "c", rank: 6),
			c7: Pawn.new(color: :b, file:  "c", rank: 7),
			c8: Bishop.new(color: :b, file:  "c", rank: 8),
			d1: Queen.new(color: :w, file:  "d", rank: 1),
			d2: Pawn.new(color: :w, file:  "d", rank: 2),
			d3: Vacant.new(file:  "d", rank: 3),
			d4: Vacant.new(file:  "d", rank: 4),
			d5: Vacant.new(file:  "d", rank: 5),
			d6: Vacant.new(file:  "d", rank: 6),
			d7: Pawn.new(color: :b, file:  "d", rank: 7),
			d8: Queen.new(color: :b, file:  "d", rank: 8),
			e1: King.new(color: :w, file:  "e", rank: 1),
			e2: Pawn.new(color: :w, file:  "e", rank: 2),
			e3: Vacant.new(file:  "e", rank: 3),
			e4: Vacant.new(file:  "e", rank: 4),
			e5: Vacant.new(file:  "e", rank: 5),
			e6: Vacant.new(file:  "e", rank: 6),
			e7: Pawn.new(color: :b, file:  "e", rank: 7),
			e8: King.new(color: :b, file:  "e", rank: 8),
			f1: Bishop.new(color: :w, file:  "f", rank: 1),
			f2: Pawn.new(color: :w, file:  "f", rank: 2),
			f3: Vacant.new(file:  "f", rank: 3),
			f4: Vacant.new(file:  "f", rank: 4),
			f5: Vacant.new(file:  "f", rank: 5),
			f6: Vacant.new(file:  "f", rank: 6),
			f7: Pawn.new(color: :b, file:  "f", rank: 7),
			f8: Bishop.new(color: :b, file:  "f", rank: 8),
			g1: Knight.new(color: :w, file:  "g", rank: 1),
			g2: Pawn.new(color: :w, file:  "g", rank: 2),
			g3: Vacant.new(file:  "g", rank: 3),
			g4: Vacant.new(file:  "g", rank: 4),
			g5: Vacant.new(file:  "g", rank: 5),
			g6: Vacant.new(file:  "g", rank: 6),
			g7: Pawn.new(color: :b, file:  "g", rank: 7),
			g8: Knight.new(color: :b, file:  "g", rank: 8),
			h1: Rook.new(color: :w, file:  "h", rank: 1),
			h2: Pawn.new(color: :w, file:  "h", rank: 2),
			h3: Vacant.new(file:  "h", rank: 3),
			h4: Vacant.new(file:  "h", rank: 4),
			h5: Vacant.new(file:  "h", rank: 5),
			h6: Vacant.new(file:  "h", rank: 6),
			h7: Pawn.new(color: :b, file:  "h", rank: 7),
			h8: Rook.new(color: :b, file:  "h", rank: 8)
		}

	end

	#color: :w, :b
	#boolean if move valid
	def move(color:)
		puts color == :w ? "White move: " : "Black move: "
		pgn_move = $stdin.gets.strip
		if update_board(color, pgn_move)
			@moves.push pgn_move
			return true
		else
			return false
		end
	end

	#return true if move valid and board updated
	#return false if move invalid, do not update board
	def update_board(color, pgn_move)
		
		#who moved?
		m = pgn_move.chars

		if m[0].match?(/[abcdefgh]/) #pawn move
			return PawnMove.new(color: color, pgn_move: pgn_move)
		end

		if m[0] == "K"
			return KingMove.new(color: color, pgn_move: pgn_move)
		end

		return false

	end

	def pp(pos) #piece in position
		pos.unicode
	end

	def print_board
		print_moves
		puts "\n\n"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "8 | #{pp(@@board[:a8])} | #{pp(@@board[:b8])} | #{pp(@@board[:c8])} | #{pp(@@board[:d8])} | #{pp(@@board[:e8])} | #{pp(@@board[:f8])} | #{pp(@@board[:g8])} | #{pp(@@board[:h8])} |"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "7 | #{pp(@@board[:a7])} | #{pp(@@board[:b7])} | #{pp(@@board[:c7])} | #{pp(@@board[:d7])} | #{pp(@@board[:e7])} | #{pp(@@board[:f7])} | #{pp(@@board[:g7])} | #{pp(@@board[:h7])} |"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "6 | #{pp(@@board[:a6])} | #{pp(@@board[:b6])} | #{pp(@@board[:c6])} | #{pp(@@board[:d6])} | #{pp(@@board[:e6])} | #{pp(@@board[:f6])} | #{pp(@@board[:g6])} | #{pp(@@board[:h6])} |"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "5 | #{pp(@@board[:a5])} | #{pp(@@board[:b5])} | #{pp(@@board[:c5])} | #{pp(@@board[:d5])} | #{pp(@@board[:e5])} | #{pp(@@board[:f5])} | #{pp(@@board[:g5])} | #{pp(@@board[:h5])} |"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "4 | #{pp(@@board[:a4])} | #{pp(@@board[:b4])} | #{pp(@@board[:c4])} | #{pp(@@board[:d4])} | #{pp(@@board[:e4])} | #{pp(@@board[:f4])} | #{pp(@@board[:g4])} | #{pp(@@board[:h4])} |"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "3 | #{pp(@@board[:a3])} | #{pp(@@board[:b3])} | #{pp(@@board[:c3])} | #{pp(@@board[:d3])} | #{pp(@@board[:e3])} | #{pp(@@board[:f3])} | #{pp(@@board[:g3])} | #{pp(@@board[:h3])} |"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "2 | #{pp(@@board[:a2])} | #{pp(@@board[:b2])} | #{pp(@@board[:c2])} | #{pp(@@board[:d2])} | #{pp(@@board[:e2])} | #{pp(@@board[:f2])} | #{pp(@@board[:g2])} | #{pp(@@board[:h2])} |"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "1 | #{pp(@@board[:a1])} | #{pp(@@board[:b1])} | #{pp(@@board[:c1])} | #{pp(@@board[:d1])} | #{pp(@@board[:e1])} | #{pp(@@board[:f1])} | #{pp(@@board[:g1])} | #{pp(@@board[:h1])} |"
		puts "  +---+---+---+---+---+---+---+---+"
		puts "    a   b   c   d   e   f   g   h "
		puts "\n\n"
	end

	def print_moves
		puts @moves
	end

end