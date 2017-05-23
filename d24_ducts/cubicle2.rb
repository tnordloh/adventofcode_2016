class Cubicle
  def initialize(seed, *moves)

    @seed  = seed
    @moves = moves

  end
  attr_reader :seed, :moves

  def position
    moves.last
  end

  def cell_even?(move)
    y,x = move
    seed[y][x] != "#"
  end

  def valid_position?(move)
    move.none? {|coordinate| coordinate < 0 } &&
    cell_even?(move)
  end

  def done?(cell)
    position == cell
  end

  def fill_cell(move)
    return "O" if moves.include?(move)
    y,x = move
    seed[y][x]
  end

  def max(axis)
    moves.transpose[axis].max
  end

  def upper_bound_y
    max(0)
  end

  def upper_bound_x
    max(1)
  end

  def fill_row(row)
    (0..upper_bound_x+1).map {|x| fill_cell([row,x]) }.join
  end

  ###############
  #This section was just for fun.
  #Making to_s pretty
  #
  def to_s
    "#{as_string}\nnumber of moves:#{total_moves}"
  end

#make column header print vertically, to help with spacing
  def column_header
    (0..upper_bound_x+1)
      .to_a
      .map { |num| num.to_s.rjust((upper_bound_y + 1).to_s.size,'0')}
      .map { |num| num.chars }
      .transpose
      .map { |num| num.join }
      .map { |num| num.rjust(num.size + 5," ") }
      .join("\n") + "\n"
  end

  def as_string
      (0..upper_bound_y+1).map do |row|
      "#{row.to_s.rjust(4)} #{fill_row(row)}"
    end.join("\n")
  end

  #done with fun

  def find_valid_moves
    #this part. Too "clever".  I kept trying to make it pretty.
    y,x = position
    y_values = y-1, y+1
    x_values = x-1, x+1
    ([y].product(x_values) + y_values.product([x])) 
      .select {|m|
        !moves.include?(m) &&
        valid_position?(m)
    }
  end

  def total_moves
    moves.size - 1
  end

end

class Solver
  def initialize(seed,endpoint)
    @queue = [ Cubicle.new(seed,endpoint) ]
  end

  attr_reader :moves
  attr_accessor :queue

  def find_path(cell)
    @best_path = {}
    total_moves = 0
    loop do
      current = queue.shift
      if total_moves != current.moves.size
        total_moves = current.moves.size
        #puts total_moves.to_s + " " + queue.size.to_s
      end
      if current.done?(cell)
        #        puts current.to_s
        return current.total_moves
      end
      add_paths(current)
    end
  end

  def add_paths(current)
    current.find_valid_moves.shuffle.each do |move|
      next if @best_path[move]
      c = Cubicle.new(current.seed, *current.moves , move)
      @best_path[move] = c
      queue << c
      yield move if block_given?
    end
  end

end


