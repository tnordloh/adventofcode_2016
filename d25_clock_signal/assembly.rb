
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

  def execute(&block)
    counter = 0
    while instructions[position] != "EOF"
      counter += 1
      i = parse(instructions[position])
      @position = self.send(*i, &block)
    end
    cpu
  end

  def out(register)
    yield cpu[register]
    position + 1
  end

end

if $0 == __FILE__
  instructions = ARGF.readlines 
  1_000_000.times do |i|
    cpu = { 
      "a" => i,
      "b" => 0,
      "c" => 0,
      "d" => 0
    }
    a = Assembly.new(instructions,cpu)
    x = 0
    counter = 0
    do_break = false
    a.execute { |number| 
      if number == x 
        x = x == 0 ? 1 : 0
        counter += 1
        if counter > 10_000
          puts "success on #{i}" 
          do_break = true
          break 
        end
      else
        break
      end
    }
    break if do_break
  end

end
