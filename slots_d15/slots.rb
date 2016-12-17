class Slots
  def initialize
    @wheels = []
  end  
  attr_reader :wheels, :biggest_wheel
  attr_writer :wheels

  def max
    @biggest_wheel ||= 
      @wheels.max_by { |wheel| wheel.size }
      .size
  end

  def add(size,position)
    wheels << (0...size).map {|i| i }.rotate(position)
  end

  def normalize
    biggest = max
    wheels.map! { |wheel| 
      div,mod = biggest.divmod(wheel.size)
      multiplier = div + (mod == 0 ? 0 : 1)
      wheel * multiplier
    }
  end

  def rotate(num)
    wheels.map { |wheel|
      wheel.rotate(num)
    }
  end

  def combination?(num)
    rotate(num)
      .each_with_index
      .map { |wheel,i| wheel[(i % wheel.size) + 1] == 0 }
      .all?
  end
end


if $0 == __FILE__
  w = Slots.new
  w.add(17,1)
  w.add(7,0)
  w.add(19,2)
  w.add(5,0)
  w.add(3,0)
  w.add(13,5)
  w.add(11,0)
#  w.add(5,4)
#  w.add(2,1)
  p w.rotate(1)
  p w.normalize
  p w.combination?(4)
  p w.combination?(5)
  p w.rotate(5)
  (0..Float::INFINITY).each do |i|
    p i
    if w.combination?(i)
      puts "#{w.rotate(i).map { |w| w.join(",") }.join("\n")}"
      puts "solution is #{i}"
      break
    end
  end

end
