# Defining a variable with same name as the class method causes the no dot 
# notation to take it as the variable name instead of class name
class A
  hello = "Hello" # comment this line to see the change
  class << self
    def hello
      puts "I am #{self}"
    end
  end
  puts hello
end


