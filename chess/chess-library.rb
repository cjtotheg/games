class Board
	def initialize
		@@board = {
			a1: :wR,
			a2: :wP,
			a3: :o,
			a4: :o,
			a5: :o,
			a6: :o,
			a7: :bP, 
			a8: :bR,
			b1: :wN,
			b2: :wP,
			b3: :o,
			b4: :o,
			b5: :o,
			b6: :o,
			b7: :bP,
			b8: :bN,
			c1: :bB,
			c2: :bP,
			c3: :o,
			c4: :o,
			c5: :o,
			c6: :o,
			c7: :bP,
			c8: :bB,
			d1: :wQ,
			d2: :wP,
			d3: :o,
			d4: :o,
			d5: :o,
			d6: :o,
			d7: :bP,
			d8: :bQ,
			e1: :wK,
			e2: :wP,
			e3: :o,
			e4: :o,
			e5: :o,
			e6: :o,
			e7: :bP,
			e8: :bK,
			f1: :wB,
			f2: :wP,
			f3: :o,
			f4: :o,
			f5: :o,
			f6: :o,
			f7: :bP,
			f8: :bB,
			g1: :wN,
			g2: :wP,
			g3: :o,
			g4: :o,
			g5: :o,
			g6: :o,
			g7: :bP,
			g8: :bN,
			h1: :wR,
			h2: :wP,
			h3: :o,
			h4: :o,
			h5: :o,
			h6: :o,
			h7: :bP,
			h8: :bR
		}

	end

	def pp(pos)
		pos == :o ? "  " : pos
	end

	def print
		puts "\n\n"
		puts "  | a  | b  | c  | d  | e  | f  | g  | h  |"
		puts "----------------------------------------------"
		puts "8 | #{pp(@@board[:a8])} | #{pp(@@board[:b8])} | #{pp(@@board[:c8])} | #{pp(@@board[:d8])} | #{pp(@@board[:e8])} | #{pp(@@board[:f8])} | #{pp(@@board[:g8])} | #{pp(@@board[:h8])} | 8"
		puts "----------------------------------------------"
		puts "7 | #{pp(@@board[:a7])} | #{pp(@@board[:b7])} | #{pp(@@board[:c7])} | #{pp(@@board[:d7])} | #{pp(@@board[:e7])} | #{pp(@@board[:f7])} | #{pp(@@board[:g7])} | #{pp(@@board[:h7])} | 7"
		puts "----------------------------------------------"
		puts "6 | #{pp(@@board[:a6])} | #{pp(@@board[:b6])} | #{pp(@@board[:c6])} | #{pp(@@board[:d6])} | #{pp(@@board[:e6])} | #{pp(@@board[:f6])} | #{pp(@@board[:g6])} | #{pp(@@board[:h6])} | 6"
		puts "----------------------------------------------"
		puts "5 | #{pp(@@board[:a5])} | #{pp(@@board[:b5])} | #{pp(@@board[:c5])} | #{pp(@@board[:d5])} | #{pp(@@board[:e5])} | #{pp(@@board[:f5])} | #{pp(@@board[:g5])} | #{pp(@@board[:h5])} | 5"
		puts "----------------------------------------------"
		puts "4 | #{pp(@@board[:a4])} | #{pp(@@board[:b4])} | #{pp(@@board[:c4])} | #{pp(@@board[:d4])} | #{pp(@@board[:e4])} | #{pp(@@board[:f4])} | #{pp(@@board[:g4])} | #{pp(@@board[:h4])} | 4"
		puts "----------------------------------------------"
		puts "3 | #{pp(@@board[:a3])} | #{pp(@@board[:b3])} | #{pp(@@board[:c3])} | #{pp(@@board[:d3])} | #{pp(@@board[:e3])} | #{pp(@@board[:f3])} | #{pp(@@board[:g3])} | #{pp(@@board[:h3])} | 3"
		puts "----------------------------------------------"
		puts "2 | #{pp(@@board[:a2])} | #{pp(@@board[:b2])} | #{pp(@@board[:c2])} | #{pp(@@board[:d2])} | #{pp(@@board[:e2])} | #{pp(@@board[:f2])} | #{pp(@@board[:g2])} | #{pp(@@board[:h2])} | 2"
		puts "----------------------------------------------"
		puts "1 | #{pp(@@board[:a1])} | #{pp(@@board[:b1])} | #{pp(@@board[:c1])} | #{pp(@@board[:d1])} | #{pp(@@board[:e1])} | #{pp(@@board[:f1])} | #{pp(@@board[:g1])} | #{pp(@@board[:h1])} | 1"
		puts "----------------------------------------------"
		puts "  | a  | b  | c  | d  | e  | f  | g  | h  |"
		puts "\n\n"
	end
end

class Pawn
end

class Rook
end

class Bishop
end

class Knight
end

class King
end

class Queen
end

