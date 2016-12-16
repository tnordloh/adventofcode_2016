require 'digest'

class OneTimePad
  def initialize
    
    @@key_list = []
  end
  
  def key(salt)
    r_v = Digest::MD5.hexdigest(salt)
    2016.times do 
      r_v = Digest::MD5.hexdigest(r_v)
    end
    r_v
  end

  def validate_key(key,salt)
  end

  def each(salt,pattern,start = 0,stop = Float::INFINITY)
    p start
    p stop
    @index = (start..stop)
    @index.each do |index|

      potential_key = @@key_list[index] || key("#{salt}#{index}")
      @@key_list[index] = potential_key

      if match_info = potential_key.match(pattern)
        yield Keystore.new( potential_key, index, match_info[1] )
      end


    end
  end

end


Keystore = Struct.new(:key,:index,:pattern_match)
  
@pad = OneTimePad.new
def valid_key?(salt,key)
  p "valid key?"
  p key
  @pad.each(salt,/(#{key.pattern_match}){5}/,key.index+1,key.index+1000) {|k|
    p "in valid_key"
    return k.index < key.index+1000
  }
  return false
end

list = Hash.new
salt = ARGV[0]
potential_key = @pad.key("#{salt}#{816}")
def max(list)
end
@pad.each(salt,/([a-f0-9])\1\1/) { |key|
  puts key
  list[key.index] = key if  valid_key?(salt,key)
  puts "we have #{list.size} keys so far"
  if list.size == 64
    puts  list 
    puts list.keys.max
    break
  end
}

