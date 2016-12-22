Elf = Struct.new(:position,:presents)
module BadElephant
  module_function

  def elves(count)
    elf_circle = Array.new(count) {|index| Elf.new(index + 1,1) } 
  end

  def fill_marker(size)
    (1..size).to_a + (size+1..size*3+1).to_a.select(&:odd?)[0,size]
  end

  def find_with_math(count)
    marker = [1,1,3]
    sizer = marker.size
    final_value = 1
    1.upto(count) do |i|
      if marker.empty?
        marker = fill_marker(sizer)
        sizer  = marker.last
      end
      final_value = marker.shift
    end
    final_value
  end

  def find(count)
    elf_circle = elves(count)
    while elf_circle.size > 1
      steal_from = elf_circle.size / 2
      elf_circle.first.presents += elf_circle[steal_from].presents
      elf_circle.delete_at(steal_from)
      elf_circle.rotate!
    end
    elf_circle.first.position
  end

end
