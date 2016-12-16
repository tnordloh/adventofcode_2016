require 'digest'

module OneTimePad
  module_function
  @@key_list = []
  
  def key(salt)
    Digest::MD5.hexdigest(salt)
  end

  def validate_key(key,salt)
  end

  def each(salt,pattern,start = 0,stop = Float::INFINITY)
    p start
    p stop
    p pattern
    @index = (start..stop)
    @index.each do |index|

      potential_key = @@key_list[index] || key("#{salt}#{index}")

      if match_info = potential_key.match(pattern)
        yield Keystore.new( potential_key, index, match_info[1] )
      end

    end
  end

end


Keystore = Struct.new(:key,:index,:pattern_match)
  
def valid_key?(salt,key)
  p "valid key?"
  p key
  p key.pattern_match
  OneTimePad.each(salt,/(#{key.pattern_match}){5}/,key.index+1,key.index+1000) {|k|
    p "in valid_key"
    return k.index < key.index+1000
  }
  return false
end

list = Hash.new
salt = ARGV[0]
potential_key = OneTimePad.key("#{salt}#{816}")
def max(list)
end
OneTimePad.each(salt,/([a-f0-9])\1\1/) { |key|
  puts key
  list[key.index] = key if  valid_key?(salt,key)
  if list.size == 64
    puts  list 
    puts list.keys.max
    break
  end
}

