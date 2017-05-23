#!/usr/bin/env ruby

require_relative 'encrypt_password'

starting_letters = 'fbgdceah'


instructions = ARGF.readlines
counter = 0
answer = starting_letters.chars.permutation.select do |attempt|
  crypt = EncryptPasswored.new(attempt.join)
  next if attempt.join == starting_letters
  counter += 1
  instructions.each do |line|
    line.chomp
    case line
    when /move position (\d+) to position (\d+)/
      _,position_1,position_2 = Regexp.last_match.to_a
      crypt = crypt.move(position_1.to_i,position_2.to_i)
    when /reverse positions (\d+) through (\d+)/ 
      _,position_1,position_2 = Regexp.last_match.to_a
      crypt = crypt.reverse(position_1.to_i,position_2.to_i)
    when /rotate (\w+) (\d+) steps?/ 
      _,direction,steps = Regexp.last_match.to_a
      crypt = crypt.rotate(direction,steps.to_i)
    when /rotate based on position of letter (.)/ 
      _,letter = Regexp.last_match.to_a
      crypt = crypt.rotate_on_position(letter)
    when /swap letter (.) with letter (.)/
      _,letter_1,letter_2 = Regexp.last_match.to_a
      crypt = crypt.swap_letter(letter_1,letter_2)
    when /swap position (\d+) with position (\d+)/
      _,position_1,position_2 = Regexp.last_match.to_a
      crypt = crypt.swap_index(position_1.to_i,position_2.to_i)
    when /.*/
      puts line
      puts "no match"
    end

  end
  puts "on attempt #{counter}"
  crypt.to_s == starting_letters
end
answer.each do |answer|
  puts answer.join
end
