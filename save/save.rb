#require_relative "../lib/game"
require_relative "../lib/board"
require_relative "../lib/chess"
require_relative "../lib/player"
require "yaml"


def test_save
	@board_dump = YAML::dump(@board)
	@board_copy = YAML::load(@board_dump)
	cood = [1,2,6,0]
	cell = @board_copy.grid[1][2]
	cell2 = @board_copy.grid[6][0]	
	@board_copy.update_board(cood, cell, cell2)

end	


def test_move(choice)
		coordinates = convert_choice(choice)
		@board_copy = copy_board
			old_cell = @board_copy.grid[coordinates[0]][coordinates[1]]
			new_cell = @board_copy.grid[coordinates[2]][coordinates[3]]
			
			@board_copy.update_board(coordinates, old_cell, new_cell)
			if possible_check(@player_turn.color)	
				puts "That move is illegal, it would leave you in check."
				
			
			
			end		
		
	
	
end


def possible_check(color)
		king_coordinates = find_king2(color)
		puts "the king is on #{king_coordinates.inspect}"
		if under_attack?(king_coordinates, color)
			puts "the king is under attack!!!!"
			true
		else
			false	
		end	
		
		
	end

		def find_king2(color)
		

		@board_copy.grid.each_with_index do |row, index|
			x_coord = index
			row.each_with_index do |cell, index|
				y_coord = index
				if cell.piece == 0
					next
				elsif cell.piece.color == color && cell.piece.instance_of?(King)
						square = [x_coord, y_coord]
						@location_of_king = square
				else
					next 
				end			
			end
		end
		@location_of_king
	end


def copy_board
	@board_dump = YAML::dump(@board)
	@board_copy = YAML::load(@board_dump)
	@board_copy
	
end

