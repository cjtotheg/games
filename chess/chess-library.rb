class Chess
	def initialize

		@board = {
			a1: Rook.new(:w, :a1),
			a2: Pawn.new(:w, :a2),
			a3: Vacant.new(:a3),
			a4: Vacant.new(:a4),
			a5: Vacant.new(:a5),
			a6: Vacant.new(:a6),
			a7: Pawn.new(:b, :a7), 
			a8: Rook.new(:b, :a8),
			b1: Knight.new(:w, :b1),
			b2: Pawn.new(:w, :b2),
			b3: Vacant.new(:b3),
			b4: Vacant.new(:b4),
			b5: Vacant.new(:b5),
			b6: Vacant.new(:b6),
			b7: Pawn.new(:b, :b7),
			b8: Knight.new(:b, :b8),
			c1: Bishop.new(:w, :c1),
			c2: Pawn.new(:w, :c2),
			c3: Vacant.new(:c3),
			c4: Vacant.new(:c4),
			c5: Vacant.new(:c5),
			c6: Vacant.new(:c6),
			c7: Pawn.new(:b, :c7),
			c8: Bishop.new(:b, :c8),
			d1: Queen.new(:w, :d1),
			d2: Pawn.new(:w, :d2),
			d3: Vacant.new(:d3),
			d4: Vacant.new(:d4),
			d5: Vacant.new(:d5),
			d6: Vacant.new(:d6),
			d7: Pawn.new(:b, :d7),
			d8: Queen.new(:b, :d8),
			e1: King.new(:w, :e1),
			e2: Pawn.new(:w, :e2),
			e3: Vacant.new(:e3),
			e4: Vacant.new(:e4),
			e5: Vacant.new(:e5),
			e6: Vacant.new(:e6),
			e7: Pawn.new(:b, :e7),
			e8: King.new(:b, :e8),
			f1: Bishop.new(:w, :f1),
			f2: Pawn.new(:w, :f2),
			f3: Vacant.new(:f3),
			f4: Vacant.new(:f4),
			f5: Vacant.new(:f5),
			f6: Vacant.new(:f6),
			f7: Pawn.new(:b, :f7),
			f8: Bishop.new(:b, :f8),
			g1: Knight.new(:w, :g1),
			g2: Pawn.new(:w, :g2),
			g3: Vacant.new(:g3),
			g4: Vacant.new(:g4),
			g5: Vacant.new(:g5),
			g6: Vacant.new(:g6),
			g7: Pawn.new(:b, :g7),
			g8: Knight.new(:b, :g8),
			h1: Rook.new(:w, :h1),
			h2: Pawn.new(:w, :h2),
			h3: Vacant.new(:h3),
			h4: Vacant.new(:h4),
			h5: Vacant.new(:h5),
			h6: Vacant.new(:h6),
			h7: Pawn.new(:b, :h7),
			h8: Rook.new(:b, :h8)
		}

		@moves = [] #array of arrays in algebraic notation white black 

	end

	public

	def play

		print_board

		game_over = false

		until game_over do
			
			valid_move = false
			until valid_move do
				white_move = get_move(:w)
				valid_move = validate_move(white_move)
			end
			update_board(convert_algebraic(:w, white_move))
			print_board
			
			#@moves.push [white_move, black_move]
			game_over = true

		end
	end

	private

	def get_move(color)
		puts color == :w ? "White move: " : "Black move: "
		$stdin.gets.strip
	end

	def convert_algebraic(color, algebraic_move)
		# returns hash coded_move
		# piece - in symbol (ex: wK, bN1)
		# from - board pos (ex: a1, c3)
		# to - board pos

		puts "w: hard coded!"

		#this is what we want...
		coded_move = {
			piece: @board[:e2],
			from: :e2,
			to: :e4
		}

		move = algebraic_move.chars

		return coded_move

	end

	def validate_move(algebraic_move) #move in algebraic notation (PNG)
		#this will be a big set of logic!
		puts "w: not validating"
		return true
	end

	def update_board(move)
		@board[move[:from]] = Vacant.new(move[:from])
		@board[move[:to]] = move[:piece]
		@board[move[:to]].moves += 1
		@board[move[:to]].position = move[:to]
		return true
	end

	def pp(pos) #piece in position
		pos.unicode
	end

	def print_board
		puts "\n\n"
		puts "  |-------------------------------|"
		puts "8 | #{pp(@board[:a8])} | #{pp(@board[:b8])} | #{pp(@board[:c8])} | #{pp(@board[:d8])} | #{pp(@board[:e8])} | #{pp(@board[:f8])} | #{pp(@board[:g8])} | #{pp(@board[:h8])} |"
		puts "  |---|---|---|---|---|---|---|---|"
		puts "7 | #{pp(@board[:a7])} | #{pp(@board[:b7])} | #{pp(@board[:c7])} | #{pp(@board[:d7])} | #{pp(@board[:e7])} | #{pp(@board[:f7])} | #{pp(@board[:g7])} | #{pp(@board[:h7])} |"
		puts "  |---|---|---|---|---|---|---|---|"
		puts "6 | #{pp(@board[:a6])} | #{pp(@board[:b6])} | #{pp(@board[:c6])} | #{pp(@board[:d6])} | #{pp(@board[:e6])} | #{pp(@board[:f6])} | #{pp(@board[:g6])} | #{pp(@board[:h6])} |"
		puts "  |---|---|---|---|---|---|---|---|"
		puts "5 | #{pp(@board[:a5])} | #{pp(@board[:b5])} | #{pp(@board[:c5])} | #{pp(@board[:d5])} | #{pp(@board[:e5])} | #{pp(@board[:f5])} | #{pp(@board[:g5])} | #{pp(@board[:h5])} |"
		puts "  |---|---|---|---|---|---|---|---|"
		puts "4 | #{pp(@board[:a4])} | #{pp(@board[:b4])} | #{pp(@board[:c4])} | #{pp(@board[:d4])} | #{pp(@board[:e4])} | #{pp(@board[:f4])} | #{pp(@board[:g4])} | #{pp(@board[:h4])} |"
		puts "  |---|---|---|---|---|---|---|---|"
		puts "3 | #{pp(@board[:a3])} | #{pp(@board[:b3])} | #{pp(@board[:c3])} | #{pp(@board[:d3])} | #{pp(@board[:e3])} | #{pp(@board[:f3])} | #{pp(@board[:g3])} | #{pp(@board[:h3])} |"
		puts "  |---|---|---|---|---|---|---|---|"
		puts "2 | #{pp(@board[:a2])} | #{pp(@board[:b2])} | #{pp(@board[:c2])} | #{pp(@board[:d2])} | #{pp(@board[:e2])} | #{pp(@board[:f2])} | #{pp(@board[:g2])} | #{pp(@board[:h2])} |"
		puts "  |---|---|---|---|---|---|---|---|"
		puts "1 | #{pp(@board[:a1])} | #{pp(@board[:b1])} | #{pp(@board[:c1])} | #{pp(@board[:d1])} | #{pp(@board[:e1])} | #{pp(@board[:f1])} | #{pp(@board[:g1])} | #{pp(@board[:h1])} |"
		puts "  |-------------------------------|"
		puts "    a   b   c   d   e   f   g   h "
		puts "\n\n"
	end

