require_relative 'cell'
require_relative 'draw'
require_relative 'pawn'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'bishop'
require_relative 'knight'


class Board
	include Draw
	
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
		old_cell = grid[coordinates[0]][coordinates[1]]
		new_cell = grid[coordinates[2]][coordinates[3]]
		move_piece(old_cell, new_cell)
	end	

	def move_piece(old_cell, new_cell)
		#is it here that I will keep memorary of move in case I have to take back.
		#puts old_cell.piece
		#also possible en passant check if piece is pawn and first move is false then run
		#en passant check
		#if piece is king and move is castling run castling method (to be made) else run method below
		piece = old_cell.piece
		update_cell(new_cell, piece)
		empty_cell(old_cell)
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
	

	def convert_choice(move_choice)
		choice_array = move_choice.split('')
		converted = []
		choice_array.each do |x|
			converted << convert_element(x)
		end	
			
		reordered_choice = [converted[1], converted[0], converted[3], converted[2]]
		reordered_choice
	end

	def convert_element(x)
		number_coords = ['1','2','3','4','5','6','7','8']
		letter_coords = ['a','b','c','d','e','f','g','h']
		if number_coords.include? x 
			number_convert(x)
		elsif letter_coords.include? x 
			letter_convert(x)
		end		
	end	

	def number_convert(x)
		num = x.to_i
		new_num = 8 - num 
		new_num
	end
	
	def letter_convert(x)
		case x
		when 'a'	
			0
		when 'b'	
			1
		when 'c'	
			2
		when 'd'	
			3
		when 'e'	
			4
		when 'f'	
			5
		when 'g'	
			6
		when 'h'	
			7
		end
	end		


end	

