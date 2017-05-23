require 'digest'

Movement = Struct.new(:direction,:position)

class Hopscotch
  def initialize(seed,position = 1,*moves, exclusions: [])

    @seed       = seed  
    @moves      = moves || []
    @exclusions = exclusions
    @position   = position
    @position.freeze

  end  
  attr_reader :seed, :moves, :position, :exclusions

  def find_valid_moves
    doors.select { |node| open_door?(node) }
  end

  def solved?
    position == 16
  end

  private

  def allowed?(move)
    !exclusions.join.include?(move)
  end

  def direction_open?(direction)
    mapped_direction = { "U" => 0, "D" => 1, "L" => 2, "R" => 3 }[direction]
    lock_position    = Digest::MD5.hexdigest(seed + moves.join)[mapped_direction]
    "bcdef".include?( lock_position )
  end

  def open_door?(move)
    direction_open?( move.direction ) && allowed?(move.direction)
  end

  def within_bounds?(move_spot)
    (1..16).include?(move_spot)
  end

  def right
    return nil if position % 4 == 0
    right_position = (position + 1) 
    within_bounds?(right_position) ? Movement.new("R",right_position) : nil
  end

  def left
    return nil if position % 4 == 1
    left_position = (position - 1) 
    within_bounds?(left_position) ? Movement.new("L",left_position) : nil
  end

  def up
    up_position = position - 4
    within_bounds?(up_position) ? Movement.new( "U",up_position ) : nil
  end

  def down
    down_position = position + 4
    within_bounds?(down_position) ? Movement.new( "D",down_position ) : nil
  end

  def doors
    [left,right,up,down].compact
  end
end

class Solver
  def initialize(seed)
    @seed     = seed
    @endpoint = endpoint
    @longest  = Hopscotch.new(seed)
    @queue    = Array.new.push @longest
  end

  attr_reader :longest, :seed, :endpoint, :queue

  def update_longest(entry)
    @longest = entry if entry.moves.size > longest.moves.size
  end

  def find_path
    loop do
      current = queue.shift
      return longest.moves.size if queue.size == 0 && current.nil?
      add_paths(current)
    end
  end

  def add_paths(current)
    if current.solved?
      update_longest(current)
      return
    end
    move = current.find_valid_moves.sample
    return if move == nil
    exclusion_list = [move.direction] + current.exclusions
    queue.unshift Hopscotch.new(current.seed, 
                                move.position,
                                *current.moves, move.direction)
    queue.unshift Hopscotch.new(current.seed, 
                                current.position, *current.moves,
                                exclusions: exclusion_list )
  end
end

if $0 == __FILE__
  size = Solver.new("ioramepc").find_path
  puts "longest path: #{size}"
end
