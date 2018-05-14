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
		@board.status_check(@player_turn.color) #this removes enpassent tags at the moment
		switch_player
		@board.draw_board
		end
	end

	def player_move
		choice = get_choice
		#@board_snapshot = @board.clone #this doesn't work at present because it creates a copy of the grid but puts all the same objects in it. have 
		#to map and clone individually or something.
		@board.update_board(choice)
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


	




