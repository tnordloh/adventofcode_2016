
MountPoint = Struct.new(:filesystem,:size,:used,:available,:percent) {
  def to_s
    "#{filesystem} s:#{size} u:#{used} #{available}"
  end

  def pair?(other)
    return false if filesystem == other.filesystem
    return false if used == 0
    used <= other.available
  end
}

counter = 0

filesystems = ARGF.readlines.map { |line| 
  next unless line.match /\/grid/
  fields = line.split(/\s+/)
  MountPoint.new(fields[0],*fields[1..-1].map(&:to_i))
}.compact

puts "filesystems.size #{filesystems.size}"
filesystems.each { |current|
  puts "ZERO on #{current}" if current.used == 0
  counter += filesystems.count { |other|
    current.pair?(other)
  }
}
puts counter
