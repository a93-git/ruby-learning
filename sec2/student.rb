# Ruby oop file

# Class names must start with uppercase

$LOAD_PATH << "."

require "crud"

class Student
  attr_accessor :field1, :field2 # create the setters and getters for specified fields
  attr_reader :field3 # Creates a getter only, value initialized in the initializer method

  # We can remove the following declarations as they are being created in initializer as well
  @field1 # Instance variables start with @
  @field2
  @field3

  # initializer method
  def initialize(f1, f2, f3)
    @field1 = f1
    @field2 = f2
    @field3 = f3
  end

  # Setter method is defined as below
  # Value can be set as: object.field1 = value
  def field1=(field1_value)
    @field1 = field1_value
  end

  # Getter method
  # Value can be received as object.field1
  def field1
    @field1
  end

  # To string method - will be used by puts
  def to_s
    "field1: #{@field1}, field2: #{@field2}, field3: #{@field3}"
  end
end

object = Student.new("New value 1", "New value 2", "New value 3")

puts object # Calls the to_s method on the object
puts object.field3
