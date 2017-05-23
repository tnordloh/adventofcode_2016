module ErrorCheck
  def initialize(list)
    @list = list.map {|row| row.chomp.chars }
  end  
  attr_reader :list


  def sum_columns(list)
    @list.transpose.map do |row|
      counter = Hash.new(default=0)
      row.each { |char| counter[char] += 1 }
    end
  end

  def get_max(list)
    counter = sum_columns(list)
    counter.rassoc(counter.values.min)[0]
  end

  def get_max(list)
    counter = sum_columns(list)
    counter.rassoc(counter.values.max)[0]
  end

end

@list = ARGF.readlines.map {|row| row.chomp.chars }
e = ErrorCheck.sum_columns(ARGF.readlines)
p e
#p e.sum_columns.join
