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


end
		

def copy_board
	@board_dump = YAML::dump(@board)
	@board_copy = YAML::load(@board_dump)
	@board_copy
	
end

