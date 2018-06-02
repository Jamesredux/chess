require "./lib/chess"
require "./lib/board"

describe Board do 
	

	context "initial set up" do
		before do 
			@board = Board.new
		end
		it "sets up board with pieces in correct place" do
			expect(@board.grid[0][5].piece.color).to eql('black')
		end	

		it "places pieces on correct square" do 
			expect(@board.grid[7][0].piece).to be_instance_of(Rook)
		end	

		it "creates an 8 by 8 grid" do 
			expect(@board.grid.size).to eql(8)
		end
		
		it "creates an 8 by b grid" do 
			expect(@board.grid[0].size).to eql(8)
		end		
	end	

	describe "methods" do 
		before do 
			@board = Board.new
		end

		context "new piece" do 

			it "sets new piece with default of first move true" do 
				@board.new_piece(@board.grid[4][6], Rook, "white")
				expect(@board.grid[4][6].piece.first_move).to eql(true)
			end
		end

		context "update board" do 
				let(:old_cell) { @board.grid[6][4] }
			  let(:new_cell) { @board.grid[4][4] }
			
			it "empties old cell" do
				@board.update_board([6,4,4,4], old_cell, new_cell )
				expect(@board.grid[6][4].piece).to be(0)
			end

			it "populates new cell" do
				@board.update_board([6,4,4,4], old_cell, new_cell )
				expect(@board.grid[4][4].piece).to be_instance_of(Pawn)

			end
		end	 

			context "castle" do
			let(:old_cell) { @board.grid[7][4] }
			let(:new_cell) { @board.grid[7][6] }

			it "calls castle method when king moves 2 horizontally" do 
				@board.update_board([7,4,7,6], old_cell, new_cell)
				expect(@board.grid[7][5].piece).to be_instance_of(Rook)
			end	



		end

	end	
















end
