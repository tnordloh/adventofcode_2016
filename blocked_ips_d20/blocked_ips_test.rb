require 'minitest/autorun'

require_relative 'blocked_ips'
describe BlockedIps do
  def setup
    @list = [(5..8),(0..2),(4..7)]
    
  end
  it "sorts a list of ranges" do
    @list = [(5..8),(0..2),(4..7)]
    BlockedIps.sort(*@list).must_equal([(0..2),(4..7),(5..8)])
  end

  it "consolidates ranges" do
    BlockedIps.fix_overlaps(*@list).must_equal([(0..2),(4..8)])
  end

  it "solves the problem" do
    BlockedIps.solve(*@list).must_equal(3)
  end

  it "sorts a list of ranges" do
    puts "list of ranges"
    list = [(0..8),(0..2),(4..7)]
    BlockedIps.fix_overlaps(*list).must_equal([(0..8)])
  end

end
