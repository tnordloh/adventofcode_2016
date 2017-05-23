Elf = Struct.new(:position,:presents)
module BadElephant
  module_function

  def elves(count)
    elf_circle = Array.new(count) {|index| Elf.new(index + 1,1) } 
  end

  def find_with_math(count)
    1.upto(count).inject(1) do |final_value,val|
      val < final_value + 2 ? 1 : final_value + 2
    end
  end

  def find(count)
    elf_circle = elves(count)
    while elf_circle.size > 1
      elf_circle.first.presents += elf_circle.delete_at(1).presents
      elf_circle.rotate!
    end
    elf_circle.first.position
  end

end
