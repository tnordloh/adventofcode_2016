#!/usr/bin/env ruby

@raw_data = File.readlines('input.txt')
def read_across
  @raw_data.map { |triangle| triangle.split.map(&:to_i) }
end

def read_down
  read_across.transpose.flatten.each_slice(3).to_a
end

def valid_triangle?(triangle)
  order = [[0,1,2],[0,2,1],[1,2,0]]
  order.all? { |o| 
    triangle[o[0]] + triangle[o[1]] > triangle[o[2]]
  }
end

p read_across.count { |triangle|
  valid_triangle?(triangle)
}
#p read_down.count { |triangle|
#  triangle.permutation.all?  {|p| valid_triangle?(p) }
#}
