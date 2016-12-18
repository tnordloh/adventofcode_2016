#!/usr/bin/env ruby

require_relative 'dragon_checksum'


p output = ARGV[0]
p length = ARGV[1].to_i
while output.size < length 
	output = DragonChecksum.next(output)
end
p DragonChecksum.checksum(output[0,length])
