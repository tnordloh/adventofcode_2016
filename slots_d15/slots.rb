class Slots
  def initialize
    @wheels = []
    @normalized = false
  end  
  attr_accessor :wheels

  def max
    @biggest_wheel ||= @wheels.max_by { |wheel| wheel.size }
      .size
  end

  def add(size,position)
    wheels << (0...size).map {|i| i }.rotate(position)
  end

  def normalize
    return wheels if @normalized == true
    @normalized = true
    wheels.map! { |wheel| 
      div,mod = max.divmod(wheel.size)
      multiplier = div + (mod == 0 ? 0 : 1)
      wheel * multiplier
    }
  end

  def rotate(num)
    wheels.map { |wheel| wheel.rotate(num) }
  end

  def combination?(num)
    normalize
      rotate(num)
      .each_with_index
      .map { |wheel,i| wheel[(i % wheel.size) + 1] == 0 }
      .all?
  end

  def find_solution
    (0..Float::INFINITY).find_index { |i| combination?(i) }
  end
end


if $0 == __FILE__
  test_data = [ [5,4], 
                [2,1] ]
  submission_data = [ [17,1], 
                      [7, 0],
                      [19,2],
                      [5, 0],
                      [3, 0],
                      [13,5],
  ]
  w = Slots.new
  test_data.each {|t| w.add(*t) }
  puts "test solution is #{w.find_solution}"
  w = Slots.new
  submission_data.each {|t| w.add(*t) }
  puts "first solution is #{w.find_solution}"
  w = Slots.new
  submission_data.each {|t| w.add(*t) }
  w.add(*[11,0])
  puts "second solution is #{w.find_solution}"
end
