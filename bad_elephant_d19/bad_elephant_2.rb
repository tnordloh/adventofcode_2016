Elf = Struct.new(:position,:presents)
module BadElephant
  module_function

  def elves(count)
    elf_circle = Array.new(count) {|index| Elf.new(index + 1,1) } 
  end

  def fill_marker(size = nil)
    if size == nil
      [1,1,3]
    else
      (1..size).to_a + (size+1..size*3+1).to_a.select(&:odd?)[0,size]
    end
  end

  def find_with_math(count)
    marker = fill_marker
    1.upto(count).inject(0) do |final_value,_|
      marker = marker + fill_marker(marker.last) if marker.size == 1
      marker.shift
    end
  end

  def find(count)
    elf_circle = elves(count)
    while elf_circle.size > 1
      steal_from = elf_circle.size / 2
      elf_circle.first.presents += 
        elf_circle.delete_at(steal_from).presents
      elf_circle.rotate!
    end
    elf_circle.first.position
  end

end
