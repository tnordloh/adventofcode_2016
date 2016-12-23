module BlockedIps
  module_function

  def sort(ranges)
    ranges.sort { |one,two| one.min <=> two.min }
  end

  def fix_overlaps(ranges)
    count = 0
    while count != ranges.size
      count = ranges.size
      ranges = sort(ranges)
      .chunk_while { |first,second| first.max + 1 >= second.min }
      .map  { |overlapping_ranges| 
        highest = overlapping_ranges.max_by {|x| x.max }.max
        (overlapping_ranges.first.min..highest)
      }
    end
    ranges
  end

  def smallest_allowed(ranges)
    fix_overlaps(ranges).first.max+1
  end

  def count_all_allowed(ranges)
    counter = 0
    fix_overlaps(ranges).inject() {|n,n1|
      counter += (n.max + 1...n1.min).size
      puts "n #{n}, n1 #{n1}, counter #{counter}"
      n1
    }
    counter
  end

end
