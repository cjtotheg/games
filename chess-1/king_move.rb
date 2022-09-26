
class KingMove < Game
    def initialize
    end

    def move(color:, pgn_move:)
		######
		## make sure move is valid
		## update the board with valid move
		## return true if move completed
		######

		m = pgn_move.chars
		king = nil
		@@board.each do |key, val| #find the king
			if val.class == King && val.color == color
				king = val
			end
		end

        king.valid_moves.each do |key, val| #is move valid?
            if key == "#{king.file}#{king.rank}".to_sym
                val.each do |p|

                    #move to vacant space
                    if p == "#{m[1]}#{m[2]}".to_sym 
                        
                        #cannot move into check
                        attacking_color = king.color == :w ? :b : :w
                        @@attacks[p][attacking_color].each do |a|
                            if a == p
                                puts "Cannot move king into check."
                                return false
                            end
                        end

                        do_move = false

                        #capture
                        if @@board[p].class != Vacant && @@board[p].color != king.color
                            @@captured.push @@board[p]
                            do_move = true
                        end

                        #regular move
                        if @@board[p].class == Vacant
                            do_move = true
                        end

                        if do_move
                            @@board["#{king.file}#{king.rank}".to_sym] = Vacant.new(file: king.file, rank: king.rank)
                            king.moves += 1
                            king.rank = @@board[p].rank
                            king.file = @@board[p].file
                            @@board[p] = king
                            return true
                        end
                    end
                end
            end
        end

        puts "King cannot do that move."
        return false

	end

end