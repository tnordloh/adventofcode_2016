module ErrorCheck
  module_function

  def sum_columns(list)
    list.transpose.each_with_object([]) do |row,memo|
      counter = Hash.new(default=0)
      row.each { |char| counter[char] += 1 }
      memo << counter
    end
  end

  def min(list)
    counters = sum_columns(list)
    counters.map { |counter| counter.rassoc(counter.values.min)[0] }
  end

  def max(list)
    counters = sum_columns(list)
    counters.map do |counter|
      counter.rassoc(counter.values.max)[0]
    end
  end

end

@list = ARGF.readlines.map {|row| row.chomp.chars }

e = ErrorCheck.sum_columns(@list)
p "min is #{ErrorCheck.min(@list).join}"
p "max is #{ErrorCheck.max(@list).join}"
