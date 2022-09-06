

class PawnMove < Game
    def initialize
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