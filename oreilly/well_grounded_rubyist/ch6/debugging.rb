# Debugging with binding.irb
puts "Want number:"
val = gets.chomp.to_i
binding.irb
puts "Number is: #{val}"
