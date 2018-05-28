require "./lib/chess"

describe Chess do 
	include Chess

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






















	
end