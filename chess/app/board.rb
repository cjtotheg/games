

#Board->Move->Game

module Chess
  class Board
   attr_reader :board

    def initialize
      @board = {
        a1: {id: :wR1, m: 0},
        b1: {id: :wN1, m: 0},
        c1: {id: :wB1, m: 0},
        d1: {id: :wQ1, m: 0},
        e1: {id: :wK1, m: 0},
        f1: {id: :wB2, m: 0},
        g1: {id: :wN2, m: 0},
        h1: {id: :wR2, m: 0},
        a2: {id: :wP1, m: 0},
        b2: {id: :wP2, m: 0},
        c2: {id: :wP3, m: 0},
        d2: {id: :wP4, m: 0},
        e2: {id: :wP5, m: 0},
        f2: {id: :wP6, m: 0},
        g2: {id: :wP7, m: 0},
        h2: {id: :wP8, m: 0},
        a3: nil,
        b3: nil,
        c3: nil,
        d3: nil,
        e3: nil,
        f3: nil,
        g3: nil,
        h3: nil,
        a4: nil,
        b4: nil,
        c4: nil,
        d4: nil,
        e4: nil,
        f4: nil,
        g4: nil,
        h4: nil,
        a5: nil,
        b5: nil,
        c5: nil,
        d5: nil,
        e5: nil,
        f5: nil,
        g5: nil,
        h5: nil,
        a6: nil,
        b6: nil,
        c6: nil,
        d6: nil,
        e6: nil,
        f6: nil,
        g6: nil,
        h6: nil,
        a7: {id: :bP1, m: 0},
        b7: {id: :bP2, m: 0},
        c7: {id: :bP3, m: 0},
        d7: {id: :bP4, m: 0},
        e7: {id: :bP5, m: 0},
        f7: {id: :bP6, m: 0},
        g7: {id: :bP7, m: 0},
        h7: {id: :bP8, m: 0},
        a8: {id: :bR1, m: 0},
        b8: {id: :bN1, m: 0},
        c8: {id: :bB1, m: 0},
        d8: {id: :bQ1, m: 0},
        e8: {id: :bK1, m: 0},
        f8: {id: :bB2, m: 0},
        g8: {id: :bN2, m: 0},
        h8: {id: :bR2, m: 0}}

    end

    def update_board(
      from_space:,
      from_space_occupant:,
      to_space:,
      to_space_occupant:)

      puts "update_board args: #{from_space}, #{from_space_occupant}, #{to_space},#{to_space_occupant}"

      @board[from_space] = from_space_occupant
      @board[to_space] = to_space_occupant 
    end

    def space_to_strings(key:, val:)
      {"loc" => "#{key}", "occ" => "#{val}"}
    end

  end
end
