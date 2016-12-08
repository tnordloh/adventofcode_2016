module TLSFinder

  module_function 

  def abba(ip_address)
    ip_address.scan(/(.(?=(.{3})))/)
      .map(&:join)
      .uniq
      .select {|x| x[0] == x[3] && x[1] == x[2] && x[0] != x[1] }
  end

  def supernet(ip_address)
    ip_address
      .split(/\[|\]/)
      .select.each_with_index { |_, i| i.even? }
      .join("    ")
 end

  def hypernet(ip_address)
    ip_address
      .split(/(?:\[|\])/)
      .select.each_with_index { |_, i| i.odd? }
      .join("     ")
  end

  def pair_in_braces?(ip_address)
      find_pair(hypernet(ip_address))
  end

  def aba_to_bab(aba)
    aba[1] + aba[0] + aba[1]
  end

  def bab?(ip_address)
    aba_converted = aba_bab(supernet(ip_address))
      .map {|e| aba_to_bab(e)}
    my_bab = aba_bab(hypernet(ip_address))
    aba_converted
    my_bab
    (my_bab & aba_converted )
    (my_bab & aba_converted ).size > 0
  end

  def aba_bab(ip_address)
  #  x[0] == x[2] && x[0] != x[1] }
    ip_address.scan(/(.(?=(..)))/)
      .map(&:join)
      .uniq
      .select {|x| x.match(/(.)(?!\1).\1/) }
  end

  def aba_matches(ip_address)
    aba_bab(supernet(ip_address))
  end

  def ssl?(ip_address)
    bab?(ip_address)
  end

  def tls?(ip_address)
    abba(supernet(ip_address)).size > 0  &&
      abba(hypernet(ip_address)).size == 0 
  end
end


@input = ARGF.readlines
output =  @input.count do |address|
   TLSFinder.tls?(address.chomp)
end
p output

output = @input.count do |address|
  TLSFinder.ssl?(address.chomp)
end


puts output
