require 'digest'
require 'yaml/store'

module OneTimePad
  module_function
  @@key_list = []
  @@fives = Hash.new(default = [])
  
  def key(salt)
    r_v = Digest::MD5.hexdigest(salt)
    2016.times do 
      r_v = Digest::MD5.hexdigest(r_v)
    end
    r_v
  end


  def each(salt,size,start = 0,stop = Float::INFINITY,pstore: nil)
    @index = (start..stop)
    @index.each do |index|
      p size
      p index
      potential_key = key("#{salt}#{index}")
      biggest_sequence = potential_key
        .chars
        .chunk_while {|b,c|b == c }
        .map(&:join)
        .max_by(&:size)

  puts potential_key
      puts "biggest sequence is #{biggest_sequence}"

      if biggest_sequence.size >= size
        yield Keystore.new( potential_key, index, biggest_sequence[0] )
      end

    end
  end

end


Keystore = Struct.new(:key,:index,:pattern_match)
fives = Hash.new(default = []) 
salt = ARGV[0]
@pstore ||= YAML::Store.new("#{salt}2017.yaml")

def find_fives(salt,pattern_at,start)
  OneTimePad.each(salt,5,start,30000) {|k|
    p "inserting #{k}"
    pattern_at[k.pattern_match] = pattern_at[k.pattern_match] << k
    @pstore.transaction do
      @pstore[:fives] = pattern_at
    end
  }
  pattern_at
end
fives = fives.merge(  @pstore.transaction { @pstore[:fives] }  || Hash.new)


puts fives
puts "-------"
highest = 30000
fives = find_fives(salt,fives,highest)


def valid_key?(fives,key)
  puts "validating #{key}"
  return false if fives[key.pattern_match] == nil
  fives[key.pattern_match].any? {|k|
    p (key.index+1..key.index+1000)
    if (key.index+1..key.index+1000).include?(k.index)
      p "matched #{k}"
      fives[key.pattern_match].delete!(k)
    end
    (key.index+1..key.index+1000).include?(k.index)
  }
end


list = Hash.new

puts "starting threes"
OneTimePad.each(salt,3) { |key|
  puts "found this #{key}"
  if  valid_key?(fives,key)
    list[key.index] = key
    p "found one! we now have #{list.size} keys"
    p key
    p list
    p list.size
  end
  if list.size == 64
    puts  list 
    puts list.keys.max
    break
  end
}

