require './lib/piece.rb'


class Bishop < Piece 
	attr_accessor :color, :symbol

	def initialize(color)
		super
		@symbol = find_symbol
	end

	def find_symbol
		@color == "white" ? "\u2657" : "\u265D"
	end	

end