require 'minitest/autorun'

require_relative 'bad_elephant'
describe BadElephant do
  it "finds the elf with all the presents" do
    BadElephant.find(2).must_equal(1)
    BadElephant.find(2).must_equal(BadElephant.find_with_math(2))
    BadElephant.find(3).must_equal(3)
    BadElephant.find(3).must_equal(BadElephant.find_with_math(3))
    BadElephant.find(4).must_equal(1)
    BadElephant.find(5).must_equal(3)
    BadElephant.find(6).must_equal(5)
    BadElephant.find(7).must_equal(7)
    BadElephant.find(8).must_equal(1)
    BadElephant.find(9).must_equal(3)
    BadElephant.find(10).must_equal(5)
    BadElephant.find(11).must_equal(7)
    BadElephant.find(12).must_equal(9)
    BadElephant.find(13).must_equal(11)
    BadElephant.find(13).must_equal(BadElephant.find_with_math(13))
    BadElephant.find(14).must_equal(13)
    BadElephant.find(15).must_equal(15)
    BadElephant.find(16).must_equal(1)
  end
end
