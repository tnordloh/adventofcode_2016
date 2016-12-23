module BlockedIps
  module_function

  def sort(*ranges)
    ranges.sort { |one,two| one.min <=> two.min }
  end

  def fix_overlaps(*ranges)
    count = 0
    while count != ranges.size
      count = ranges.size
      ranges = sort(*ranges)
      .chunk_while { |first,second| first.max + 1 >= second.min }
      .map  { |overlapping_ranges| 
        puts "overlapping_ranges #{overlapping_ranges}"
        highest = overlapping_ranges.max_by {|x| x.max }.max
        (overlapping_ranges.first.min..highest)
      }
    end
    ranges
  end

  def solve(*ranges)
    fix_overlaps(*ranges).first.max+1


  end
end
