
PATH=%w[R3 L5 R1 R2 L5 R2 R3 L2 L5 R5 L4 L3 R5 L1 R3 R4 R1 L3 R3 L2 L5 L2 R4 R5 R5 L4 L3 L3 R4 R4 R5 L5 L3 R2 R2 L3 L4 L5 R1 R3 L3 R2 L3 R5 L194 L2 L5 R2 R1 R1 L1 L5 L4 R4 R2 R2 L4 L1 R2 R53 R3 L5 R72 R2 L5 R3 L4 R187 L4 L5 L2 R1 R3 R5 L4 L4 R2 R5 L5 L4 L3 R5 L2 R1 R1 R4 L1 R2 L3 R5 L4 R2 L3 R1 L4 R4 L1 L2 R3 L1 L1 R4 R3 L4 R2 R5 L2 L3 L3 L1 R3 R5 R2 R3 R1 R2 L1 L4 L5 L2 R4 R5 L2 R4 R4 L3 R2 R1 L4 R3 L3 L4 L3 L1 R3 L2 R2 L4 L4 L5 R3 R5 R3 L2 R5 L2 L1 L5 L1 R2 R4 L5 R2 L4 L5 L4 L5 L2 L5 L4 R5 R3 R2 R2 L3 R3 L2 L5]

#SHORT_TRIP=%w[R5, L5, R5, R3]
SHORT_TRIP=%w[R8 R4 R4 R8]
class TaxiCab
  def initialize

    @visited = Hash.new
    @visited.default = 0
    @compass=%w[N W S E]
    @start_x = 0
    @start_y = 0
  end  

  attr_reader :visited

  def direction
    @compass[0]
  end

  def location_to_s
    "#{@start_x},#{@start_y}"
  end

  def parse(value)
    parsed = [ value[0,1],value[1..-1].to_i ]
    Hash[([:direction, :distance]).zip(parsed)]
  end

  def steps(path, &block)
    yield @visited if block
    path.each {|s| 
      turn(parse(s))
      move(parse(s))
      yield @visited if block
    }
  end

  def turn(instruction)
    @compass.rotate! if instruction[:direction] == "L"
    @compass.rotate!(3) if instruction[:direction] == "R"
  end

  def visit(range,axis)
    if axis == "Y"
      range.each {|coord|
        @visited[[@start_x,coord]] += 1
      }
    end
    if axis == "X"
      range.each {|coord|
        @visited[[coord,@start_y]] += 1
      }
    end
  end

  def move(instruction)
    case direction
    when "N"
      end_y = @start_y + instruction[:distance]
      visit(@start_y+1..end_y,"Y")
      @start_y += instruction[:distance]
    when "S"
      end_y = @start_y - instruction[:distance]
      visit(end_y...@start_y,"Y")
      @start_y -= instruction[:distance].to_i
    when "E"
      end_x = @start_x + instruction[:distance]
      visit(@start_x+1..end_x,"X")
      @start_x += instruction[:distance].to_i
    when "W"
      end_x = @start_x - instruction[:distance]
      visit(end_x...@start_x,"X")
      @start_x -= instruction[:distance].to_i
    end
    p @visited
    p location_to_s
  end

  def final_distance

    @start_x.abs + @start_y.abs
  end
end

if $0 == __FILE__
  locations = Hash.new
  locations.default = 0
  p "steps: #{PATH.size}"
  t = TaxiCab.new
  t.steps(PATH) {|visited| 

    p "twice at #{visited.rassoc(2)}" if visited.has_value?(2)
  }
  p t.final_distance
end
