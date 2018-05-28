require "./lib/piece"

describe Piece do 



	blackking = King.new("black")
	context "it inherits from piece class" do
		it "has a first move of true" do
			expect(blackking.first_move).to eql(true)
		end
	
	context "it is set up correctly" do	
		it "is assigned the correct symbol" do 
			expect(blackking.symbol).to eql("\u265A")	
		end	
		it "is assigned the correct color" do
			expect(blackking.color).to eql("black")
		end	
	end	

	end	





end	
