module ErrorCheck
  module_function

  def sum_columns(list)
    list.transpose.each_with_object([]) do |row,memo|
      memo << letter_count(row)
    end
  end

  def letter_count(row)
    row.each_with_object(Hash.new(default=0)) { |char,counter|
      counter[char] += 1 
    }
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
