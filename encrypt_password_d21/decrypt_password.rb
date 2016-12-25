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
    move(index_1,index_2).move(index_2,index_1)
  end

  def swap_letter(letter_1,letter_2)
    position_1 = string.index(letter_1)
    position_2 = string.index(letter_2)
    swap_index(position_1,position_2)
  end

  def reverse(index_1, index_2)
    beginning = string[0...index_1]
    middle    = string[index_1..index_2].reverse
    ending    = string[index_2+1..-1]
    self.class.new("#{beginning}#{middle}#{ending}")
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

end
