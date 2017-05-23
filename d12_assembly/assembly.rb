
class Assembly
  def initialize(instructions,cpu = nil)
    @instructions = instructions
    @instructions << "EOF"
    @position = 0

    @cpu = cpu || {
      "a" => 0,
      "b" => 0,
      "c" => 0,
      "d" => 0
    }
  end
  attr_reader :cpu, :instructions
  attr_accessor :position

  def register?(value)
    cpu.keys.include?(value)
  end

  def parse(instruction)
    instruction.split(/\s+/)
  end

  def dec(register)
    cpu[register] -= 1
    position + 1
  end

  def inc(register)
    cpu[register] += 1
    position + 1
  end

  def cpy(source,destination)
    if register?(source)
      cpu[destination] = cpu[source]
    else
      cpu[destination] = source.to_i
    end
    position + 1
  end

  def jnz(register, distance)
    if register?(register) && cpu[register] != 0 
      position + distance.to_i 
    elsif register.to_i != 0
      position + distance.to_i
    else
      position + 1
    end
  end

  def execute
    while instructions[position] != "EOF"
      i = parse(instructions[position])
      @position = self.send(*i)
    end
    cpu
  end

end

if $0 == __FILE__
  instructions = ARGF.readlines 
    cpu = { 
      "a" => 0,
      "b" => 0,
      "c" => 1,
      "d" => 0
    }
  a = Assembly.new(instructions,cpu)
  p a.execute
end
