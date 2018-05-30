require "./lib/chess"
require "./lib/board"
require "./lib/player"

describe Chess do 
	include Chess
	before(:all) do 
		@board = Board.new
	end	

	context "player input" do
		it "checks size of input" do 
			expect(correct_length("1234")).to eql(true)
			expect(correct_length("")).to eql(false)	
			expect(correct_length("999999")).to eql(false)	
		end

		it "only accepts valid squares on the grid" do 
			expect(valid_input("a2a4")).to eql(true)
			expect(valid_input("a2a4")).to eql(true)
			expect(valid_input("a9a4")).to eql(false)
			expect(valid_input("4a2a")).to eql(false)
			expect(valid_input("ee45")).to eql(false)
			expect(valid_input("0033")).to eql(false)
			expect(valid_input("a2a2")).to eql(false)	

		end	

		it "only accepts letters a - h"  do 
			expect(letters_ok("a","a")).to eql(true)
			expect(letters_ok("i","h")).to eql(false)
		end	

		it "only accepts numbers 0 - 8"  do 
			expect(numbers_ok("3", "4")).to eql(true)
			expect(numbers_ok(3, 5)).to eql(false)
			expect(numbers_ok("12", "44")).to eql(false)
		end
	end		

		context "legal move" do 
		
			it "returns false if player does not have piece on square" do
				expect(players_piece?([4,4,5,5], "white")).to eql(false)	
			end	

			it "returns true if player does have piece on square" do
				expect(players_piece?([0,0,5,5], "black")).to eql(true)	
			end	

			it "will not let you land on a square you already occupy" do
				expect(land_on_own_piece?([0,0,0,1], 'black')).to eql(false)
			end	
			it "will let you land on a square that is unoccupied" do
				expect(land_on_own_piece?([0,0,2,0], 'black')).to eql(true)
			end	
			it "will let you land on a square with an opposition piece" do
				expect(land_on_own_piece?([0,0,6,0], 'black')).to eql(true)
			end	


		end	

		context "all available moves" do
			before do
				player = Player.new("spec_test", 'black')
				@player_turn = player
				all_available_moves('black')
			end
			it "successfully finds all the pieces correct color" do
				expect(@location_of_pieces.size).to eql(16)
			end	
			it "logs moves of pieces on starting positions"    do
				expect(@board.grid[1][5].piece.moves).to eql([[2,5],[3,5]])

			end	
		end	


		context "cell empty" do 
			it "returns true for unoccupied squares" do 
				expect(cell_empty(@board.grid[4][3])).to eql(true)
			end
			it "returns false on an occupied square" do 
				expect(cell_empty(@board.grid[7][0])).to eql(false)
			end	
		end		

		context "find king" do
			before do
				find_king('black')
			end	
			it "finds the square the king is on" do
				expect(@location_of_king).to eql([0,4])
			end	

		end	

		describe "in_check" do

			it "defaults to false on opening board" do
				expect(in_check?('white')).to eql(false)
			end	

			it "returns true when the king is threatened" do 
				@board.new_piece(@board.grid[6][4], Rook, 'black')
				expect(in_check?('white')).to eql(true)
			end	
		end

	describe "pawn attack" do 
		it "returns true for squares diagonally infront of pawn" do
			old_cell = @board.grid[6][2]
			new_cell = @board.grid[4][2]
			@board.update_board([6,2,4,2], old_cell, new_cell)
				expect(pawn_attack([3,3], "black")).to eql(true)
		end

		
 		it "returns false for squares straight in front of pawn" do
				old_cell = @board.grid[6][2]
				new_cell = @board.grid[4][2]
				@board.update_board([6,2,4,2], old_cell, new_cell)
					expect(pawn_attack([3,2], "black")).to eql(false)	
		end	
	end	

	describe  "diagonal attack" do
		before(:each) do
			@board.empty_board
			@board.new_piece(@board.grid[0][7], Bishop , "black")
		end	
	
		it "returns true if a bishop is  on the diagonal" do
			expect(diag_attack([7,0], 'white')).to eql(true)
		end

		it "returns false if both pieces are the same color" do
			expect(diag_attack([7,0], 'black')).to eql(false)
		end	

		it "returns false if a piece is  blocking the diagonal line" do
			@board.new_piece(@board.grid[4][3], Pawn , "white")
			expect(diag_attack([7,0], 'white')).to eql(false)
		end	

		it "returns false if the piece can not take diagonally" do 
			@board.new_piece(@board.grid[0][0], Rook , "black")
			expect(diag_attack([7,7], 'white')).to eql(false)
		end	



		end


		describe  "straight attack" do
		before(:each) do
			@board.empty_board
			@board.new_piece(@board.grid[0][7], Rook , "black")
		end	
	
		it "returns true if a rook is  on the row" do
			expect(straight_attack([0,0], 'white')).to eql(true)
		end

		it "returns true if a rook is on the column" do
			expect(straight_attack([7,7], 'white')).to eql(true)
		end

		it "returns false if both pieces are the same color" do
			expect(straight_attack([0,0], 'black')).to eql(false)
		end	

		it "returns false if a piece is  blocking the attack line" do
			@board.new_piece(@board.grid[0][3], Pawn , "white")
			expect(straight_attack([0,0], 'white')).to eql(false)
		end	

		it "returns false if the piece can not take diagonally" do 
			@board.new_piece(@board.grid[0][0], Bishop , "black")
			expect(straight_attack([7,0], 'white')).to eql(false)
		end	
	end



	describe  "attack from knight" do
		before do
			@board.empty_board
			@board.new_piece(@board.grid[0][1], Knight , "black")
		end	
	
		it "returns true if a knight can take" do
			expect(attack_from_knight([2,0], 'white')).to eql(true)
		end

		it "returns false if both pieces are the same color" do
			expect(attack_from_knight([2,0], 'black')).to eql(false)
		end	

		it "returns false if the piece is not a knight" do 
			@board.new_piece(@board.grid[0][6], Bishop , "black")
			expect(attack_from_knight([2,5], 'white')).to eql(false)
		end	
	end

	describe "under attack" do
		
		it "returns false for squares not under attack at start" do
			expect(under_attack?([6,3], "white")).to eql(false)

		end	

		before do
			@board.empty_board
		end	

		it "returns true if square is attacked by knight" do
			@board.new_piece(@board.grid[4][4], Knight , "black")
			expect(under_attack?([6,3], 'white')).to eql(true)
		end	

		it "returns true if square is attacked by pawn" do
			@board.new_piece(@board.grid[5][4], Pawn , "black")
			expect(under_attack?([6,3], 'white')).to eql(true)
		end

		it "returns true if square is attacked by queen horizontally" do
			@board.new_piece(@board.grid[3][3], Queen , "black")
			expect(under_attack?([6,3], 'white')).to eql(true)
		end

		it "returns true if square is attacked by queen diagonally" do
			@board.new_piece(@board.grid[2][7], Queen , "black")
			expect(under_attack?([6,3], 'white')).to eql(true)
		end

		it "returns true if square is attacked by king" do
			@board.new_piece(@board.grid[5][3], King, "black")
			expect(under_attack?([6,3], 'white')).to eql(true)
		end


	end	


	describe "square on board" do 
		it "returns true for coordinates that are on 0-7 grid" do
			expect(square_on_board([7,7])).to eql(true)
		end
		
		it "returns false for coordinates that would be outside the chessboard" do 
			expect(square_on_board([8,8])).to eql(false)
		end		

	end	

	describe "take_square" do
		before do
			@board = Board.new
		end	
		it "returns false if the square is empty" do 
			expect(take_square([4,0], 'white')).to eql(false)
		end	

		it "returns false if the square is occupied by the king" do 
			expect(take_square([0,4], 'white')).to eql(false)
		end

		it "returns false if the square is occupied by a piece of the same color" do 
			expect(take_square([6,0], 'white')).to eql(false)
		end		

		it "returns true if the square is occupied by a different colored piece" do 
			
			expect(take_square([0,7], 'white')).to eql(true)
		end	

	end	
	

	


