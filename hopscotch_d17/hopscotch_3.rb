require 'digest'

Movement = Struct.new(:direction,:position)

class Hopscotch
  DIRECTION_MAP = { "U" => 0,
                    "D" => 1,
                    "L" => 2,
                    "R" => 3,
  }
  def initialize(seed,position = 1,*moves, exclusions: [])

    @seed       = seed  
    @moves      = moves || []
    @exclusions = exclusions
    @position   = position
    @position.freeze

  end  
  attr_reader :seed, :moves, :position, :exclusions


  def find_valid_moves
    doors.select  {|node| open_door?(node) }
  end

  def allowed?(move)
    !exclusions
      .join
      .include?(move)
  end


  def hash
    Digest::MD5.hexdigest(seed + moves.join)
  end



  def open_door?(move)
    "bcdef".include?( hash[ DIRECTION_MAP[ move.direction ]  ] ) && 
      allowed?(move.direction)
  end

  def solved?
    position == 16
  end

  def within_bounds?(move_spot)
    (1..16).include?(move_spot)
  end

  def right
    right_position = (position + 1) 
    if within_bounds?(right_position) && right_position % 4 != 1
      Movement.new("R",right_position)
    else
      nil
    end
  end

  def left
    left_position = (position - 1) 
    if within_bounds?(left_position) && left_position % 4 != 0
      Movement.new("L",left_position)
    else
      nil
    end
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
    @longest = Hopscotch.new(seed)
    @queue   = Array.new.push @longest
  end

  attr_reader :longest, :seed, :endpoint, :queue

  def update_longest(entry)
    if entry.moves.size > longest.moves.size
      @longest= entry 
    end

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
    queue.unshift Hopscotch.new(current.seed, move.position ,*current.moves , move.direction)
    queue.unshift Hopscotch.new(current.seed, 
                                current.position ,*current.moves,
                                exclusions: exclusion_list )
  end

end



if $0 == __FILE__
  hop = Hopscotch.new('hijkl',1)
  p hop.find_valid_moves
  #  s = Solver.new("ihgpwlah",1)
  #  path = s.find_path
  #  puts path
  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  s = Solver.new("ioramepc")
  size = s.find_path
  puts "longest path: #{size}"
end
