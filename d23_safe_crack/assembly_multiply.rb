
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
      position + (register?(distance) ? cpu[distance] : distance.to_i)
    else
      position + 1
    end
  end

  def one_instruction?(instruction)
    instruction.split(/\s+/).size == 2
  end

  def toggle_maker(instruction)
    if instruction == "EOF"
      puts "no toggle on this one"
      instruction
    elsif (one_instruction?(instruction))
      if instruction.start_with?("inc")
        instruction.sub(/^.../,"dec")
      else
        instruction.sub(/^.../,"inc")
      end
    else
      if instruction.start_with?("jnz")
        instruction.sub(/^.../,"cpy")
      else
        instruction.sub(/^.../,"jnz")
      end
    end
  end

  def tgl(register)
    toggle_target = instructions[position + cpu[register]]
    puts "toggling #{toggle_target}"
    unless toggle_target == nil
      puts "one_instruction? #{one_instruction?(toggle_target)}"
      puts "changing instruction to #{toggle_maker(toggle_target)}"
      instructions[position + cpu[register]] = toggle_maker(toggle_target)
    end
    position + 1
  end

  def mul(destination,multiplier)
    multiply_by =  (register?(multiplier) ? cpu[multiplier] : multiplier.to_i)
    cpu[destination] = cpu[destination] * multiply_by
    position + 1
  end

  def execute
    counter = 0
    p cpu 
    while instructions[position] != "EOF"
      counter += 1
      p instructions[position]
      i = parse(instructions[position].chomp)
      @position = self.send(*i)
      p cpu 
    end
    cpu
  end

end

if $0 == __FILE__
  instructions = ARGF.readlines 
  cpu = { 
    "a" => 12,
    "b" => 0,
    "c" => 0,
    "d" => 0
  }
  a = Assembly.new(instructions,cpu)
  p a.execute
end
