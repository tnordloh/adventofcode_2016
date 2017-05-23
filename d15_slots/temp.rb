sizes = [17,7,19,5,3,13]
positions = [1,0,2,0,0,5]
offsets = sizes.zip(positions)
  .each_with_index.map {|val,wheel_placement|
  val[0] - (wheel_placement+ 1) % val[0] - val[1]
}

biggest        = sizes.max
biggest_offset = offsets[sizes.rindex(biggest)]

result = (0..Float::INFINITY).find  do |i|
  index = biggest * i + biggest_offset
  sizes.zip(offsets).all? { |x|
    index % x[0]   == x[1]
  }
end
puts result * biggest + biggest_offset
