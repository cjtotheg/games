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
			b7: :wP,
			b8: :wN,
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

	def print
		puts @@board
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

