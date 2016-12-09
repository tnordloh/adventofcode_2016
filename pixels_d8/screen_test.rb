
require 'minitest/autorun'

require_relative 'screen'

describe Screen do

  it "fills 3x2 and rotates a y-axis" do
    rv = 3.times.map  { y = Array.new(7,default=".")}
    rv.each {|l| p l.join }
    2.times {|x| 
      (0..2).each {|y| 
      rv[x][y] = "#"
    }} 
    rv.each {|l| p l.join }
    x = Screen.new(7,3)
    x.fill(3,2).must_equal(rv)
    rv2="#.#....\n###....\n.#....."
    x.rotate_x(1,1)
    x.to_s.must_equal(rv2)
  end

end
