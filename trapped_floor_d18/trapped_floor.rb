module TrappedFloor
  module_function
  
  def next(row)
    calculate_first_tile(    row) +
      calculate_middle_tiles(row) +
      calculate_last_tile(   row)
  end

  def calculate_middle_tiles(row)
    row.scan( /(.)(?=(..))/ ).map do |tiles|
      calculate_tile(tiles.join)
    end.join 
  end

  def calculate_first_tile(row)
    calculate_tile("." + row[0,2])
  end

  def calculate_last_tile(row)
    calculate_tile(row[-2,2] + "." )
  end

  def regex
    Regexp.new ["..^",".^^","^..","^^."]
      .map { |element| Regexp.escape(element) }
      .join("|")
  end

  def calculate_tile(tiles)
    if tiles =~ regex
      '^'
    else
      '.'
    end
  end
end
