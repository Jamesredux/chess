require_relative 'board'
require_relative 'player'
require_relative 'chess'

class Game
	include Chess
	attr_accessor :player_turn	

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
		choice = get_choice
		@board.update_board(choice)
		switch_player
		@board.draw_board
		end
	end
	
	def get_choice
		move_choice = gets.downcase.chomp
		
		if valid_move(move_choice, @player_turn.color) == false 
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

	def test_1
		put_board(0, 0)
	end	
end	


bob = Game.new
bob.create_players
bob.new_game
bob.play_game
bob.test_1
	

#new_position = [x.square, y].transpose.map { |y| y.reduce(:+)} 


