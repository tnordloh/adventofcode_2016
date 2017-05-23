FLOOR_MAP = {
  "first"   => "F1",
  "second"  => "F2",
  "third"   => "F3",
  "fourth"  => "F4",
}

module Item
  refine String do
    def microchip?
      end_with?("M")
    end
    def generator?
      end_with?("G")
    end
  end
end

module Parser
  module_function
  def abbreviate(string)
    return nil if string.match(/nothing relevant./)
    string.gsub(/-compatible/,'')
      .gsub(/microchip\.?/,'m')
      .gsub(/generator\.?/,'g')
      .gsub(/\b(.).+(.)\b/,'\1\2').upcase
    
  end

  def parse_line(line)
    p "line " + line
    floor_name = nil
    if (m = line.match(/The (?<floor>\w+) floor contains /))
      contains = m.post_match
        .split(/a | and a /)
        .select {|x| x.size  >   0 }
        .map    {|a| abbreviate(a) }
      p contains
      x =  { :floor    => FLOOR_MAP[m[1]],
             :contains => contains.compact
      }
      p x    
    else
      p "no matcho on #{line}"
    end
  end

end
class Building
  def initialize
    @elevator_location = 1
    @floors = Hash.new
  end  
  attr_reader :floors

  def fill(floor: "F1", contains: nil)
    @floors[floor] = contains
    p "floor #{floor}"
  end

  def valid_building?
    floors.keys.all? {|f| valid_floor?(f) }
  end

  def no_microchips?(floor)
    floors[floor].none? { |item| item.end_with?("M")}
  end

  def no_generators?(floor)
    floors[floor].none? { |item| item.generator? }
  end

  def all_generators_shielded?(floor)
    floors[floor].select {|item| item.generator? }
  end

  def valid_floor?(floor)
    p "looking at #{floor}"
    return true if no_microchips?(floor) 
    return true if no_generators?(floor)
  end

end
using Item

if $0 == __FILE__
  p "in it"
  b = Building.new
  ARGF.readlines.each do |line|
    p line
    floor_data = Parser.parse_line(line.chomp)
    b.fill(floor_data)
  end
  p "valid building? #{b.valid_building?}"
  
end
