
require 'minitest/autorun'

require_relative 'cubicle'
describe Cubicle do
  cube = %{  0123456789
0 .#.####.##
1 ..#..#...#
2 #....##...
3 ###.#.###.
4 .##..#..#.
5 ..##....#.
6 #...##.###}
  it "generates a cubicle" do
    c = Cubicle.new(10)
    c.to_s.must_equal(cube)
  end
end
