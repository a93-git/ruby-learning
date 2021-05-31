puts "Enter 1, 2, 3"
val = gets.chomp.to_i

case val
when 1
  puts "1"
when 2, 3
  puts "2 or 3"
else
  puts "Incorrect"
end


