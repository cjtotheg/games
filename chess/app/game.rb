#module Chess

  class Game

    attr_reader :board, :pieces, :pgn_moves, :next_move, :user_error_messages

    def initialize
      LOG.info "*************** === Game.new"
      @next_move = 'w'
      @board = Board.new
      @pieces = Pieces.new 
      @pieces.update(@board)
      @pgn_moves = []
      @user_error_messages = []

    end

    def white_move(pgn_move)
      LOG.info "white moves #{pgn_move}"
      raise "Error. It is white's move." if @next_move != 'w'
      return mover(pgn_move: pgn_move, color: 'w')
    end

    def black_move(pgn_move)
      LOG.info "black moves #{pgn_move}"
      raise "Error. It's black's move." if @next_move != 'b'
      return mover(pgn_move: pgn_move, color: 'b')
    end

    def mover(pgn_move:, color:)

      LOG.debug "=== Game.mover(pgn_move: #{pgn_move}, color: #{color})"     

      move = PgnMove.interpret(color: color, pgn_move: pgn_move, board: @board, pieces: @pieces)
      status = StatusReport.report(move: move, pieces: pieces, board: board)

      #@board.print_board
      #@pieces.print_piece_data #for deep debugging

      #check move, if invalid, return false
      if move[:valid] == false
      
        @user_error_messages.push move[:error]
        LOG.error "move[:error]: #{move[:error]}"
      
      else

        #save the current board state & pieces state for rollback later
        @board.save_state
        @pieces.save_state

        #if take, set piece as captured
        if move[:captured_piece] != nil
          LOG.debug "captured piece: #{move[:captured_piece]}"
          @pieces.data[move[:captured_piece]][:captured] = true
        end

        #do the move
        @board.update_board(move: move, board: @board, pieces: @pieces)
        @pieces.update(@board)

        #check to see if the move is still valid (like check was not cleared)
        status = StatusReport.report(move: move, pieces: pieces, board: board)
        if move[:color] == 'b' && status[:b_check] == true || move[:color] == 'w' && status[:w_check] == true
          move[:valid] = false
          move[:error] = "King is in check. This move does not clear the check."
          @user_error_messages.push move[:error]
          LOG.error "move[:error]: #{move[:error]}"

          #rollback the move
          @board.restore_state
          @pieces.restore_state

          return false
        end

        #increase the move_count for to_square_occupant
        @pieces.data[move[:to_square_occupant]][:move_count] += 1
       
        #set the color and @next_move
        @next_move = move[:color] == 'w' ? 'b' : 'w'

        ####################################################
        ### post move actions
        ####################################################

        Pawn.update_en_passant(move: move, pieces: @pieces, board: @board)

        #pawn promotion
        if move[:to_square_occupant].match(/P/) &&
            move[:to_square].match(/8/) || move[:to_square].match(/1/)

          #have to remove pawn from pieces
          @pieces.data.delete(move[:to_square_occupant]) #pawn vanishes!

          move[:to_square_occupant] = get_promoted(letter: "Q", color: move[:color])
          create_piece(piece_id: move[:to_square_occupant])
        end

        @board.print_board
        @pieces.print_piece_data #for deep debugging

      end

      return move[:valid]



      # valid_move_report = valid_move?(pgn_move: pgn_move, color: color)
      # if valid_move_report[:valid]
      #   move = do_move(pgn_move: pgn_move, color: color, board: @board, pieces: @pieces)
        
      #   LOG.debug "===========AFTER do_move==============="
      #   move.each do |k,v|
      #     LOG.debug "#{k}: #{v}"
      #   end
      #   LOG.debug "======================================="
    

      #   #increase the move_count for to_square_occupant
      #   @pieces.data[move[:to_square_occupant]][:move_count] += 1
       
      #   #set the color and @next_move
      #   @next_move = move[:color] == 'w' ? 'b' : 'w'

      #   if move[:captured_piece] != nil
      #     @pieces[move[:captured_piece]][:captured] = true
      #   end

      #   #pawn promotion
      #   if move[:to_square_occupant].match(/P/) &&
      #       move[:to_square].match(/8/) || move[:to_square].match(/1/)

      #     #have to remove pawn from pieces
      #     @board[:pieces].delete(move[:to_square_occupant]) #pawn vanishes!

      #     move[:to_square_occupant] = get_promoted(letter: "Q", color: move[:color])
      #     create_piece(piece_id: move[:to_square_occupant])

      #   end

      #   return true
      # else
      #   LOG.error "Invalid move:"
      #   valid_move_report[:errors].each do |error|
      #     LOG.error error
      #   end
      #   return false
      # end    

      
    end

    def DELETEvalid_move?(pgn_move:, color:)
      
      #all of the following have to pass (virtually)
      #pre_move
      #make_move
      #post_move

      LOG.debug "=== Game.valid_move?(pgn_move: #{pgn_move}, color: #{color}"

      LOG.warn "THIS DUPLICATION IS A PROBLEM"
      cloned_board = @board.clone.map(&:clone) #@board.dup
      cloned_pieces = @pieces.clone.map(&:clone) #@pieces.dup

      LOG.debug "- BEFORE -"
      LOG.debug "@board.squares[:e2] = #{@board.squares[:e2]}"
      LOG.debug "@board.squares[:e4] = #{@board.squares[:e4]}"
      LOG.debug "cloned_board.squares[:e2] = #{cloned_board.squares[:e2]}"
      LOG.debug "cloned_board.squares[:e4] = #{cloned_board.squares[:e4]}"      

      move = pre_move(pgn_move: pgn_move, color: color, board: cloned_board, pieces: cloned_pieces)

      LOG.debug "- AFTER pre_move -"
      LOG.debug "@board.squares[:e2] = #{@board.squares[:e2]}"
      LOG.debug "@board.squares[:e4] = #{@board.squares[:e4]}"
      LOG.debug "cloned_board.squares[:e2] = #{cloned_board.squares[:e2]}"
      LOG.debug "cloned_board.squares[:e4] = #{cloned_board.squares[:e4]}"

      make_move(move: move, pieces: cloned_pieces, board: cloned_board)

      LOG.debug "- AFTER make_move -"
      LOG.debug "@board.squares[:e2] = #{@board.squares[:e2]}"
      LOG.debug "@board.squares[:e4] = #{@board.squares[:e4]}"
      LOG.debug "cloned_board.squares[:e2] = #{cloned_board.squares[:e2]}"
      LOG.debug "cloned_board.squares[:e4] = #{cloned_board.squares[:e4]}"

      post_move_report = post_move(move: move, pieces: cloned_pieces, board: cloned_board)

      LOG.debug "- AFTER post_move -"
      LOG.debug "@board.squares[:e2] = #{@board.squares[:e2]}"
      LOG.debug "@board.squares[:e4] = #{@board.squares[:e4]}"
      LOG.debug "cloned_board.squares[:e2] = #{cloned_board.squares[:e2]}"
      LOG.debug "cloned_board.squares[:e4] = #{cloned_board.squares[:e4]}"
      LOG.debug "post_move_report: #{post_move_report}"


      return post_move_report

    end

    def DELETEdo_move(pgn_move:, color:, board:, pieces:)

      LOG.debug "============ do_move ========"
      LOG.debug "@board.squares[:e2] = #{@board.squares[:e2]}"
      LOG.debug "@board.squares[:e4] = #{@board.squares[:e4]}"
      LOG.debug "board.squares[:e2] = #{board.squares[:e2]}"
      LOG.debug "board.squares[:e4] = #{board.squares[:e4]}"


      move = PGNMove.interpret(color: color, pgn_move: pgn_move, board: board, pieces: pieces)
      move.each do |k,v|
        LOG.debug "#{k}: #{v}"
      end
      LOG.debug "============================="

      return move

    end

    def DELETEpre_move(pgn_move:, color:, board:, pieces:)
      LOG.debug "=== Game.pre_move(pgn_move: #{pgn_move}, color: #{color}, board: below, pieces: below)"

      pm = PreMove.new(color: color, pgn_move: pgn_move, board: board, pieces: pieces)
      pm.report
    end

    def DELETEmake_move(move:, pieces:, board:)
      #give it the real board and pieces, or a trial board and pieces
      #updates board and pieces objects based on move hash
      LOG.debug "=== Game.make_move(move: below, pieces: below, board: below)"

      board.update_board(move: move, board: board, pieces: pieces)
    end

    def DELETEpost_move(move:, pieces:, board:)
      Pawn.update_en_passant(move: move, pieces: pieces, board: board)
      StatusReport.report(move: move, pieces: pieces, board: board)
    end

    def king_move(pgn_move:, color:)

      move = King::interpret_pgn_move(board: board, pgn_move: pgn_move, color: color)

      if move[:valid] == false
        return false
      end

      if move[:valid] == true

        ## do the move
        update_board(move)

        update_pieces

        return true
      end

      raise "Something went wrong."
    end

    def knight_move(pgn_move:, color:)

      move = Knight::interpret_pgn_move(board: board, pgn_move: pgn_move, color: color)

      if move[:valid] == false
        return false
      end

      if move[:valid] == true

        ## do the move
        update_board(move)
        update_pieces

        return true
      end

      raise "Something went wrong."

    end

    def record_pgn_move(pgn_move:)
      @pgn_moves.push(pgn_move)
    end    

    def get_pgn_moves_string
      pgn_moves_touple = []
      pgn_string = ""
      set = []
      move_count = 0
      @pgn_moves.each_with_index do |move, index|

        move_count += 1

        if move_count % 2 != 0
          set.push move

          if @pgn_moves.count == (index + 1) #one move in last set
            set.push nil
            pgn_moves_touple.push set
          end

        end

        if move_count % 2 == 0
          set.push move
          pgn_moves_touple.push set
          set = []
        end

      end

      pgn_moves_touple.each_with_index do |touple, index|
        pgn_string += "#{index + 1}.#{touple[0]} #{touple[1]} "
      end

      return pgn_string

    end

  end

#end
