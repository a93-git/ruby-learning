require_relative "stacklike"

class Stack
  include Stacklike # Mixing in the Stacklike module
end

s = Stack.new
puts "Objects currently on the stack: "
puts s.stack
s.add_to_stack("one")
s.add_to_stack("two")
s.add_to_stack("three")

puts "Objects currently on the stack: "
puts s.stack

taken = s.take_from_stack
puts "Removed this object: "
puts taken
puts "Now on stack: "
puts s.stack

