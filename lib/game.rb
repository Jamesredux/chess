require_relative 'board'
require_relative 'player'
require_relative 'chess'

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
		puts "#{@player_turn.player_name} Input your choice"
		all_available_moves(@player_turn.color)
		player_move
		#run 'status check' here which would check for checks and stalemate? and clear enpassant
		@board.status_check(@player_turn.color) #this removes enpassant tags at the moment
		switch_player
		@board.draw_board
		end
	end

	def player_move
		move_ok = false
		while move_ok == false
			choice = get_choice
			coordinates = convert_choice(choice)
			old_cell = @board.grid[coordinates[0]][coordinates[1]]
			new_cell = @board.grid[coordinates[2]][coordinates[3]]
			snapshot(old_cell, new_cell)
			@board.update_board(coordinates, old_cell, new_cell)
			if in_check?(@player_turn.color)
				puts "You can not move into check"
				revert_board(old_cell, new_cell)
			else
				move_ok = true
			end		
		end	
	end

	def snapshot(old_cell, new_cell)
		@old_cell_snapshot = cell_memory(old_cell)
		@new_cell_snapshot = cell_memory(new_cell)
		
	end

	def cell_memory(cell)
		cell_contents =  []
		cell_contents<<cell.symbol
		cell_contents<<cell.piece
		if cell.piece != 0
			cell_contents<<cell.piece.first_move
		end	
		cell_contents<<cell.enpassant
		cell_contents<<cell.enpassant_color
		cell_contents
	end	



	def revert_board(old_cell, new_cell)
		revert_cell(old_cell, @old_cell_snapshot)
		revert_cell(new_cell, @new_cell_snapshot)
	end

	def revert_cell(cell, contents)
		puts "cell to be reverted #{cell}"
		puts "contents to be put back #{contents}"
		cell.symbol = contents[0]
		cell.piece = contents[1]
		if cell.piece != 0
			cell.piece.first_move = contents[2]
			cell.enpassant = contents[3]
			cell.enpassant = contents[4]
		else
			cell.enpassant = contents[2]
			cell.enpassant = contents[3]
		end	

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


	




