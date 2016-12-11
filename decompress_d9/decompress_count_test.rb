
require 'minitest/autorun'

require_relative 'decompress_count'

describe Decompress do
  it "decrypts a string" do
    Decompress.count("(3x3)XYZ").must_equal(9)
    Decompress.count("X(8x2)(3x3)ABCY")
      .must_equal("XABCABCABCABCABCABCY".size)
  end
end
