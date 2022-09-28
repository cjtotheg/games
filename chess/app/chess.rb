require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'
require_relative 'pawn.rb'

DEBUG = ENV["RACK_ENV"] == "test" ? true : false

BOARD = {
      "a1" => Rook.new(id: :wR1, color: :white),
      "b1" => Knight.new(id: :wN1, color: :white),
      "c1" => Bishop.new(id: :wB1, color: :white),
      "d1" => Queen.new(id: :wQ1, color: :white),
      "e1" => King.new(id: :wK1, color: :white),
      "f1" => Bishop.new(id: :wB2, color: :white),
      "g1" => Knight.new(id: :wK2, color: :white),
      "h1" => Rook.new(id: :wR2, color: :white),
      "a2" => Pawn.new(id: :wP1, color: :white),
      "b2" => Pawn.new(id: :wP2, color: :white),
      "c2" => Pawn.new(id: :wP3, color: :white),
      "d2" => Pawn.new(id: :wP4, color: :white),
      "e2" => Pawn.new(id: :wP5, color: :white),
      "f2" => Pawn.new(id: :wP6, color: :white),
      "g2" => Pawn.new(id: :wP7, color: :white),
      "h2" => Pawn.new(id: :wP8, color: :white),
      "a3" => nil,
      "b3" => nil,
      "c3" => nil,
      "d3" => nil,
      "e3" => nil,
      "f3" => nil,
      "g3" => nil,
      "h3" => nil,
      "a4" => nil,
      "b4" => nil,
      "c4" => nil,
      "d4" => nil,
      "e4" => nil,
      "f4" => nil,
      "g4" => nil,
      "h4" => nil,
      "a5" => nil,
      "b5" => nil,
      "c5" => nil,
      "d5" => nil,
      "e5" => nil,
      "f5" => nil,
      "g5" => nil,
      "h5" => nil,
      "a6" => nil,
      "b6" => nil,
      "c6" => nil,
      "d6" => nil,
      "e6" => nil,
      "f6" => nil,
      "g6" => nil,
      "h6" => nil,
      "a7" => Pawn.new(id: :bP1, color: :black),
      "b7" => Pawn.new(id: :bP2, color: :black),
      "c7" => Pawn.new(id: :bP3, color: :black),
      "d7" => Pawn.new(id: :bP4, color: :black),
      "e7" => Pawn.new(id: :bP5, color: :black),
      "f7" => Pawn.new(id: :bP6, color: :black),
      "g7" => Pawn.new(id: :bP7, color: :black),
      "h7" => Pawn.new(id: :bP8, color: :black),
      "a8" => Rook.new(id: :bR1, color: :black),
      "b8" => Knight.new(id: :bN1, color: :black),
      "c8" => Bishop.new(id: :bB1, color: :black),
      "d8" => Queen.new(id: :bQ1, color: :black),
      "e8" => King.new(id: :bK1, color: :black),
      "f8" => Bishop.new(id: :bB2, color: :black),
      "g8" => Knight.new(id: :bK2, color: :black),
      "h8" => Rook.new(id: :bR2, color: :black),  
}


class Game

end
