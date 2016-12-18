module DragonChecksum
  module_function
  def next(seed)
    "#{seed}0#{seed.chars.reverse.map {|c| c == "0" ? "1" : "0" }.join}"
  end
  
  def checksum(data)
    begin
      data = data.chars.each_slice(2).map { |x,y| x == y ? "1" : "0" }.join
    end while data.size % 2 == 0
    data
  end
end

if $0 == __FILE__
  p output = "01110110101001000"
  p length = 35_651_584
  while output.size < length 
    output = DragonChecksum.next(output)
  end
  p DragonChecksum.checksum(output[0,length])
end
