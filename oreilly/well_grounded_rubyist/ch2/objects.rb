obj = Object.new

def obj.talk
  puts "I am an object."
  puts "Do you object?"
end

def obj.var(*x)
  x.each { |detail| puts "The ticket is #{detail}" }
end

obj.talk
obj.var("blah", "second blah", "third blah")
