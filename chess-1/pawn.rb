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

    def move(color:, pgn_move:)

		######
		## make sure move is valid
		## update the board with valid move
		## return true if move completed
		######

		m = pgn_move.chars
		
		#which pawn?
		@@board.each do |key, val|
			if val.class == Pawn && val.color == color && val.file == m[0]
				pawn = val
				puts "#{pawn.inspect}"

				#take
				if pgn_move.match?(/x/)
					puts "take"
					puts "Pawn #{m[0]} takes #{m[2]}#{m[3]}"

					#is the take square adjacent?
					take_diagonals = {
						"a" => ["b"],
						"b" => ["a", "c"],
						"c" => ["b", "d"],
						"d" => ["c", "e"],
						"e" => ["d", "f"],
						"f" => ["e", "g"],
						"g" => ["f", "h"],
						"h" => ["g"]
					}

					valid = false
					take_diagonals.each do |key, val|
						if key == m[0]
							val.each do |f|
								if f == m[2]
									valid = true
								end
							end
						end
					end
					next if !valid

					#is pawn one rank lower (w) or higher (b) than take position?
					if pawn.color == :w && pawn.rank > m[3].to_i || pawn.color == :b && pawn.rank < m[3].to_i
						#puts "Invalid pawn move. Must take forward and diagonally."
						next
					end

					#is there a piece on the take square?
					if @@board["#{m[2]}#{m[3]}".to_sym].class == Vacant
						#puts "Invalid pawn move. #{m[2]}#{m[3]} is vacant."
						next
					end	

					#is the piece being taken of the enemy?
					if @@board["#{m[2]}#{m[3]}".to_sym].color == pawn.color
						#puts "Invalid pawn move. #{m[2]}#{m[3]} is not an enemy piece."
						next
					end	

					#is take a promotion?	
					if m[3].to_i == 1 || m[3].to_i == 8 #promotion
						puts "Pawn promoted to Queen!"
						@@board["#{pawn.file}#{pawn.rank}".to_sym] = Vacant.new(file: pawn.file, rank: pawn.rank)
						@@board["#{m[2]}#{m[3]}".to_sym] = Queen.new(color: color, file: "#{m[2]}", rank: "#{m[3]}".to_i)
						return true
					else #regular take move
						@@board["#{pawn.file}#{pawn.rank}".to_sym] = Vacant.new(file: pawn.file, rank: pawn.rank)
						@@board["#{m[2]}#{m[3]}".to_sym] = pawn
						pawn.rank = m[3].to_i
						pawn.file = m[2]
						pawn.moves += 1
						return true
					end

				end

				#forward move
				if pgn_move.length == 2

					#make sure pawn is moving forward
					if pawn.color == :w && m[1].to_i <= pawn.rank  || pawn.color == :b && pawn.rank <= m[1].to_i
						#puts "Invalid pawn move. Pawns go forward only!"
						next
					end

					#must be able to move 1 or 2 positions higher
					spaces = pawn.color == :w ? m[1].to_i - pawn.rank : pawn.rank - m[1].to_i

					if spaces == 2 && pawn.moves == 0

						#make sure it's not skipping over a piece
						if color == :w && @@board["#{pawn.file}#{pawn.rank + 1}".to_sym].class != Vacant
							#puts "Invalid pawn move. Cannot move through a piece."
							next
						end
						if color == :b && @@board["#{pawn.file}#{pawn.rank - 1}".to_sym].class != Vacant
							#puts "Invalid pawn move. Cannot move through a piece."
							next
						end

					end
					
					if spaces > 2
						#puts "Invalid pawn move. Too many spaces."
						next
					end

					if @@board[pgn_move.to_sym].class != Vacant
						#puts "Invalid pawn move. A #{@@board[pgn_move.to_sym].class} is already there."
						next
					end

					#promotion
					if m[1].to_i == 1 || m[1].to_i == 8
						puts "Pawn promoted to Queen!"
						@@board["#{pawn.file}#{pawn.rank}".to_sym] = Vacant.new(file: pawn.file, rank: pawn.rank)
						@@board[pgn_move.to_sym] = Queen.new(color: color, file: "#{m[1]}", rank: "#{m[0]}".to_i)
						return true
					end

					#en passant?
					if pawn.rank == 7 && pawn.color == :b && spaces == 2 || pawn.rank == 2 && pawn.color == :w && spaces == 2 

						#is the adjacent square occupied by an enemy pawn?
						take_files = {
							"a" => ["b"],
							"b" => ["a", "c"],
							"c" => ["b", "d"],
							"d" => ["c", "e"],
							"e" => ["d", "f"],
							"f" => ["e", "g"],
							"g" => ["f", "h"],
							"h" => ["g"]
						}

						take_files.each do |key, val|
							if key == m[0]
								val.each do |f|
									if pawn.color == :w && @@board["#{f}3".to_sym].class == Pawn && @@board["#{f}3".to_sym].color == :b
										puts "En passant!"
										@@board["#{f}3".to_sym] = Vacant.new(file: f, rank: 3)
									end
									if pawn.color == :b && @@board["#{f}6".to_sym].class == Pawn && @@board["#{f}6".to_sym].color == :w
										puts "En passant!"
										@@board["#{f}6".to_sym] = Vacant.new(file: f, rank: 6)
									end
								end
							end
						end
					end

					#make the move
					@@board["#{pawn.file}#{pawn.rank}".to_sym] = Vacant.new(file: pawn.file, rank: pawn.rank)
					@@board[pgn_move.to_sym] = pawn
					pawn.rank = m[1].to_i
					pawn.file = m[0]
					pawn.moves += 1
					return true

				end
			
			end
		
		end

		#we should have returned true by now.
		puts "Invalid pawn move."
		return false

	end

end