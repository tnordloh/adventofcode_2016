module Checksum
  module_function

  def sum_columns(list)
    list
      .map {|row| row.chars}
      .transpose
      .map  { |row| letter_count(row) }
      .transpose
      .map(&:join)
  end


  def letter_count(row)
    row
      .sort
      .chunk_while { |i,n| i == n }
      .minmax_by {|c| c.size }
      .map {|x| x.first }
  end

  def min_max(list)
    sum_columns(list)
  end

end

@list = ARGF.readlines.map {|row| row.chomp }

#p "min is #{ErrorCheck.min(@list).join}"
#p "max is #{ErrorCheck.max(@list).join}"
p "min_max is #{Checksum.min_max(@list).join(',')}"
