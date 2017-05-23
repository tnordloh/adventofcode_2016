
require 'minitest/autorun'

require_relative 'assembly'
describe Assembly do
  it "takes an input, produces correct output" do
    instructions = "cpy 2 a\ntgl a\ntgl a\ntgl a\ncpy 1 a\ndec a\ndec a\nEOF".split("\n")

    a = Assembly.new(instructions)
    return_value = Hash[['a',"b",'c','d'].zip([3,0,0,0])] 
    a.execute.must_equal(return_value)
    
  end
end
