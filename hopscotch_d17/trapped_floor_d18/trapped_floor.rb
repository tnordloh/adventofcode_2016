module TrappedFloor
  module_function
  
  def next(row)
    calculate_tile("." + row[0,2]) + 
    row.scan( /(.)(?=(..))/ ).map do |tiles|
      calculate_tile(tiles.join)
    end.join + 
    calculate_tile(row[-2,2] + "." )
  end

  def calculate_tile(tiles)
    if tiles =~ /\.\.\^|
                 \.\^\^|
                 \^\.\.|
                 \^\^\./x
      '^'
    else
      '.'
    end
  end
end
