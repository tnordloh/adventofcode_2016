require 'minitest/autorun'

require_relative 'bad_elephant_2'
describe BadElephant do
  it "finds the elf with all the presents" do
   #BadElephant.find(3001330).must_equal(0)
   BadElephant.find(1).must_equal(1)
   BadElephant.find(2).must_equal(1)
   BadElephant.find(3).must_equal(3)
   BadElephant.find(4).must_equal(1)
   BadElephant.find(5).must_equal(2)
   BadElephant.find(6).must_equal(3)
   BadElephant.find(7).must_equal(5)
   BadElephant.find(8).must_equal(7)
   BadElephant.find(9).must_equal(9)
   BadElephant.find(9).must_equal(BadElephant.find_with_math(9))
   BadElephant.find(10).must_equal(1)
   BadElephant.find(11).must_equal(2)
   BadElephant.find(12).must_equal(3)
   BadElephant.find(13).must_equal(4)
   BadElephant.find(14).must_equal(5)
   BadElephant.find(15).must_equal(6)
   BadElephant.find(16).must_equal(7)
   BadElephant.find(17).must_equal(8)
   BadElephant.find(18).must_equal(9)
   BadElephant.find(18).must_equal(BadElephant.find_with_math(18))
   BadElephant.find(19).must_equal(11)
   BadElephant.find(20).must_equal(13)
   BadElephant.find(21).must_equal(15)
   BadElephant.find(22).must_equal(17)
   BadElephant.find(23).must_equal(19)
   BadElephant.find(24).must_equal(21)
   BadElephant.find(25).must_equal(23)
   BadElephant.find(26).must_equal(25)
   BadElephant.find(27).must_equal(27)
   BadElephant.find(28).must_equal(1)
   BadElephant.find(29).must_equal(2)
   BadElephant.find(30).must_equal(3)
   BadElephant.find(30).must_equal(BadElephant.find_with_math(30))
   BadElephant.find(31).must_equal(4)
   BadElephant.find(32).must_equal(5)
   BadElephant.find(33).must_equal(6)
   BadElephant.find(34).must_equal(7)
   BadElephant.find(35).must_equal(8)
   BadElephant.find(36).must_equal(9)
   BadElephant.find(37).must_equal(10)
  end
end
