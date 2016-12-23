#!/usr/bin/env ruby

require_relative "blocked_ips"

ranges = ARGF.readlines.map { |line| 
  line.chomp
  _,min,max = /(\d+)\-(\d+)/.match(line).to_a.map(&:to_i)
  (min..max)
}
puts BlockedIps.count_all_allowed(ranges)