describe "squares clear" do
	include Chess
	before(:all) do 
		@board = Board.new
		@board.empty_board
		@cells = [[0,1],[0,2],[0,3],[0,4]]
	end	

	it "returns true on empty board" do
		expect(squares_clear(@cells, 'black')).to eql(true)
	end

	it "returns false when one square is attacked" do 
		@board.new_piece(@board.grid[7][2], Rook, "white")
		expect(squares_clear(@cells, 'black')).to eql(false)
	end	

	it "returns false when manny squares are attacked" do 
		@board.new_piece(@board.grid[7][2], Rook, "white")
		@board.new_piece(@board.grid[0][7], Rook, "white")
		@board.new_piece(@board.grid[6][7], Bishop, "white")
		expect(squares_clear(@cells, 'black')).to eql(false)
	end

	it "returns false when one square is attacked by king" do 
		@board.new_piece(@board.grid[1][1], King, "white")
		expect(squares_clear(@cells, 'black')).to eql(false)
	end	

	it "returns false when one square is attacked by pawn" do 
		@board.new_piece(@board.grid[1][5], Pawn, "white")
		expect(squares_clear(@cells, 'black')).to eql(false)
	end

end	

describe "single move check" do
	it "returns false for a queen" do
		@board.new_piece(@board.grid[0][3], Queen, "white")
		@piece_1 = @board.grid[0][3].piece
		expect(single_move?(@piece_1)).to eql(false)

	end	

	it "returns true for a king" do
	 @board.new_piece(@board.grid[0][4], King, "white")
		@piece_2 = @board.grid[0][4].piece
		expect(single_move?(@piece_2)).to eql(true)
	end	
end

end