#!/usr/bin/env ruby

require_relative 'trapped_floor'

row = ARGF.read.chomp
counter = 0
400_000.times do |i|
  counter += row.count('.')
  row = TrappedFloor.next(row)
end
puts counter
