class Vacant
	attr_reader :color, :unicode, :rank, :file
	def initialize(rank:, file:)
		@rank = rank
        @file = file
		@color = :none
		@unicode = " "
	end
end

### Pieces have capable moves and valid moves. The class will boolean if capable. Validity has to be compared by what's happened on the board.

class Pawn
	attr_reader :id, :color, :moves, :unicode, :captured, :rank, :file, :valid_moves
	attr_writer :moves, :captured, :rank, :file
	def initialize(color:, rank:, file:)
		@color = color
        @rank = rank
        @file = file
		@id = "#{color}#{self.class}#{rank}#{file}"
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2659".encode('utf-8') : "\u265f".encode('utf-8')

		if color == :w
			@valid_moves = {
				a2: [:a3, :b3],
				a3: [:a4, :b4],
				a4: [:a5, :b5],
				a5: [:a6, :b6],
				a6: [:a7, :b7],
				a7: [:a8, :b8], 
				b2: [:a3, :b3, :c3],
				b3: [:a4, :b4, :c4],
				b4: [:a5, :b5, :c5],
				b5: [:a6, :b6, :c6],
				b6: [:a7, :b7, :c7],
				b7: [:a8, :b8, :c8],
				c2: [:b3, :c3, :d3],
				c3: [:b4, :c4, :d4],
				c4: [:b5, :c5, :d5],
				c5: [:b6, :c6, :d6],
				c6: [:b7, :c7, :d7],
				c7: [:b8, :c8, :d8],
				d2: [:c3, :d3, :e3],
				d3: [:c4, :d4, :e4],
				d4: [:c5, :d5, :e5],
				d5: [:c6, :d6, :e6],
				d6: [:c7, :d7, :e7],
				d7: [:c8, :d8, :e8],
				e2: [:d3, :e3, :f3],
				e3: [:d4, :e4, :f4],
				e4: [:d5, :e5, :f5],
				e5: [:d6, :e6, :f6],
				e6: [:d7, :e7, :f7],
				e7: [:d8, :e8, :f8],
				f2: [:e3, :f3, :g3],
				f3: [:e4, :f4, :g4],
				f4: [:e5, :f5, :g5],
				f5: [:e6, :f6, :g6],
				f6: [:e7, :f7, :g7],
				f7: [:e8, :f8, :g8],
				g2: [:f3, :g3, :h3],
				g3: [:f4, :g4, :h4],
				g4: [:f5, :g5, :h5],
				g5: [:f6, :g6, :h6],
				g6: [:f7, :g7, :h7],
				g7: [:f8, :g8, :h8],
				h2: [:h3, :g3],
				h3: [:h4, :g4],
				h4: [:h5, :g5],
				h5: [:h6, :g6],
				h6: [:h7, :g7],
				h7: [:h8, :g8]
			}
		end

		if color == :b
			@valid_moves = {
				a2: [:a1, :b1],
				a3: [:a2, :b2],
				a4: [:a3, :b3],
				a5: [:a4, :b4],
				a6: [:a5, :b5],
				a7: [:a6, :b6], 
				b2: [:a1, :b1, :c1],
				b3: [:a2, :b2, :c2],
				b4: [:a3, :b3, :c3],
				b5: [:a4, :b4, :c4],
				b6: [:a5, :b5, :c5],
				b7: [:a6, :b6, :c6],
				c2: [:b1, :c1, :d1],
				c3: [:b2, :c2, :d2],
				c4: [:b3, :c3, :d3],
				c5: [:b4, :c4, :d4],
				c6: [:b5, :c5, :d5],
				c7: [:b6, :c6, :d6],
				d2: [:c1, :d1, :e1],
				d3: [:c2, :d2, :e2],
				d4: [:c3, :d3, :e3],
				d5: [:c4, :d4, :e4],
				d6: [:c5, :d5, :e5],
				d7: [:c6, :d6, :e6],
				e2: [:d1, :e1, :f1],
				e3: [:d2, :e2, :f2],
				e4: [:d3, :e3, :f3],
				e5: [:d4, :e4, :f4],
				e6: [:d5, :e5, :f5],
				e7: [:d6, :e6, :f6],
				f2: [:e1, :f1, :g1],
				f3: [:e2, :f2, :g2],
				f4: [:e3, :f3, :g3],
				f5: [:e4, :f4, :g6],
				f6: [:e5, :f5, :g7],
				f7: [:e6, :f6, :g8],
				g2: [:f1, :g1, :h1],
				g3: [:f2, :g2, :h2],
				g4: [:f3, :g3, :h3],
				g5: [:f4, :g4, :h4],
				g6: [:f5, :g5, :h5],
				g7: [:f6, :g6, :h6],
				h2: [:h1, :g1],
				h3: [:h2, :g2],
				h4: [:h3, :g3],
				h5: [:h4, :g4],
				h6: [:h5, :g5],
				h7: [:h6, :g6]
			}
		end


	end
