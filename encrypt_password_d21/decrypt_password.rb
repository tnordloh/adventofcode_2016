class DecryptPasswored
  def initialize(string)
    @string = string
  end  

  def to_s
    string
  end
  attr_reader :string

  def swap_index(index_1,index_2)
    index_1,index_2 = [index_1,index_2].sort
    temp = string[0...index_1] + 
      string[index_2] + 
      string[index_1 + 1...index_2 ] + string[index_1] +
      string[index_2+1..-1]
    self.class.new(temp)
  end

  def swap_letter(letter_1,letter_2)
    position_1 = string.index(letter_1)
    position_2 = string.index(letter_2)
    swap_index(position_1,position_2)
  end

  def reverse(index_1, index_2)
    temp = string[0...index_1] + 
      string[index_1..index_2].reverse + 
      string[index_2+1..-1]
    self.class.new(temp)
  end

  def move(index_1,index_2)
    temp = string.chars
    temp.insert(index_1, temp.delete_at(index_2))
    self.class.new(temp.join)
  end

  def rotate(direction,amount)
    rotate_direction = (direction == "left" ? "-" : "+") + amount.to_s
    temp = string.chars.rotate(rotate_direction.to_i).join
    self.class.new(temp)
  end

  def rotate_on_position(letter)
    position = string.index(letter) + 1
    position += ( string.index(letter) <= 4 ? 1 : 0 )
    rotate("left", position)
  end

  def swap(position_1,position_2)
    if /\d/ =~ position_1 &&  /\d/ =~ position_2
      swap_index(position_1.to_i,position_2.to_i)
    else
      swap_letter( position_1, position_2 )
    end
  end
end
