module Chess

  class Game

    attr_reader :board, :pieces

    def initialize
      @next_move = 'w'
      @board = Board.new
      @pieces = Pieces.new 
      @pgn_moves = []
      @user_error_messages = []
    end

    def white_move(pgn_move)
      raise "Error. It is white's move." if @next_move != 'w'
      return move_wrapper(pgn_move: pgn_move, color: 'w')
    end

    def black_move(pgn_move)
      raise "Error. It's black's move." if @next_move != 'b'
      return move_wrapper(pgn_move: pgn_move, color: 'b')
    end

    def move_wrapper(pgn_move:, color:)
      valid_move_report = valid_move?(pgn_move: pgn_move, color: color)
      p valid_move_report
      if valid_move_report[:valid]
        move = do_move(pgn_move: pgn_move, color: color)
        
        #increase the move_count for to_square_occupant
        @pieces[move[:to_square_occupant]][:move_count] += 1
       
        #set the color and @next_move
        @next_move = move[:color] == 'w' ? 'b' : 'w'

        if move[:captured_piece] != nil
          @pieces[move[:captured_piece]][:captured] = true
        end

        #pawn promotion
        if move[:to_square_occupant].match(/P/) &&
            move[:to_square].match(/8/) || move[:to_square].match(/1/)

          #have to remove pawn from pieces
          @board[:pieces].delete(move[:to_square_occupant]) #pawn vanishes!

          move[:to_square_occupant] = get_promoted(letter: "Q", color: move[:color])
          create_piece(piece_id: move[:to_square_occupant])

        end

        return true
      else
        puts "Invalid move:"
        valid_move_report[:errors].each do |error|
          puts error
        end
        return false
      end    
    end

    def valid_move?(pgn_move:, color:)
      
      #all of the following have to pass (virtually)
      #pre_move
      #make_move
      #post_move

      trial_board = Board.new(@board.squares)

      trial_pieces = Pieces.new(@pieces.data)

      move = pre_move(pgn_move: pgn_move, color: color, board: trial_board, pieces: trial_pieces)
      make_move(move: move, pieces: trial_pieces, board: trial_board)
      post_move_report = post_move(move: move, pieces: trial_pieces, board: trial_board)

      if VERBOSE
        puts "----"
        puts "valid_move?(pgn_move: #{pgn_move}, color: '#{color}') Post move report:"
        p post_move_report
        puts "----"
      end

      return post_move_report

    end

    def do_move(pgn_move:, color:)

      move = pre_move(pgn_move: pgn_move, color: color, board: @board, pieces: @pieces)
      make_move(move: move, pieces: @pieces, board: @board)
      post_move_report = post_move(move: move, pieces: @pieces, board: @board)

      if VERBOSE
        puts "----"
        puts "do_move(pgn_move: #{pgn_move}, color: '#{color}') Post move report:"
        p post_move_report
        puts "----"
      end

      return post_move_report

    end

    def pre_move(pgn_move:, color:, board:, pieces:)
      PGNMove.interpret(color: color, pgn_move: pgn_move, board: board, pieces: pieces)
    end

    def make_move(move:, pieces:, board:)
      #give it the real board and pieces, or a trial board and pieces
      #updates board and pieces objects based on move hash
      board.update_board(move: move, board: board, pieces: pieces)
    end

    def post_move(move:, pieces:, board:)
      #give is the real board and pieces, or a trial board and pieces
      #returns post move report hash - this will be the final report of whether
      #move is valid, and what happened, (check, en passant, check mate)
      pmr = PostMove.new(move: move, pieces: pieces, board: board)
      pmr.report
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
      @board[:pgn].push(pgn_move)
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

end
