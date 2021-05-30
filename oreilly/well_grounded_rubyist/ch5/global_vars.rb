$global_var = "Global"

class A
  puts "Here: #{$global_var}"

  def hello
    puts "Still here: #{$global_var}"
  end
end

o = A.new
o.hello
