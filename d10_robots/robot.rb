class Output
  def initialize(id)
    @id = id
    @values = []
  end  
  attr_accessor :id, :values
  def add_value(value)
    @values << value
  end
  def to_s
    "output, with values #{@values.join(",")}"
  end
end

class Bot
  def initialize(id)
    @id = id
    @values = []
  end  

  attr_accessor :high_robot,:low_robot
  attr_reader   :low_robot, :high_robot,:values, :id


  def add_value(value)
    @values << value
    @values.sort!
    if @values.size == 2 && @values[0] == 17 && values[1] == 61
      puts "found the comparator, it is #{@id}"
    end
  end

  def execute
    if @values.size == 2 
      low_robot.add_value(@values.shift)
      high_robot.add_value(@values.shift)
      @values = []
    end
  end

  def to_s
    low  = low_robot.nil?  ? "no left:"  : "#{low_robot.id}"
    high = high_robot.nil? ? "no right:" : "#{high_robot.id}"
    "#{low},#{id},#{high}, values #{values.join(",")}"
  end

end


def parse_children(order,bot_list,s)
  r = /bot \s (\d+) \s gives \s low \s to \s 
      (bot|output) \s (\d+) \s and \s high \s to \s 
      (bot|output) \s (\d+)/x
  m = s.match(r)
  return false if m.nil?
  bot = m[1].to_i
  order << bot
  if m[2] == "output"
    p "making low output" if bot == 44
    low_bot = m[3].to_i 
    bot_list[bot].low_robot = Output.new(low_bot)
  end
  if m[2] == "bot"
    low_bot = m[3].to_i 
    bot_list[bot].low_robot = bot_list[low_bot]
  end
  if m[4] == "output"
    high_bot = m[5].to_i 
    bot_list[bot].high_robot = Output.new(low_bot)
  end
  if m[4] == "bot"
    high_bot = m[5].to_i 
    bot_list[bot].high_robot = bot_list[high_bot]
  end
end

def parse_inserts(bot_list,s)
  r = /value (\d+) goes to bot (\d+)/
  m = s.match(r)
  return false if m.nil?
  value,bot = m[1,2].map(&:to_i)
  bot_list[bot].add_value(value)
end

x = File.readlines('input')
@bot_list = Hash.new {|hash,val| hash[val] = Bot.new(val) } 
@order = []
x.each do |line|
  parse_children(@order,@bot_list,line.chomp) ||
    parse_inserts(@bot_list,line.chomp)
end

loop do
  @order.each do |o|
    @bot_list[o].execute
    if @bot_list[29].low_robot.values.size > 0 &&
        @bot_list[50].low_robot.values.size > 0 &&
        @bot_list[53].low_robot.values.size > 0
      p "output 0 + 1 + 2"
      p @bot_list[29].low_robot.values.first *
        @bot_list[50].low_robot.values.first *
        @bot_list[53].low_robot.values.first
      exit

    end
  end
end
