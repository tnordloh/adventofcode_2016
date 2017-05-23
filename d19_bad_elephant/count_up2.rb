final_value = 1
sizer = 0
marker = [1,1,3]
sizer = marker.size

def fill_marker(size)
  (1..size).to_a + (size+1..size*3+1).to_a.select(&:odd?)[0,size]
end

1.upto(3001330) do |i|
  if marker.empty?
    marker = fill_marker(sizer)
    sizer  = marker.last
  end
  final_value = marker.shift
  puts "on #{i}, got #{final_value}" if i % 10_000 == 0
end
puts final_value
