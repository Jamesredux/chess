require_relative 'board'
require_relative 'player'
require_relative 'chess'
require_relative "../save/save"

class Game
	include Chess
	attr_accessor :player_turn, :board

	def new_game
		@board = Board.new
		@board.draw_board
		
	end

	def create_players
		@player_1 = Player.new("Player_1", "white")
		@player_2 = Player.new("Player_2", "black")
		@player_turn = @player_1
	end		

	def play_game
		game_over = false
		until game_over
		player_greeting
		all_available_moves(@player_turn.color)
		if @sum_of_moves == 0 
			puts "Stalemate #{player_turn} has no legal moves -- game over"
			game_over = true
		end	
		player_move
		@board.clean_board(@player_turn.color) #this removes enpassant tags at the moment
		switch_player
			if in_check?(@player_turn.color)
				#checkmate check here
				@player_turn.in_check = true
			else 
				@player_turn.in_check = false	
			end

		@board.draw_board
		end
	end

	def player_greeting
		if @player_turn.in_check == false 
			puts "#{@player_turn.player_name} Input your choice"
		else
			puts "******#{@player_turn.player_name} IS IN CHECK****** \n#{@player_turn.player_name} Input your choice"
		end	
	end

	def player_move

		#move_ok = false
		#while move_ok == false
			choice = get_choice

			coordinates = convert_choice(choice)
			vertical_move =  (coordinates[0] - coordinates[2]).abs
			old_cell = @board.grid[coordinates[0]][coordinates[1]]
			new_cell = @board.grid[coordinates[2]][coordinates[3]]
		#	snapshot(old_cell, new_cell)
			@board.update_board(coordinates, old_cell, new_cell)
			if old_cell.piece.instance_of?(Pawn) && vertical_move == 2
				@board.enpassant_check(coordinates, old_cell, new_cell, @player_turn.color)
			end	
		#	if in_check?(@player_turn.color)	
		#		puts "That move is illegal, it would leave you in check."
		#		revert_board(old_cell, new_cell)
		#	else
		#		move_ok = true
		#	end		
		#end	

	end

	def snapshot(old_cell, new_cell)
		@old_cell_snapshot = cell_memory(old_cell)
		@new_cell_snapshot = cell_memory(new_cell)
		
	end

	def cell_memory(cell)
		cell_contents =  []
		cell_contents<<cell.symbol
		cell_contents<<cell.enpassant
		cell_contents<<cell.enpassant_color
		cell_contents<<cell.piece
		if cell.piece != 0
			cell_contents<<cell.piece.first_move
		end	
		
		cell_contents
	end	



	def revert_board(old_cell, new_cell)
		revert_cell(old_cell, @old_cell_snapshot)
		revert_cell(new_cell, @new_cell_snapshot)
	end

	def revert_cell(cell, contents)
		cell.symbol = contents[0]
		if cell.enpassant != false && cell.enpassant.size == 3
			cell_coords = cell.enpassant[0..1]
			contents[2] == 'white' ? cell_color = 'black' : cell_color = 'white'
			replace_enpassant_pawn(cell_coords, cell_color)
				puts "enpassant take attempted that will have to be reverted"
		end
		cell.enpassant = contents[1]
		cell.enpassant_color = contents[2]
		cell.piece = contents[3]
		if cell.piece != 0
			cell.piece.first_move = contents[4]
		end	

	end	

	def replace_enpassant_pawn(coords, color)
		cell = @board.grid[coords[0]][coords[1]]
		@board.new_piece(cell, Pawn, color)
		
	end
	
	def get_choice
		move_choice = gets.downcase.chomp
		
		if correct_input(move_choice, @player_turn.color) == false 
			move_choice = get_choice		
		elsif legal_move(move_choice, @player_turn.color) == false
			move_choice = get_choice 
		end
			move_choice
	end	



	def switch_player
		if @player_turn == @player_1
			@player_turn = @player_2
		else
			@player_turn = @player_1
		end
	end

	
end	


game = Game.new
game.create_players
game.new_game
game.play_game


	




