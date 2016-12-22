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
        steal_from = elf_circle.size / 2
        elf_circle.first.presents += elf_circle[steal_from].presents
        elf_circle.delete_at(steal_from)
        elf_circle.rotate!
    end
    elf_circle.first.position
  end

end
