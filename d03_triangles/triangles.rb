#!/usr/bin/env ruby

@raw_data = File.readlines('input.txt')
def read_across
  @raw_data.map { |triangle| triangle.split.map(&:to_i) }
end

def read_down
  read_across.transpose.flatten.each_slice(3).to_a
end

def valid_triangle?(triangle)
  triangle.permutation.all? { |p| 
    p[0] + p[1] > p[2]
  }
end

p read_across.count { |triangle|
  valid_triangle?(triangle)
}
#p read_down.count { |triangle|
#  triangle.permutation.all?  {|p| valid_triangle?(p) }
#}
