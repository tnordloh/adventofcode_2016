Elf = Struct.new(:position,:presents)
module BadElephant
  module_function

  def elves(count)
    elf_circle = Array.new(count) {|index| Elf.new(index + 1,1) } 
  end

  def find(count)
    elf_circle = elves(count)
    while elf_circle.size > 1
      puts "size #{elf_circle.size}" if elf_circle.size % 10_000 == 0
      if elf_circle.first.presents > 0
        elf_circle.first.presents += elf_circle[1].presents
        elf_circle[1].presents = 0
        elf_circle.rotate!
      else
        elf_circle.shift
      end
    end
    elf_circle.first.position
  end

end
