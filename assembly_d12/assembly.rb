
class Assembly
  def initialize(instructions,registers)
    @instructions = instructions
    @position = 0

    @registers = registers || {
      "a" => 0,
      "b" => 0,
      "c" => 0,
      "d" => 0
    }
  end

  def parse(instruction)
    instruction.split(/\s+/)
  end

  def dec(register)
    @registers[register] -= 1
    @position + 1
  end

  def inc(register)
    @registers[register] += 1
    @position + 1
  end

  def cpy(source,destination)
    if source.to_i > 0
      @registers[destination] = source.to_i
    else
      @registers[destination] = @registers[source]
    end
    @position + 1
  end

  def jnz(register, distance)
    if ("a".."d").include?(register) && @registers[register] != 0 
      @position + distance.to_i 
    elsif register.to_i != 0
      @position + distance.to_i
    else
      @position + 1
    end
  end

  def execute
    while @position < @instructions.size
#      p @position
#      p @registers
      i = parse(@instructions[@position])
#      p i
      @position = self.send(*i)
    end
    @registers
  end

end

if $0 == __FILE__
  instructions = ARGF.readlines 
    registers = { 
      "a" => 0,
      "b" => 0,
      "c" => 1,
      "d" => 0
    }
  a = Assembly.new(instructions,registers)
  p a.execute
end
