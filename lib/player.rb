class Player

	attr_accessor :player_name, :color
	
	def initialize(player_name, color)
		@player_name = player_name
		@color = color
		@turn = 1
		@in_check  = false
		#add position of king? could be useful
	end














end	