#!/usr/bin/env ruby

require_relative 'dragon_checksum'

output = ARGV[0]
length = ARGV[1].to_i
output = EraseMyTracks.dragon_curve(output,length)
puts EraseMyTracks.checksum(output)
