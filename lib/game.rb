require_relative 'board'
require_relative 'player'

class Game
	attr_accessor :player_turn	

	def new_game
		@board = BoardClass.new
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
		
		if @board.valid_move(move_choice, @player_turn.color) == false 
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


bob = Game.new
bob.create_players
bob.new_game
bob.play_game
	

#new_position = [x.square, y].transpose.map { |y| y.reduce(:+)} 