end

class Vacant
	attr_reader :position, :unicode
	def initialize(position)
		@position = position
		@unicode = " "
	end
end

class Pawn
	attr_reader :color, :position, :moves, :unicode, :captured
	attr_writer :position, :moves, :captured
	def initialize(color, position)
		@color = color
		@position = position
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2659".encode('utf-8') : "\u265f".encode('utf-8')
	end
end

class Rook
	attr_reader :color, :position, :moves, :unicode, :captured
	attr_writer :position, :moves, :captured
	def initialize(color, position)
		@color = color
		@position = position
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2656".encode('utf-8') : "\u265c".encode('utf-8')
	end
end

class Bishop
	attr_reader :color, :position, :moves, :unicode, :captured
	attr_writer :position, :moves, :captured
	def initialize(color, position)
		@color = color
		@position = position
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2657".encode('utf-8') : "\u265d".encode('utf-8')
	end	
end

class Knight
	attr_reader :color, :position, :moves, :unicode, :captured
	attr_writer :position, :moves, :captured
	def initialize(color, position)
		@color = color
		@position = position
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2658".encode('utf-8') : "\u265e".encode('utf-8')
	end	
end

class King
	attr_reader :color, :position, :moves, :unicode, :captured
	attr_writer :position, :moves, :captured
	def initialize(color, position)
		@color = color
		@position = position
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2654".encode('utf-8') : "\u265a".encode('utf-8')
	end	
end

class Queen
	attr_reader :color, :position, :moves, :unicode, :captured
	attr_writer :position, :moves, :captured
	def initialize(color, position)
		@color = color
		@position = position
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2655".encode('utf-8') : "\u265b".encode('utf-8')
	end	
end

