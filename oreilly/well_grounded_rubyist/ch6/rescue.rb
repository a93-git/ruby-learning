# A begin - rescue - end sample
val = gets.chomp.to_i

begin
  result = 1 / val # won't work if numerator is float
rescue
  puts "Is the number zero"
  exit
end
