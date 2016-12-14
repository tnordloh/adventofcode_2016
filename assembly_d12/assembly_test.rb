
require 'minitest/autorun'

require_relative 'assembly'
describe Assembly do
  it "takes an input, produces correct output" do
    instructions = "cpy 41 a\ninc a\ninc a\ndec a\njnz a 2\ndec a\nEOF".split("\n")

    a = Assembly.new(instructions)
    return_value = Hash[['a',"b",'c','d'].zip([42,0,0,0])] 
    a.execute.must_equal(return_value)
    
  end
end
