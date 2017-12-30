require './lib/piece.rb'



class Rook < Piece
	attr_accessor :color

	def initialize(color)
		super
		@has_moved = false #for castling
	end


end	

