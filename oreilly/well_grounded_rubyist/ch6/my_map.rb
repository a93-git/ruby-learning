# A map applies the code block to each element of the iterator and then returns 
# a new iterator with all the updated values

class Array
  def my_map
    array = []
    c = 0
    while c < count
      v = yield self[c]
      array << v
      c += 1
    end
    array
  end
end

b = [1, 2, 3, 4]
a = b.my_map do |n|
  n * 2 # It is important that this code block return the things we want in our map iterator
end

c = b.my_map { |n| n * 2 }

p b
p a
p c

puts b.my_map { |n| n * 2 }

# The code below will throw error because it will be interpreted ast puts(b.my_map)
# and the do/end block becomes code block for the puts method which ignores it and 
# the map method doesn't get any code block and we are not handling the error

# puts b.my_map do |n|
#   n * 2 # It is important that this code block return the things we want in our map iterator
# end

puts "Second implementation follows: "
# Here we are implementing our own version of each and then implementing map on 
# top of it
class Array
  def my_each
    puts "The self value is #{self}"
    puts "The value of count is #{count}"
    c = 0
    until c == count
      yield self[c] # simply yields each value back
      c += 1
    end
    self
  end
end

class Array
  def my_map2
    array = []
    my_each do |a|
      array << yield(a) # Different from the book, without parens throws error
    end
    array
  end
end

b = [1, 2, 3, 4, 5]
c = b.my_map2 do |z|
  z * 2
end
p c
