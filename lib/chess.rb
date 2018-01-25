require_relative 'board'
#require_relative 'game'

module Chess


	def valid_move(move_choice, color)
		@coordinates = convert_choice(move_choice)
		if correct_length(move_choice) == false 
			puts "Incorrect input! Please only input 4 characters eg. A6A5"
			false
		elsif valid_input(move_choice) == false
			puts "Invalid input - please use the format B3H5"
			false	
		elsif players_piece?(@coordinates, color) == false
			puts "You do not have a piece on that square."
			false
		elsif land_on_own_piece?(@coordinates, color) == false    #logically this should be in legal move
			puts "You can not move to a square you already occupy"
			false	 
		else
			true
		end	
	end		

	def correct_length(move_choice)
		move_choice.size == 4? true :false
	end

	def players_piece?(coordinates, color)
		x = coordinates[0]
		y = coordinates[1]
		if @board.grid[x][y].piece == 0 || @board.grid[x][y].piece.color != color
			false
		else
			true
		end		 	
	end	

	def land_on_own_piece?(coordinates, color)   #incorporate this into legal move check - just add that last square is not own piece
		x = coordinates[2]
		y = coordinates[3]
		if @board.grid[x][y].piece == 0
			true
		elsif 
			@board.grid[x][y].piece.color == color 
		  false
		else
			true
		end		
	end	

	def valid_input(move_choice)
		choice_array = move_choice.split('')
		if letters_ok(choice_array[0], choice_array[2]) == false
			false
		elsif numbers_ok(choice_array[1], choice_array[3]) == false
			false
		elsif choice_array[0] == choice_array[2] && choice_array[1] == choice_array[3]
			false
		else
		 true
		end
	end 			

	def letters_ok(a,b)
		letter_coords = ['a','b','c','d','e','f','g','h']

		if letter_coords.include?(a) && letter_coords.include?(b) 
			true
		else
			false
		end
	end

	def numbers_ok(a, b)	
		number_coords = ['1','2','3','4','5','6','7','8']

		if  number_coords.include?(a) && number_coords.include?(b)
			true
		else
			false	
		end			 
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


def legal_move(move_choice, color)
		@coordinates = convert_choice(move_choice)
		old_cell = @board.grid[@coordinates[0]][@coordinates[1]]
		new_cell = @board.grid[@coordinates[2]][@coordinates[3]]
		move_formula = move_formula([@coordinates[0], @coordinates[1]], [@coordinates[2], @coordinates[3]])
		if old_cell.piece.move_check(move_formula, new_cell) == false   #include new_cell in arguement
			puts "Invalid move for selected piece"
			false
		elsif route_clear(old_cell, new_cell, @coordinates, move_formula) == false
			puts "The path you selected is obstructed by other pieces."
			false	
			#next put a check to see if route is clear in seperate method
		else
			true
		end	
		

	end	

	def move_formula(old_cell, new_cell)
		move_formula = [new_cell, old_cell].transpose.map { |y| y.reduce(:-)}
		move_formula
	end

	def route_clear(old_cell, new_cell, coordinates, move_formula)

		if @board.grid[coordinates[0]][coordinates[1]].piece.instance_of? Knight 
			true
		elsif  coordinates[0] == coordinates[2] || coordinates[1] == coordinates[3]
			straight_route(coordinates, move_formula)
			

			
		elsif move_formula[0].abs == move_formula[1].abs
			diagonal_route(coordinates, move_formula)
		  
		 end 	
		
	end


	def straight_route(coordinates, move_formula)
		if move_formula[0] == 0 
			moves = move_formula[1].abs - 1
			 horizontal_move(coordinates, move_formula, moves)
		else
			moves = move_formula[0].abs - 1
			
			vertical_move(coordinates, move_formula, moves)
		end	
	end

	def horizontal_move(coordinates, move_formula, moves)
		@clear_path = true
		start_cell = coordinates[1]
		move_direction = move_formula[1]/move_formula[1].abs
		moves.times do |x|
			next_cell = start_cell + move_direction
			if 
			cell_empty(@board.grid[coordinates[0]][next_cell]) == false
				@clear_path = false
			end	
			start_cell = next_cell
		end
		@clear_path
	end

	def vertical_move(coordinates, move_formula, moves)
		@clear_path = true
		start_cell = coordinates[0]
		move_direction = move_formula[0]/move_formula[0].abs
		moves.times do |x|
			next_cell = start_cell + move_direction
			if 
			cell_empty(@board.grid[next_cell][coordinates[1]]) == false
				@clear_path = false
			end	
			start_cell = next_cell
		end
		@clear_path
	end

	def diagonal_route(coordinates, move_formula)
		@clear_path = true
		moves = move_formula[0].abs - 1
		start_x = coordinates[0]
		start_y = coordinates[1]
		x_move = move_formula[0]/move_formula[0].abs
		y_move = move_formula[1]/move_formula[1].abs

		moves.times do |x|
			next_x = start_x + x_move
			next_y = start_y + y_move
			if 
				cell_empty(@board.grid[next_x][next_y]) == false
				@clear_path = false
			end
			start_x = next_x
			start_y = next_y

		end	

		@clear_path

	end	

	def cell_empty(cell)
		if cell.piece == 0
			true
		else
			false
		end		
		
		
	end















end	