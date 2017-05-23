require 'ostruct'
module Decompress


  DSParser = Struct.new(:compressed_string)  do
    def failed_match?
      md.nil?
    end
    def md
      @md ||= compressed_string.match( /(\w*)\((\d+)x(\d+)\)/ )
    end
    def beginning
      md[1]
    end
    def middle
      compressed_section * multiplier
    end
    def end
      md.post_match[letter_count..-1]
    end
    def letter_count
      md[2].to_i
    end
    def multiplier
      md[3].to_i
    end
    def compressed_section
      md.post_match[0,letter_count]
    end
  end

  def self.decompress(compressed)
    md = DSParser.new(compressed)
    return compressed if md.failed_match?
    md.beginning + md.middle + self.decompress(md.end)
  end
  
end

if $0 == __FILE__
  ARGF.each do |line|
    puts Decompress.decompress(line.chomp)
    puts Decompress.decompress(line.chomp).size
  end
end
