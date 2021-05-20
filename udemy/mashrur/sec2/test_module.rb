$LOAD_PATH << "."

require "crud"

class TestClass
  include Crud # This is a mixin

  attr_accessor :firstname, :lastname, :email, :password

  def initialize(firstname, lastname, email, password)
    @firstname = firstname
    @lastname = lastname
    @email = email
    @password = password
  end

  def to_s
    "First name: #{@firstname}, Last name: #{@lastname}, Email: #{@email}"
  end
end

test_object1 = TestClass.new("Abhishek", "Sharma", "abhishek@example.com", "password1")
test_object2 = TestClass.new("Kishore", "Sharma", "kishore@example.com", "password2")

hashed_password1 = test_object1.get_password_hash(test_object1.password)
puts hashed_password1
