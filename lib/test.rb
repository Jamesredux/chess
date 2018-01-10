
require_relative 'moves'

include Moves
#this method takes the cell the piece is moving from and the piece the cell is moving to and 
# gives the difference in coordinates -- may be useful
# if you want to move something you just take the - in reduce and change it to a +
#but using a mathimatical thing like this may have problems a white piece going backwards will have the same move 
#equation as a black piece going forwards


#this method works i think?
def move_check(move_array)
	@valid = false

	#white_rook_moves_up = [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0]]
	#white_rook_moves_down = [[-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0]]
	#white_rook_moves_across_r = [[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7]]
	#white_rook_moves_across_l = [[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]
	white_rook_move_set = [VERT_UP, VERT_DOWN, HORIZ_EAST, HORIZ_WEST]

		white_rook_move_set.each do |x|
			x.each do |y|
				if move_array == y 
					@valid = true
				end
			end
		end			
	@valid
end



def move(old_cell, new_cell)
	
		move_array = [new_cell, old_cell].transpose.map { |y| y.reduce(:-)} 
		 move_check(move_array)
end	



	

puts move([7,7], [0,7])
puts move([6,3],[5,4])
puts move([7,1], [5,2])
puts move([7,0],[8,0]) #currently works for off board coordinate but this should aleady be checked for in other methods
puts VERT_DOWN[0].inspect