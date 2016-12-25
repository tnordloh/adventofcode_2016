class EncryptPasswored
  def initialize(string)
    @string = string
  end  

  def to_s
    string
  end
  attr_reader :string

  def swap_index(index_1,index_2)
    swap_letter(string[index_1],string[index_2])
  end

  def swap_letter(letter_1,letter_2)
    tr_value = string[letter_1] + string[letter_2]
    self.class.new(string.tr(tr_value,tr_value.reverse))
  end

  def reverse(index_1, index_2)
    reverse_section = string[index_1..index_2]
    self.class.new(string.tr(reverse_section,reverse_section.reverse))
  end

  def move(index_1,index_2)
    temp = string.chars
    temp.insert(index_2, temp.delete_at(index_1))
    self.class.new(temp.join)
  end

  def rotate(direction,amount)
    rotate_direction = (direction == "left" ? "+" : "-") + amount.to_s
    temp = string.chars.rotate(rotate_direction.to_i).join
    self.class.new(temp)
  end

  def rotate_on_position(letter)
    position = string.index(letter) + 1 + ( string.index(letter) >= 4 ? 1 : 0 )
    rotate("right", position)
  end

end
