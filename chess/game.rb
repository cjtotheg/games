
#Tracks the game
class Game
	attr_reader :moves
	attr_writer 
	def initialize

		@moves = [] 

		@@captured = []

		# "The Attack Matrix"
		@@attacks = {
			a1: { w: [], b: [] },
			a2: { w: [], b: [] },
			a3: { w: [], b: [] },
			a4: { w: [], b: [] },
			a5: { w: [], b: [] },
			a6: { w: [], b: [] },
			a7: { w: [], b: [] },
			a8: { w: [], b: [] },
			b1: { w: [], b: [] },
			b2: { w: [], b: [] },
			b3: { w: [], b: [] },
			b4: { w: [], b: [] },
			b5: { w: [], b: [] },
			b6: { w: [], b: [] },
			b7: { w: [], b: [] },
			b8: { w: [], b: [] },
			c1: { w: [], b: [] },
			c2: { w: [], b: [] },
			c3: { w: [], b: [] },
			c4: { w: [], b: [] },
			c5: { w: [], b: [] },
			c6: { w: [], b: [] },
			c7: { w: [], b: [] },
			c8: { w: [], b: [] },
			d1: { w: [], b: [] },
			d2: { w: [], b: [] },
			d3: { w: [], b: [] },
			d4: { w: [], b: [] },
			d5: { w: [], b: [] },
			d6: { w: [], b: [] },
			d7: { w: [], b: [] },
			d8: { w: [], b: [] },
			e1: { w: [], b: [] },
			e2: { w: [], b: [] },
			e3: { w: [], b: [] },
			e4: { w: [], b: [] },
			e5: { w: [], b: [] },
			e6: { w: [], b: [] },
			e7: { w: [], b: [] },
			e8: { w: [], b: [] },
			f1: { w: [], b: [] },
			f2: { w: [], b: [] },
			f3: { w: [], b: [] },
			f4: { w: [], b: [] },
			f5: { w: [], b: [] },
			f6: { w: [], b: [] },
			f7: { w: [], b: [] },
			f8: { w: [], b: [] },
			g1: { w: [], b: [] },
			g2: { w: [], b: [] },
			g3: { w: [], b: [] },
			g4: { w: [], b: [] },
			g5: { w: [], b: [] },
			g6: { w: [], b: [] },
			g7: { w: [], b: [] },
			g8: { w: [], b: [] },
			h1: { w: [], b: [] },
			h2: { w: [], b: [] },
			h3: { w: [], b: [] },
			h4: { w: [], b: [] },
			h5: { w: [], b: [] },
			h6: { w: [], b: [] },
			h7: { w: [], b: [] },
			h8: { w: [], b: [] }
		}

		# "The Board"
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

		#pawn move
		if m[0].match?(/[abcdefgh]/) 
			pawn = PawnMove.new
			return pawn.move(color: color, pgn_move: pgn_move)
		end

		#king move
		if m[0] == "K"
			king = KingMove.new
			return king.move(color: color, pgn_move: pgn_move)
		end

		puts "Invalid move entered."
		return false

	end

	######
	## "The Attack Matrix"
	## identify any square that is under attack by any piece on the board
	## this is updated every move
	def update_attacks

		@@board.each do |pos,val|
			foo #make the attack matrix off of Piece.valid_moves
		end

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