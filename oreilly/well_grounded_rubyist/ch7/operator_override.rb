class A
  attr_accessor :value
  def !
    puts "Negating self"
    -@value
  end
end

o = A.new
o.value = 5
r = !o
puts r
