module Checksum
  module_function

  def min_max(list)
    list.map(&:chars)
      .transpose
      .map { |row| letter_count(row) }
      .transpose
      .map(&:join)
  end

  def letter_count(row)
    row.sort
      .chunk_while { |i,n| i == n  }
      .minmax_by(&:size)
      .map(&:first)
  end

end

@list = ARGF.readlines.map {|row| row.chomp }

p "min_max is #{Checksum.min_max(@list).join(',')}"
