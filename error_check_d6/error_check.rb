module ErrorCheck
  module_function

  def sum_columns(list)
    list.transpose.each_with_object([]) do |row,memo|
      counter = Hash.new(default=0)
      row.each { |char| counter[char] += 1 }
      memo << counter
    end
  end

  def max_min(max_min, list)
    sum_columns(list)
      .map { |counter| counter.rassoc(counter.values.send(max_min))[0] }
  end

  def method_missing(m, *args)
    if m == :max || :min
      max_min(m,*args)
    else
      super
    end
  end

end

@list = ARGF.readlines.map {|row| row.chomp.chars }

e = ErrorCheck.sum_columns(@list)
p "min is #{ErrorCheck.min(@list).join}"
p "max is #{ErrorCheck.max(@list).join}"
