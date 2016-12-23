module BlockedIps
  module_function

  def sort(ranges)
    ranges.sort { |one,two| one.min <=> two.min }
  end

  def overlap_upper_bound(ranges)
    ranges.max_by {|x| x.max }.max
  end

  def consolidate_overlaps(ranges)
    range_changed = 0
    while range_changed != ranges.size
      range_changed = ranges.size
      ranges = sort(ranges)
        .chunk_while { |first,second| first.max + 1 >= second.min }
        .map  { |overlapping_ranges| 
          (overlapping_ranges.first.min..overlap_upper_bound(overlapping_ranges))
        }
    end
    ranges
  end

  def smallest_allowed(ranges)
    consolidate_overlaps(ranges).first.max+1
  end

  def count_all_allowed(ranges)
    consolidate_overlaps(ranges)
      .each_cons(2)
      .inject(0) { |counter,(n1,n2)| (n1.max + 1...n2.min).size + counter }
  end

end
