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
	attr_reader :id, :color, :moves, :unicode, :captured, :rank, :file
	attr_writer :moves, :captured, :rank, :file
	def initialize(color:, rank:, file:)
		@color = color
        @rank = rank
        @file = file
		@id = "#{color}#{self.class}#{rank}#{file}"
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2659".encode('utf-8') : "\u265f".encode('utf-8')
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
	attr_reader :id, :color, :moves, :unicode, :captured, :rank, :file
	attr_writer :moves, :captured, :rank, :file
	def initialize(color:, rank:, file:)
		@color = color
        @rank = rank
        @file = file
		@id = "#{color}#{self.class}#{rank}#{file}"
		@moves = 0
		@captured = false
		@unicode = color == :w ? "\u2654".encode('utf-8') : "\u265a".encode('utf-8')
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