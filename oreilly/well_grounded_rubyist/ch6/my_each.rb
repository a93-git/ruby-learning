# each method yields each of the elements of the iterator to the code block

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

a = [1, 2, 3, 4]
b = a.my_each do |n|
  puts n * 2
end

puts "Return value is: #{b}"
