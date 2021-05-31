# times is an instance method of Integer class that yields control to the code 
# block n number of times with the current iteration count where n is the integer

class Integer
  def my_times
    puts "The value of self is #{self}"
    c = 0
    until c == 5
      yield c
      c += 1
    end
  end
end

5.my_times do |i|
  puts i
end

puts

puts "Second implementation using my_each follows"

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

class Integer
  def my_times
    (0..self-1).to_a.my_each { |i| yield i }
  end
end

5.my_times do |i|
  puts "I am on #{i}"
end
