
NODE_MAP = {
1  =>  {"R" => 2,  "D" => 5 },
2  =>  {"L" => 1,  "R" => 3,  "D" => 6  },
3  =>  {"L" => 2,  "R" => 4,  "D" => 7  },
4  =>  {"L" => 3,             "D" => 8  },
5  =>  {           "R" => 6,  "D" => 9 , "U" => 1   },
6  =>  {"L" => 5,  "R" => 7,  "D" => 10, "U" => 2  },
7  =>  {"L" => 6,  "R" => 8,  "D" => 11, "U" => 3   },
8  =>  {"L" => 7,             "D" => 12, "U" => 4   },
9  =>  {           "R" => 10, "D" => 13, "U" => 5  },
10 =>  {"L" => 9,  "R" => 11, "D" => 14, "U" => 6   },
11 =>  {"L" => 10, "R" => 12, "D" => 15, "U" => 7   },
12 =>  {"L" => 11,            "D" => 16, "U" => 8   },
13 =>  {"L" => 12, "R" => 14, "U" => 9   },
14 =>  {"L" => 13, "R" => 15, "U" => 10  },
15 =>  {"L" => 14, "R" => 16, "U" => 11  },
16 =>  {"L" => 15,            "U" => 12  },
}
DIRECTION_MAP = { "U" => 0,
                  "D" => 1,
                  "L" => 2,
                  "R" => 3,
}

require 'digest'

class Hopscotch
  def initialize(seed,position,*moves)

    @seed     = seed  
    @moves    = moves || []
    @position = position

  end  
  attr_reader :seed, :moves, :position

  def valid_position?(move)
    door?(move) && open?(move)
  end

  def hash
    p seed + moves.join
    p Digest::MD5.hexdigest(seed + moves.join)
  end

  def door?(move)
    NODE_MAP[position].values.include?(move)
  end

  def open?(move)
    direction = NODE_MAP[position].rassoc(move)[0]
    "bcdef".include? hash[ DIRECTION_MAP[ direction ] ]
  end

  def done?
    position == 16
  end

  def find_valid_moves
    NODE_MAP[position].each.select  {|node,value|
      p "#{node}  xxxx  #{value}" if open?(value)
      p open?(value)
    }
  end

end
class Solver
  def initialize(seed,endpoint)
    @queue = [ Hopscotch.new(seed,endpoint) ]
  end

  attr_reader :moves
  attr_accessor :queue

  def find_path
    loop do
      current = queue.shift
      p current
      puts "queue size #{queue.size}"
      return current.moves.join if current.done?
      add_paths(current)
    end
  end

  def add_paths(current)
    current.find_valid_moves.each do |move|
      puts "new with #{move}"
      queue << Hopscotch.new(current.seed, move[1],*current.moves , move[0])
      yield move if block_given?
    end
  end

end



if $0 == __FILE__
  hop = Hopscotch.new('hijkl',1)
  p hop.door?(2)
  p hop.door?(3)
  p "open?"
  p hop.open?(2)
  p hop.open?(5)
  p hop.find_valid_moves
#  s = Solver.new("ihgpwlah",1)
#  path = s.find_path
#  puts path
  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  s = Solver.new("ioramepc",1)
  path = s.find_path
  puts path
end
