sizes = [17,7,19,5,3,13]
positions = [1,0,2,0,0,5]
offsets = sizes.zip(positions)
  .each_with_index.map {|val,wheel_placement|
  val[0] - (wheel_placement+ 1) % val[0] - val[1]
}

p sizes
p positions
p offsets
biggest        = sizes.max
biggest_offset = offsets[sizes.rindex(biggest)]

s_o = sizes.zip(offsets)
(0..Float::INFINITY).find  do |i|
  index = biggest * i + biggest_offset
  puts biggest
  puts  index
  s_o.all? { |x|
    puts "checking #{index} against #{x.join(",")}"
    index % x[0]   == x[1]
  }
end

