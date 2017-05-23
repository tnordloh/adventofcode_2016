Elf = Struct.new(:position,:presents)
module BadElephant
  module_function

  def elves(count)
    elf_circle = Array.new(count) {|index| Elf.new(index + 1,1) } 
  end

  def find(count)
    (count - 2**(Math.log2(count).to_i)) * 2 + 1
  end

end
