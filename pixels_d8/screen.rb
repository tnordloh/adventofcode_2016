class Screen
  def initialize(x,y)

    @screen = create(x,y)

  end  
  attr_accessor :initial_screen

  def create(x,y)
    y.times.map  { 
      Array.new(x,default=".")
    }
  end

  def fill(x_size,y_size)
    x_size.times { |x| 
      y_size.times { |y| 
        @screen[y][x] = "#"
      }
    } 
    @screen 
  end

  def rotate_x(column,amount)
    tp = @screen.transpose
    tp[column] = tp[column].rotate((amount * -1))
    @screen = tp.transpose
  end

  def rotate_y(row,amount)
    @screen[row] = @screen[row].rotate((amount * -1))
  end
    
  def to_s
    @screen.map(&:join).join("\n")
  end

  def refresh(text)
    if text.start_with?("rotate row")
      parsed = text.split(/\s+/)
      axis,address = parsed[2].split("=")
      amount = parsed[4].to_i
      rotate_y(address.to_i,amount)
    elsif text.start_with?("rotate column")
      parsed = text.split(/\s+/)
      axis,address = parsed[2].split("=")
      amount = parsed[4].to_i
      rotate_x(address.to_i,amount)
    elsif text.start_with?("rect")
      parsed = text.split(/\s+/)
      x,y = parsed[1].split('x')
      fill(x.to_i,y.to_i)
    end
  end

  def count_hashes
    @screen.flatten.count {|x| x == "#"}
  end

end

if $0 == __FILE__
  input = ARGF.readlines
  s = Screen.new(50,6)
  input.each do |instruction|
    p instruction
    s.refresh(instruction.chomp)
    puts s.to_s
  end
  p s.count_hashes
end
