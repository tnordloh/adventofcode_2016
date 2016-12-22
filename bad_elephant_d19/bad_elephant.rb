Elf = Struct.new(:position,:presents)
module BadElephant
  module_function

  def elves(count)
    elf_circle = Array.new(count) {|index| Elf.new(index + 1,1) } 
  end

  def find_with_math(count)
    final_value = 1
    odds = 1
    1.upto(count) do |i|
      if i >= odds
        final_value = odds
      else
        odds = 1
      end
      odds += 2
    end
    final_value
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