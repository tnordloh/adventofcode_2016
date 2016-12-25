require 'minitest/autorun'

require_relative 'decrypt_password'
describe DecryptPasswored do
  it "encrypts a password" do
    crypt = DecryptPasswored.new("decab")

    r_on_d = crypt.rotate_on_position("d")
    r_on_d.to_s.must_equal("ecabd")
#    crypt_swap_index = crypt.swap(4.to_s,0.to_s)
#    crypt_swap_index.to_s.must_equal("ebcda")
#
#    crypt_swap_letter = crypt_swap_index.swap("d","b")
#    crypt_swap_letter.to_s.must_equal("edcba")
#
#    reverse = crypt_swap_letter.reverse(0,4)
#    reverse.to_s.must_equal("abcde")
#    puts reverse.class
#
#    rotate_left = reverse.rotate("left","1")
#    rotate_left.to_s.must_equal("bcdea")
#
#    move = rotate_left.move(1,4)
#    move.to_s.must_equal("bdeac")
#    
#    move_2 = move.move(3,0)
#    move_2.to_s.must_equal("abdec")
#
#    rotate_on_position = move_2.rotate_on_position("b")
#    rotate_on_position.to_s.must_equal("ecabd")
#
  end
end
