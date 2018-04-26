require './lib/piece.rb'

class King < Piece 
	attr_accessor :color, :symbol

	def initialize(color)
		super
		@symbol = find_symbol
		@in_check = false
	end

	def find_symbol
		@color == "white" ? "\u2654" : "\u265A"
	end	
end