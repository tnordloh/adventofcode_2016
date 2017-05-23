#!/usr/bin/env ruby

require 'digest'
class


    @ = 

  def initialize
    #  
  attr_reader :
    @counter = (-1..Float::INFINITY).to_enum
  end

  def next_code(code)
    find_value do |i|
      match = Digest::MD5.hexdigest("#{code}#{i}").match( /^0{5}([0-7])(.)/)
      match.nil? ? nil : [match[1].to_i, match[2]]
    end
  end
 
# I tried each here, but it started the @counter over on each call to the method
  def find_value
    while true do
      p e if e % 1_000_000 == 0  #left status in, for reassurance
      e = @counter.next
      test = yield e
      return test if test
    end
  end

end

@code = ARGV.first

def insert(position,value)
  @output[position] = value if @output[position].nil?
end

md5 = MD5generator.new

@output = Array.new(8)
until @output.all?
  insert(*md5.next_code(@code))
end

p @output.join
