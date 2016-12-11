module Decompress

  def self.decompress(compressed)
    full_match, pre, letter_count, multiplier =  
      compressed.match( /(\w*)\((\d+)x(\d+)\)/ ).to_a
    return compressed if full_match.nil?
    letter_count = letter_count.to_i
    multiplier = multiplier.to_i
    expand_start = full_match.size
    expand_end = full_match.size + letter_count
    compressed_section = compressed[expand_start...expand_end]
    uncompressed_section =  compressed_section * multiplier
    remainder = compressed[expand_end..-1]
    "remainder #{remainder}"
    pre + uncompressed_section + self.decompress(remainder || "")
  end
  
end

if $0 == __FILE__
  ARGF.each do |line|
    puts Decompress.decompress(line.chomp)
    puts Decompress.decompress(line.chomp).size
  end
end
