module Moves
	

	VERT_DOWN = [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0]]
	VERT_UP = [[-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0]]
	HORIZ_EAST = [[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7]]
	HORIZ_WEST = [[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]

	DIAG_UP_EAST = [[-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7]]
	DIAG_UP_WEST = [[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]]
	DIAG_DOWN_EAST = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]
	DIAG_DOWN_WEST = [[1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7]]

	KNIGHT_MOVES = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
	KING_MOVES = [[1,0],[-1,0],[1,1],[-1,-1],[0,1],[0,-1],[-1,1],[1,-1]]
	
	QUEEN_MOVE_SET = [VERT_UP, VERT_DOWN, HORIZ_EAST, HORIZ_WEST, DIAG_UP_EAST, DIAG_UP_WEST, DIAG_DOWN_EAST, DIAG_DOWN_WEST]


	#white_rook_move_set = [white_rook_moves_up, white_rook_moves_down, white_rook_moves_across_r, white_rook_moves_across_l]



end