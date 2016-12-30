
require 'minitest/autorun'

require_relative 'assembly_multiply'
describe Assembly do
  it "takes an input, produces correct output" do
    instructions = File.readlines('input2.txt')

    return_value = Hash[['a',"b",'c','d'].zip([11739,1,0,0])] 
  cpu = { 
    "a" => 7,
    "b" => 0,
    "c" => 0,
    "d" => 0
  }
    a = Assembly.new(instructions,cpu)
    a.execute.must_equal(return_value)
    
  end
end
