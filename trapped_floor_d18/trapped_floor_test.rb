require 'minitest/autorun'

require_relative 'trapped_floor'

describe TrappedFloor do
  it "gets the next row" do

    results =   [".^^.^.^^^^",
                 '^^^...^..^',
                 '^.^^.^.^^.',
                 '..^^...^^^',
                 '.^^^^.^^.^',
                 '^^..^.^^..',
                 '^^^^..^^^.',
                 '^..^^^^.^^',
                 '.^^^..^.^^',
                 '^^.^^^..^^' ]
    row = results[0]
    counter = 0
    10.times do |i|
      counter += row.count('.')
      row.must_equal(results[i])
      row = TrappedFloor.next(row)
    end
    counter.must_equal(38)

    
  end
end

