
require 'minitest/autorun'

require_relative 'screen'

describe Screen do

  def setup
    @start_screen = 3.times.map  { y = Array.new(7,default=".")}
  end

  it "fills 3x2 and rotates a y-axis" do
    2.times {|x| 
      3.times {|y| 
        @start_screen[x][y] = "#"
      }
    } 
    x = Screen.new(7,3)
    x.fill(3,2).must_equal(@start_screen)
  end

  it "fills with 3x2, then rotates 'x' once" do
    return_value="#.#....\n###....\n.#....."
    x = Screen.new(7,3)
    x.fill(3,2)
    x.rotate_x(1,1)
    x.to_s.must_equal(return_value)
  end

end
