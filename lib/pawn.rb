require './lib/piece.rb'


class Pawn < Piece 
	attr_accessor :color

	def initialize(color)
		super
		@first_move = true
	end

end