#!/usr/bin/env ruby

require_relative 'encrypt_password'

crypt = EncryptPasswored.new('fbgdceah')

ARGF.readlines.reverse.each do |line|
  line.chomp
  puts line
  case line
  when /move position (\d+) to position (\d+)/
    _,position_1,position_2 = Regexp.last_match.to_a
    p crypt = crypt.move(position_1.to_i,position_2.to_i)
  when /reverse positions (\d+) through (\d+)/ 
    _,position_1,position_2 = Regexp.last_match.to_a
    p crypt = crypt.reverse(position_1.to_i,position_2.to_i)
  when /rotate (\w+) (\d+) steps?/ 
    _,direction,steps = Regexp.last_match.to_a
    p crypt = crypt.rotate(direction,steps.to_i)
  when /rotate based on position of letter (.)/ 
    _,letter = Regexp.last_match.to_a
    p crypt = crypt.rotate_on_position(letter)
  when /swap letter (.) with letter (.)/
    _,letter_1,letter_2 = Regexp.last_match.to_a
    p crypt = crypt.swap_letter(letter_1,letter_2)
  when /swap position (\d+) with position (\d+)/
    _,position_1,position_2 = Regexp.last_match.to_a
    p crypt = crypt.swap_index(position_1.to_i,position_2.to_i)
  when /.*/
    puts line
    puts "no match"
  end

end
puts crypt
