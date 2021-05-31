class A
  attr_accessor :val

  def ===(other)
    puts "Yooohoooo"
    true if val == other.val
  end
end

o = A.new
o.val = 5

o2 = A.new
o2.val = 5

o3 = A.new
o3.val = 6

case o
when o2
 puts "What!!!"
else 
  puts "No match"
end

puts "Something"

case o3
when o2
 puts "What is this!!!"
else 
  puts "No match"
end

# Testless case statement
case
when "a" === "b"
  puts "What is this sorcery?"
when 1 === 2
  puts "What is going on here?"
else
  puts "What a beautiful life!"
end
