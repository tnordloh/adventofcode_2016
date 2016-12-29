require 'io/console'
MountPoint = Struct.new(:filesystem,:size,:used,:available,:percent) {
  def to_s
    "x #{x} #{filesystem} u:#{used} a:#{available}"
  end

  def to_char
    if used == 72 && y == 0 
      "G"
    elsif used == 0
      "_"
    elsif used < 80
      "."
    else
      "#"
    end
  end

  def pair?(other)
    return false if filesystem == other.filesystem
    return false if used == 0
    used <= other.available
  end

  def y
    filesystem.match( /y(\d+)/).to_a[1].to_i
  end

  def x
    filesystem.match( /x(\d+)/).to_a[1].to_i
  end
}

class Map
  def initialize(map)

    @map = map

  end  
  attr_reader :map

  def neighbors(cell)
    [
      [cell.y,cell.x-1],[cell.y,cell.x+1],
      [cell.y-1,cell.x],[cell.y+1,cell.x]
    ].select {|values| values[0] >= 0 &&
                       values[0] < map.size && 
                       values[1] >= 0 &&
                       values[1] < map[0].size
    }.map { |values| 
      map[values[0]][values[1]]
    }
     
  end

  def can_move?(cell)
    neighbors(cell).any? { |neighbor|
      cell.used < neighbor.available
    }
    
  end

  def to_s
    map.each { |y_row|
      puts y_row.map {|cell| 
        cell.to_char
      }.join
    }
  end

  def empty_cell
    map.flatten.find {|cell| cell.used == 0}
  end

  def move_empty_cell(direction)
    destination = map[empty_cell.y][empty_cell.x-1]
    if direction == 'h'
      destination = map[empty_cell.y][empty_cell.x-1]
    elsif direction == 'j'
      destination = map[empty_cell.y+1][empty_cell.x]
    elsif direction == 'k'
      destination = map[empty_cell.y-1][empty_cell.x]
    elsif  direction == 'l'
      destination = map[empty_cell.y][empty_cell.x+1]
    else
      return 0
    end
    puts "empty cell is #{empty_cell}"
    empty = empty_cell
    puts "destination is #{destination}"
    return 0 if empty.available < destination.used
    empty.used = destination.used
    destination.used = 0
    destination.available = destination.size
    return 1
  end

end

counter = 0

filesystems = ARGF.readlines.map { |line| 
  next unless line.match /\/grid/
  fields = line.split(/\s+/)
  MountPoint.new(fields[0],*fields[1..-1].map(&:to_i))
}.compact

y_max = filesystems.max { |f| f.y }.y + 1
x_max = filesystems.max { |f| f.x }.x + 1
grid = Array.new(y_max) {  Array.new(x_max) }

filesystems.each {|f|
  grid[f.y][f.x] = f
}

m = Map.new(grid)

puts "#{m}"
count = 0
while x = STDIN.getch
  break if x == "q"
  count += m.move_empty_cell(x)
  puts "#{m}"
  puts "empty cell #{m.empty_cell}"
  m.neighbors(m.empty_cell).each { |neighbor|
    puts neighbor
  }
  puts "moves so far: #{count}"
end
