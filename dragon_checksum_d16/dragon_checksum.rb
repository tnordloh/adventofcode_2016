module EraseMyTracks
  module_function
	def dragon_curve(seed,minimum_length)
		while seed.size < minimum_length 
			seed = "#{seed}0#{next_curve(seed)}"
			return seed[0,minimum_length] if seed.size >= minimum_length
		end
	end

	def next_curve(current_curve)
		current_curve
			.chars
			.reverse
			.map {|c| c == "0" ? "1" : "0" }
			.join
	end

	def checksum(data)
		loop do
			data = data.chars.each_slice(2).map { |x,y| x == y ? "1" : "0" }.join
			return data if data.size.odd?
		end
	end
end

if $0 == __FILE__
	p output = "01110110101001000"
	p length = 35_651_584
  output = EraseMyTracks.dragon_curve(output,length)
	p EraseMyTracks.checksum(output)
end
