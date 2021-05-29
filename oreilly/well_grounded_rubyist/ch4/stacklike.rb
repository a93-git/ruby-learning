# A module that implements behaviour of a stack
# Stack is LIFO data structure - meaning that the last element in goes out first

module Stacklike
  def stack
    @stack ||= [] # ||= or equals operator, execute if stack is not nil or false
  end

  def add_to_stack(obj)
    stack.push(obj) # Why is there no @ symbol here?
  end

  def take_from_stack
    stack.pop
  end
end
