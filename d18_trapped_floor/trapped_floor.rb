module TrappedFloor
  module_function
  
  def next(row)
      calculate_middle_tiles(add_wall + row + add_wall)
  end

  def add_wall
    "."
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
