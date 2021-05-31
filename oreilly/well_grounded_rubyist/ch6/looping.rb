count = 0

loop do
  count += 1
  puts "Looping #{count} times"
  break if count >= 5
end

puts
count = 0

loop do
  count += 1
  puts "Looping #{count} times"
  next unless count >= 5
  break
end
