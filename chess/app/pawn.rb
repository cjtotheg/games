require_relative 'chess.rb'

class Pawn < Game

  attr_reader :id, :color, :moves

  def initialize(id:, color:)
    @id = id
    @color = color
    @moves = 0
  end

  def move(board:, pgn_move:, color:)

    move = {
      piece_id: nil,
      from: nil,
      to: nil,
      error: nil
    }

    take = false
    if pgn_move.match(/x/)
      take = true
    end

    ##### WHICH PAWN?????
    pgn_a = pgn_move.chars
    pawns = []
    board.each do |key, val|
      if pgn_a[0] == key.chars[0] && val.class == Pawn && val.color == color
        pawns.push key
      end
    end

    if pawns.length == 0
      move[:error] = "Invalid pawn move."
      return move
    end

    if pawns.length > 1
      raise "more than one pawn on file. not handled yet."
    end

    if pawns.length == 1
      move[:piece_id] = board[pawns[0]].id
      move[:from] = pawns[0]
      move[:to] = pgn_move
    end

    return move

  end

end
