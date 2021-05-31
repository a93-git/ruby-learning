n = 0

puts "Beginning while loop"
while (n < 5)
  n += 1
  puts n
end

puts "Beginning begin while loop"
begin
  n += 1
  puts n
end while (n < 10)

puts "Beginning until loop"
until (n >= 15)
  n += 1
  puts n
end

puts "Beginning begin until loop"
begin
  n += 1
  puts n
end until (n >= 20)
