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
    (x*x + 3*x + 2*x*y + y + y*y + seed)
      .to_s(2)
      .count("1").even?
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
    cell_even?(move) ? "." : "#"
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
    column_header +
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
    loop do
      current = queue.shift
      return current.moves.size if current.done?(cell)
      add_paths(current)
    end
  end

  def add_paths(current)
    current.find_valid_moves.each do |move|
      queue << Cubicle.new(current.seed, *current.moves , move)
      yield move if block_given?
    end
  end

  def moves_within(max)
    unique_moves = { [1,1 ] => 0 }
    while queue.size > 0 do
      current = queue.shift
      if current.total_moves < max
        add_paths(current) { |move| unique_moves[move] = 0 }
      end
    end
    return unique_moves.size
  end

end


