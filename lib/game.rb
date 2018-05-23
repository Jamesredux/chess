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
		@game_over = false
		
	end

	def create_players
		@player_1 = Player.new("Player_1", "white")
		@player_2 = Player.new("Player_2", "black")
		@player_turn = @player_1
	end		

	def play_chess
		all_available_moves(@player_turn.color)
		until @game_over
			play_game
		end	
		
	end

	def play_game
		player_greeting
		player_move
		
		@board.clean_board(@player_turn.color) #this removes enpassant tags at the moment
		switch_player
		@board.draw_board
		status_check
		

	end

	def player_greeting
		if @player_turn.in_check == false 
			puts "#{@player_turn.player_name} Input your choice"
		else
			puts "******#{@player_turn.player_name} IS IN CHECK****** \n#{@player_turn.player_name} Input your choice"
		end	
	end

	def player_move
			choice = get_choice
			coordinates = convert_choice(choice)
			vertical_move =  (coordinates[0] - coordinates[2]).abs
			old_cell = @board.grid[coordinates[0]][coordinates[1]]
			new_cell = @board.grid[coordinates[2]][coordinates[3]]
			@board.update_board(coordinates, old_cell, new_cell)
			if new_cell.piece.instance_of?(Pawn) && vertical_move == 2
				@board.enpassant_check(coordinates, old_cell, new_cell, @player_turn.color)
			elsif new_cell.piece.instance_of?(Pawn) && @board.last_row(coordinates)
				@board.promote(new_cell)
			end	
	end

	def status_check
		if in_check?(@player_turn.color) && @sum_of_moves == 0
				checkmate
		elsif @sum_of_moves == 0
				stalemate		
		elsif in_check?(player_turn.color)
				@player_turn.in_check = true		
		end		
	end

	def stalemate
			puts "Stalemate #{player_turn.player_name} has no legal moves -- game over"	
			@game_over = true
	end

	def checkmate
		@player_turn.color == 'black' ? winning_color = 'white' : winning_color = 'black'
		puts "CHECKMATE #{player_turn.player_name} cannot escape #{winning_color} is the winner"
		@game_over = true
		
	end

	
	
	def get_choice
		move_choice = gets.downcase.chomp
		if move_choice == 'save'
			test_save
		elsif correct_input(move_choice, @player_turn.color) == false 
			move_choice = get_choice		
		elsif legal_move(move_choice, @player_turn.color) == false
			move_choice = get_choice 
		end
			move_choice
	end	



	def switch_player
		@player_turn.in_check = false
		@player_turn == @player_1 ? @player_turn = @player_2 : @player_turn = @player_1
		all_available_moves(@player_turn.color)
	end

	
end	


game = Game.new
game.create_players
game.new_game
game.play_chess


	




