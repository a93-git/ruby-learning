puts "Self at top level is: #{self}"

module M
  puts "Self at module def level is: #{self}"

  def M.hello
    puts "Self at module method level is: #{self}"
  end

  def bello
    puts "Self at module instance method is: #{self}"
  end
end

class A
  include M

  puts "Self at class def level is: #{self}"

  def A.hello
    puts "Self at class method level is: #{self}"
  end

  def bello
    puts "Self at instance method level is: #{self}"
  end
end

class B < A
end

o = A.new
o.bello
o.method(:bello).super_method.call

# A.hello
# M.hello

o2 = B.new
# o2.bello
B.hello

p B.ancestors
