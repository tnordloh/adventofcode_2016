class Room
  def initialize(raw_room)

    @name, @number, @checksum = raw_room.match(/(\D+)-(\d+)\[(.+)\]/).captures
    @number = @number.to_i
  end  

  attr_reader :name,:number,:checksum

  def valid?
    checksum_digits == checksum
  end


  def checksum_digits
    chars = name_char_count
    name_char_count.values.sort.reverse.first(5).map { |d| 
      chars.select {|n,v| v == d }.keys.sort.flatten.join
    }.uniq.join[0,5]
  end

  def name_char_count
    x = Hash.new(default=0)
    @name.chars.each {|c| 
      next if c == '-' 
      x[c] += 1 } 
    x
  end

  def value
    valid? ? @number : 0
  end

  def decrypt
    @name.chars.map do |c|
      i = c.ord + (number % 26)
      i > 'z'.ord ? (i - 26).chr : i.chr
    end.join
  end

end

x = Room.new(File.readlines('input2.txt').first)
p x.value

exit
rooms = File.readlines('input.txt').map do |raw_room|
  Room.new(raw_room)
end
p "starting inject"
p rooms.inject(0) {|a,r|
  a + r.value
}
rooms.inject(0) {|a,r|
  if r.valid?
    p r.number.to_s + " " + r.decrypt if r.decrypt =~ /northpole/
  end
  a + r.value
}