end

class Rook
	attr_reader :id, :color, :moves, :unicode, :captured, :rank, :file
	attr_writer :moves, :captured, :rank, :file
	def initialize(color:, rank:, file:)
		@color = color
        @rank = rank
        @file = file        
		@id = "#{color}#{self.class}#{rank}#{file}"
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2656".encode('utf-8') : "\u265c".encode('utf-8')
	end
end

class Bishop
	attr_reader :id, :color, :moves, :unicode, :captured, :rank, :file
	attr_writer :moves, :captured, :rank, :file
	def initialize(color:, rank:, file:)
		@color = color
        @rank = rank
        @file = file
		@id = "#{color}#{self.class}#{rank}#{file}"
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2657".encode('utf-8') : "\u265d".encode('utf-8')
	end	
end

class Knight
	attr_reader :id, :color, :moves, :unicode, :captured, :rank, :file
	attr_writer :moves, :captured, :rank, :file
	def initialize(color:, rank:, file:)
		@color = color
        @rank = rank
        @file = file
		@id = "#{color}#{self.class}#{rank}#{file}"
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2658".encode('utf-8') : "\u265e".encode('utf-8')
	end	
end

class King
	attr_reader :id, :color, :moves, :unicode, :captured, :rank, :file, :valid_moves
	attr_writer :moves, :captured, :rank, :file
	def initialize(color:, rank:, file:)
		@color = color
        @rank = rank
        @file = file
		@id = "#{color}#{self.class}#{rank}#{file}"
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2654".encode('utf-8') : "\u265a".encode('utf-8')

		@valid_moves = {
			a1: [:a2, :b2, :b1],
			a2: [:a3, :b3, :b2, :b1, :a1],
			a3: [:a4, :b4, :b3, :b2, :a2],
			a4: [:a5, :b5, :b4, :b3, :a3],
			a5: [:a6, :b6, :b5, :b4, :a4],
			a6: [:a7, :b7, :b6, :b5, :a5],
			a7: [:a8, :b8, :b7, :b6, :a6], 
			a8: [:b8, :b7, :a7],
			b1: [:b2, :c2, :c1, :a1],
			b2: [:b3, :c3, :c2, :c1, :b1, :a1, :a2, :a3],
			b3: [:b4, :c4, :c3, :c2, :b2, :a2, :a3, :a4],
			b4: [:b5, :c5, :c4, :c3, :b3, :a3, :a4, :a5],
			b5: [:b6, :c6, :c5, :c4, :b4, :a4, :a4, :a6],
			b6: [:b7, :c7, :c6, :c5, :b5, :a5, :a5, :a7],
			b7: [:b8, :c8, :c7, :c6, :b6, :a6, :a6, :a8],
			b8: [:c8, :c7, :b7, :a7, :a8],
			c1: [:c2, :d2, :d1, :b1, :b2],
			c2: [:c3, :d3, :d3, :d1, :c1, :b1, :b2, :b3],
			c3: [:c4, :d4, :d4, :d2, :c2, :b2, :b3, :b4],
			c4: [:c5, :d5, :d5, :d3, :c3, :b3, :b4, :b5],
			c5: [:c6, :d6, :d6, :d4, :c4, :b4, :b5, :b6],
			c6: [:c7, :d7, :d7, :d5, :c5, :b5, :b6, :b7],
			c7: [:c8, :d8, :d8, :d6, :c6, :b6, :b7, :b8],
			c8: [:d8, :d7, :c7, :b7, :b8],
			d1: [:d2, :e2, :e1, :c1, :c2],
			d2: [:d3, :e3, :e2, :e1, :d1, :c1, :c2, :c3],
			d3: [:d4, :e4, :e3, :e2, :d2, :c2, :c3, :c4],
			d4: [:d5, :e5, :e4, :e3, :d3, :c3, :c4, :c5],
			d5: [:d6, :e6, :e5, :e4, :d4, :c4, :c5, :c6],
			d6: [:d7, :e7, :e6, :e5, :d5, :c5, :c6, :c7],
			d7: [:d8, :e8, :e7, :e6, :d6, :c6, :c7, :c8],
			d8: [:e8, :e7, :d7, :c7, :c8],
			e1: [:e2, :f2, :f1, :d1, :d2],
			e2: [:e3, :f3, :f2, :f1, :e1, :d1, :d2, :d3],
			e3: [:e4, :f4, :f3, :f2, :e2, :d2, :d3, :d4],
			e4: [:e5, :f5, :f4, :f3, :e3, :d3, :d4, :d5],
			e5: [:e6, :f6, :f5, :f4, :e4, :d4, :d5, :d6],
			e6: [:e7, :f7, :f6, :f5, :e5, :d5, :d6, :d7],
			e7: [:e8, :f8, :f7, :f6, :e6, :d6, :d7, :d8],
			e8: [:f8, :f7, :e7, :d7, :d8],
			f1: [:f2, :g2, :g1, :e1, :e2],
			f2: [:f3, :g3, :g2, :g1, :f1, :e1, :e2, :e3],
			f3: [:f4, :g4, :g3, :g2, :f2, :e2, :e3, :e4],
			f4: [:f5, :g5, :g4, :g3, :f3, :e3, :e4, :e5],
			f5: [:f6, :g6, :g5, :g4, :f4, :e4, :e5, :e6],
			f6: [:f7, :g7, :g6, :g5, :f5, :e5, :e6, :e7],
			f7: [:f8, :g8, :g7, :g6, :f6, :e6, :e7, :e8],
			f8: [:g8, :g7, :f7, :e7, :e8],
			g1: [:g2, :h2, :h1, :f1, :f2],
			g2: [:g3, :h3, :h2, :h1, :g1, :f1, :f2, :f3],
			g3: [:g5, :h4, :h3, :h2, :g2, :f2, :f3, :f4],
			g4: [:g6, :h5, :h4, :h3, :g3, :f3, :f4, :f5],
			g5: [:g7, :h6, :h5, :h4, :g4, :f4, :f5, :f6],
			g6: [:g8, :h7, :h6, :h5, :g5, :f5, :f6, :f7],
			g7: [:g9, :h8, :h7, :h6, :g6, :f6, :f7, :f8],
			g8: [:h8, :h7, :g7, :f7, :f8],
			h1: [:h2, :g1, :g2],
			h2: [:h3, :h1, :g1, :g2, :g3],
			h3: [:h4, :h2, :g2, :g3, :g4],
			h4: [:h5, :h3, :g3, :g4, :g5],
			h5: [:h6, :h4, :g4, :g5, :g6],
			h6: [:h7, :h5, :g5, :g6, :g7],
			h7: [:h8, :h6, :g6, :g7, :g8],
			h8: [:h7, :g7, :g8]
		}

	end	
end

class Queen
	attr_reader :id, :color, :moves, :unicode, :captured, :rank, :file
	attr_writer :moves, :captured, :rank, :file
	def initialize(color:, rank:, file:)
		@color = color
        @rank = rank
        @file = file
		@id = "#{color}#{self.class}#{rank}#{file}"
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2655".encode('utf-8') : "\u265b".encode('utf-8')
	end	
end