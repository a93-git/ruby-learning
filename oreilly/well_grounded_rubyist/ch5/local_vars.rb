puts "At the top level"
a = 1
puts "Value of top level local var a is #{a}"

def t
  a = 7
  puts "Inside top level function"
  puts "Accessing top level local var 'a': #{a}"
end

class A
  puts "Class definition starts"
  a = 2
  puts "Value of class local variable a is #{a}"

  module M
    puts "Module definition starts"
    a = 3
    puts "Value of module local variable a is #{a}"

    def m
      puts "Inside module level function"
      a = 4
      puts "Value of module function level local variable is #{a}"
    end
  end

  include M

  def a
    puts "Inside class instance method"
    a = 5
    puts "Value of class instance method level local variable a is #{a}"
  end

  class << self
    def b
      a = 6
      puts "Inside the class method"
      puts "Value of class method level local variable a is #{a}"
    end
  end
end

t
o = A.new
o.a
puts A.ancestors
o.m
A.b
