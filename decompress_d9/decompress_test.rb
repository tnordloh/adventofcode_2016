
require 'minitest/autorun'

require_relative 'decompress'

describe Decompress do
  it "decrypts a string" do
    Decompress.decompress("A(1x5)BC").must_equal("ABBBBBC")
    Decompress.decompress("A(2x2)BCD(2x2)EFG").must_equal("ABCBCDEFEFG")
    Decompress.decompress("(6x1)(1x3)A").must_equal("(1x3)A")
    Decompress.decompress("X(8x2)(3x3)ABCY").must_equal("X(3x3)ABC(3x3)ABCY")
  end
end
