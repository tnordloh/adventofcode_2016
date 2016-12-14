
require 'minitest/autorun'

require_relative 'assembly'
describe Assembly do
  it "takes an input, produces correct output" do
    instructions = "cpy 41 a\ninc a\ninc a\ndec a\njnz a 2\ndec a".split("\n")

    a = Assembly.new(instructions)
    a.execute.must_equal([42,0,0,0])
    
  end
end
