# code block parameters and variables
def a_method
  a_hash = {rand(65..91).chr=> rand(101..200), rand(65..91).chr=> rand(101..200), rand(65..91).chr=> rand(101..200)}
  var1, var2 = 10, 20
  puts "Outside code block"
  puts "var1: #{var1}, var2: #{var2}"
  puts "Entering code block"
  a_hash.each do |k, v; var1, var2|
    var1, var2 = rand(1..100), rand(1..100) 
    puts "Kye: #{k}, value: #{v}, var1: #{var1}, var2: #{var2}"
  end
  puts "Outside code block"
  puts "var1: #{var1}, var2: #{var2}"
end

a_method
