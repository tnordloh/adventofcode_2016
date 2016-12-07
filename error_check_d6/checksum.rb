module MinMaxer
  refine Array do
    def min_max_by(&block)
      sort
        .chunk_while { |i,n| i == n  }
        .minmax_by(&block)
        .map(&:first)
    end
  end
end

module NoiseFilter
  module_function
  using MinMaxer

  def filter(list)
    list.map(&:chars)
      .transpose
      .map {|row| row.min_max_by(&:size) }
      .transpose
      .map(&:join)
  end
end

@noisy_data = ARGF.readlines.map {|row| row.chomp }
p "min_max is #{NoiseFilter.filter(@noisy_data).join(',')}"
