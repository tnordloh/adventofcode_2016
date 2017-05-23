module Decompress

  def self.count(compressed)
    full_match, pre, letter_count, multiplier =  
      compressed.match( /(\w*)\((\d+)x(\d+)\)/ ).to_a
    return compressed.size if full_match.nil?
    p full_match
    letter_count = letter_count.to_i
    multiplier = multiplier.to_i
    expand_start = full_match.size
    expand_end = full_match.size + letter_count
    compressed_section = compressed[expand_start...expand_end]
    remainder = compressed[expand_end..-1]
    "remainder #{remainder}"
    pre.size + 
      self.count(compressed_section) * multiplier + 
      self.count(remainder || "")
  end

  
end

if $0 == __FILE__
  ARGF.each do |line|
    puts Decompress.count(line.chomp)
  end
end
