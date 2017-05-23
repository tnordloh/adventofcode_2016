final_value = 1
odds = 1
1.upto(3001330) do |i|
  if i >= odds
    final_value = odds
  else
    odds = 1
  end
  odds += 2
end
puts final_value
