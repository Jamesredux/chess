require_relative 'cell'
require_relative 'draw'
require_relative 'pawn'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'bishop'
require_relative 'knight'
require_relative 'chess'



class Board
	include Draw
	include Chess
	
	attr_accessor :grid

	def initialize
		@grid = create_grid
		set_up_board
	end

	def create_grid
		grid_array = []
			8.times do  |y|
				row_array = []
					8.times do |x|
					x = Cell.new
					row_array<<x 
					end
				grid_array<< row_array
			end			
		grid_array

	end	

	def set_up_board
		place_white_pieces
		place_black_pieces		
	end

	def place_white_pieces
		new_piece(grid[7][0], Rook, "white")
		new_piece(grid[7][7], Rook, "white")
		new_piece(grid[7][2], Bishop, "white")
		new_piece(grid[7][5], Bishop, "white")
		new_piece(grid[7][1], Knight, "white")
		new_piece(grid[7][6], Knight, "white")
		new_piece(grid[7][3], Queen, "white")
		new_piece(grid[7][4], King, "white")
		
		(0..7).each do |x|
			new_piece(grid[6][x], Pawn, "white")
		end
	end

	def place_black_pieces
		new_piece(grid[0][0], Rook, "black")
		new_piece(grid[0][7], Rook, "black")
		new_piece(grid[0][2], Bishop, "black")
		new_piece(grid[0][5], Bishop, "black")
		new_piece(grid[0][1], Knight, "black")
		new_piece(grid[0][6], Knight, "black")
		new_piece(grid[0][3], Queen, "black") 		
		new_piece(grid[0][4], King, "black")

		(0..7).each do |x|
			new_piece(grid[1][x], Pawn, "black")
		end
	end

	def new_piece(cell, piece_name, color)	
		cell.piece = piece_name.new(color)
		cell.symbol = cell.piece.symbol
	end


	
	def update_board(move_choice)
		coordinates = convert_choice(move_choice)
		horizonal_move = (coordinates[1] - coordinates[3]).abs
		vertical_move =  (coordinates[0] - coordinates[2]).abs
		old_cell = grid[coordinates[0]][coordinates[1]]
		color_moving = old_cell.piece.color
		new_cell = grid[coordinates[2]][coordinates[3]]
		
		if new_cell.enpassant != false
			enpassant_take(coordinates, old_cell, new_cell)
		elsif old_cell.piece.instance_of?(Pawn) && last_row(coordinates)
				promote(old_cell, new_cell)	
		elsif old_cell.piece.instance_of?(King) && horizonal_move == 2
			castle(coordinates, old_cell, new_cell)
		elsif old_cell.piece.instance_of?(Pawn) && vertical_move == 2
			enpassant_check(coordinates, old_cell, new_cell, color_moving)
			move_piece(old_cell, new_cell)	
		else	
			move_piece(old_cell, new_cell)
		end	
	end	

	def move_piece(old_cell, new_cell)
		#is it here that I will keep memorary of move in case I have to take back.
		#store old cell piece
		piece = old_cell.piece
		update_cell(new_cell, piece)
		empty_cell(old_cell)
	end

	def castle(coordinates,old_cell, new_cell)

		move_piece(old_cell, new_cell)
		castle_side = coordinates[2]+coordinates[3]
		case castle_side
			when 13
				rook_from = grid[7][7]
				rook_to = grid[7][5]
			when 9
				rook_from = grid[7][0]
				rook_to = grid[7][3]
			when 6
				rook_from = grid[0][7]
				rook_to = grid[0][5]
			when 2
				rook_from = grid[0][0]
				rook_to = grid[0][3]
			end			
				move_piece(rook_from, rook_to)
		
	end

	def enpassant_check(coordinates, old_cell, new_cell, color_moving)
		coordinates_to_check = [[coordinates[2],(coordinates[3]-1)],[coordinates[2],(coordinates[3]+1)]] #the squares either side of the pawn that has just moved 2
		coordinates_to_check.each do |x|
			if on_board(x)
				square = grid[x[0]][x[1]]
				if square.piece.instance_of?(Pawn) && square.piece.color != color_moving
					color_moving == "black" ? color_can_take = 'white' : color_can_take = 'black' 
					coordinates_behind = [(coordinates[0]+coordinates[2])/2,coordinates[1]] #square behind the pawn  that the taking pawn would move to.
					square_behind = grid[coordinates_behind[0]][coordinates_behind[1]]
					square_behind.enpassant = [coordinates[2],coordinates[3]] #stores cell infront that pawn will be removed from.
					square_behind.enpassant_color = color_can_take	
					end	
			end
		end
	end

	def enpassant_take(coordinates, old_cell, new_cell)
		puts "enpassant take"
		cell_to_empty = grid[new_cell.enpassant[0]][new_cell.enpassant[1]]
		empty_cell(cell_to_empty)
		move_piece(old_cell, new_cell)
	end

	def on_board(coordinates) #copy of method in chess module
		if coordinates[0] < 0 || coordinates[0] > 7
			false
		elsif coordinates[1] < 0 || coordinates[1] > 7
			false	
		else
			true
		end
		
	end

	def update_cell(cell, piece=0)
			if piece == 0
				cell.piece = 0
				cell.symbol = ' '
			else
				cell.piece = piece 
				cell.symbol = piece.symbol
				cell.piece.first_move = false	
			end	
	end

	def empty_cell(cell) #just a simplified method for emptying a cell
		update_cell(cell)
	end

	def status_check(color) #that will be the color that has just moved.
			grid.each do |row|
				row.each do |cell|
				clear_enpassant(cell, color)
				end
			end	

	end

	def clear_enpassant(cell, color)
		if cell.enpassant != false && cell.enpassant_color == color 
			cell.enpassant = false
			cell.enpassant_color = 0
		end	
	end

	def last_row(coordinates)
		row = coordinates[2]
			if row == 0 || row == 7
				true
			else
				false
			end	
	end	

	def promote(old_cell, new_cell)
		puts "Your Pawn has reached the final rank. How would you like to promote it\ninput 'Q' for Queen, 'K' for knight, 'R' for rook or 'B' for bishop."
		new_piece = choose_promotion
		piece_name = promote_piece(new_piece)
		new_piece(old_cell, piece_name, old_cell.piece.color)
		puts old_cell.inspect		
		move_piece(old_cell, new_cell)		#technically this changes the piece before it moves, is this a problem
	end

	def choose_promotion
		pieces_to_pick = ['q','b','k','r']
		piece_choice = gets.chomp.downcase
		if pieces_to_pick.include?(piece_choice)
			piece_choice
		else
			puts "I didn't understand that choice"
			choose_promotion
		end		
	end

	def promote_piece(new_piece)
		case new_piece
		when 'q'
			piece_name = Queen
		when 'r'
			piece_name = Rook
		when 'b'
			piece_name = Bishop
		when 'k'
			piece_name = Knight
		end		
		piece_name
	end
end