class Player

	attr_accessor :player_name, :color, :in_check, :computer
	
	def initialize(player_name, color)
		@computer = false
		@player_name = player_name
		@color = color
		@in_check  = false
	end
end	