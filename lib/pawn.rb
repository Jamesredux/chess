require './lib/piece.rb'


class Pawn < Piece 
	attr_accessor :color, :symbol

	def initialize(color)
		super
		@symbol = find_symbol
		@first_move = true #still has first move
	end

	def find_symbol
		@color == "white" ? "\u2659" : "\u265F"
	end	

end