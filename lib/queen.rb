require './lib/piece.rb'


class Queen < Piece 

	attr_accessor :color, :symbol

	def initialize(color)
		super
		@symbol = find_symbol
		
	end

	def find_symbol
		@color == "white" ? "\u2655" : "\u265B"
	end	

end