# Organizing objects with classes

Everything in Ruby is an object or something that evaluates to an object and 
every object is an instance of a class 

`Object` is a built in Ruby class

Even classes themselves are objects, and they also respond to messages e.g new 
is a method also called as a *constructor* which instantiates a new object

Classe are named with ***constants*** which is a special type of identifier that starts 
with a capital letter.

Ruby recognizes **constants** and it is used to store information that is not 
supposed to chage during the program run. However, it is possible to overwrite the 
value stored in a constant. Ruby console will issue a warning about this.

## Class definition
```
class Ticket
  def event
    puts "This is an event"
  end
end
```

#### Instantiating a class
`ticket = Ticket.new`

#### Calling an instance method
`ticket.event`

### Methods
- **Instance methods** -> Methods that are defined as the part of the class and are 
shared by all the instances of the classes. See above example
- **Singleton methods** -> Methods that belong to a particular instance of a class
 and not any other instances. Example
```
def ticket.sold?
  true
end
```
-  Here `sold?` method is available only to the `ticket` instance of `Ticket` class

### Method overriding
- If there are two definitions for the same method name, the definition that comes 
later on will be the one that is demonstrated when called. Example
```
class MethodOverride
  def method_a
    puts "I am first"
  end

  def method_a
    puts "I am second"
  end
end

mo = MethodOverrid.new
mo.method_a

>> I am second
```

### Reopening classes
In Ruby it is possible to *reopen* classes to extend its definition. Example:
```
class MethodA
  def method_a
    puts "I am method a"
  end
end

class MethodA
  def method_b
    puts "I am method b"
  end
end
```

- The effect is similar to creating a class with both the method definitions. In the 
end both the classes are merged.

- This is not a good practice to break class definitions 

- It can be used to enhance the method that already exists. This is different from 
**inheritance** where the subclass inherits the methods from the parent class. Here
 we are modifying the actual class itself.

- If we create an object before re-opening, it won't have the methods available 
to the object created after re-opening

### Instance variables
- The **state** of the object is the information and data associated with it
- Instances variable names always start with an `@`
- These variables are only available to the **object** to which they belong
- These variables can be modified and used by any of the methods of the object
```
class Person
  def set_name(name)
    @name = name
  end

  def get_name
    puts @name
  end
end

p = Person.new
p.set_name = "Name1"
p.get_name
```

### Initializing object with a state
- **initialize** is a special method that can be created in a class and which is 
called everytime the class is instantiated i.e. the `new` message is sent
- It can be used to set the state of the object at the time of instantiation
- The parameters required for the `initialize` method need to be passed to the 
`new` message. *See example below*
- We also need to add the **getters** to retrieve the value of the instance variables 
initialized. The getter names can be anything but it is a good practice to set the 
name of the getters to the same name as the variable
```
class Ticket
  def initialize(venue, date)
    @venue = venue
    @data = date
  end

  def venue
    @venue
  end

  def date
    @date
  end
end

t1 = Ticket.new("Somewhere", "Someday")
puts t1.venue, t1.date
```
- Similar to getters we can also have corresponding **setters**. We can define setters 
like this:
```
def set_name(name)
  @name = name
end
```
... but there is a better syntax provided by Ruby to define setters and to call
 them. It is using `fieldname=(args)` syntax and it can be called using either 
`object.fieldname=(param)` or `object.fieldname = param`. Example:
```
class Ticket
  # Reopening the previous class definition
  def venue=(venue)
    @venue = venue
  end

  def name=(name)
    @name = name
  end
end

t1 = Ticket.new("Someplace", "Sometime")
t1.venue=("Someplace new") # valid
t1.date = "Sometime new" # valid
```
- We can have *validation* built in the setter methods to make sure that the value 
we are receiving is *normalized* i.e. ensure that certain data always takes a 
specific form 
```
class Ticket(venue, year)
  def year=(year)
    @year = date.to_i
    if @year < 100:
      @year = @year + 2000
    end
  end

  def venue=(venue)
    if venue == "Someplace good"
      @venue = venue
    else
      put "Not good"
    end
end
```
- **Important** - Setter methods with `=` sign return the value that was passed 
to them, not the processed form (if we are performing additional processing on the 
provided data e.g add, subtract, concatenate, split etc.

### Object attributes and the attr\_\* method family
- An **attribute** is a property of an object whose value can be read and/or 
written through the object e.g. each ticket object has a *price* attribute, a *date* 
attribute and a *venue* attribute
- *In Ruby, read and write are used instead of get and set*
- **In Ruby there is no separate _attribute_ construct at language level**. Rather
 here attributes refer to the instance variables wrapped in reader/writer methods
- ***attr_reader*** -> Creates reader methods (price)
- ***attr_writer*** -> Creates writer methods (price=(args))
- ***attr_accessor*** -> Creates both reader and writer
```
class Ticket
  attr_reader :date, :field4, :field5
  attr_writer :price, :field3
  attr_accessor :field1, :field2
end
```
- In the above example *attr_* are messages that are sent to the **self** object 
that refers to the class object itself

## Inheritance
- One class inherits the **behaviors** i.e. the methods including the attr ones 
(not the *instance variables*) of the parent class
- Syntax - `class A < B`
```
class Publication
  attr_accessor :publisher
end

class Magazine < Publication
  attr_accessor :editor
end
```
- **Single inheritance** - One class can inherit from only one class
- Ruby provides **modules** - a programming construct that can encapsulate functionalities 
and can be added to the class hierarchy but can't be instantiated
- Program design in Ruby doesn't depend on class inheritance rather on objects 
and methods that these objects can invoke

## Object class and BasicObject class
- **Object** class -> All other classes are descendants of this class. If we create 
a class which doesn't inherit from any other class - it's superclass will be `Object`
```
class A
end

class B < A
end

A.superclass
>> Object
B.superclass
>> A 
```
- According to the rules of inheritance, any instance method available to the Object 
class is also available to the new class

- The **BasicObject** class is the root of all. It has the bare minimum required 
functionality for existence. The **Object** class inherits from this class and adds 
its own methods. It doesn't event have an inspect method

## Classes as objects and message receivers
- ***Classes are also objects, but a special one in the sense that these are the 
only objects that have the capability to spawn new objects***
- Classes can be even passed as a method argument!!
- Every class is an instance of a class called  **Class**
```
BasicObject.is_a?(Class)
>> true
Object.is_a?(Class)
>> true 
Class.is_a?(Object)
>> true

a = Class.new # creating new class
```

---------------
(Qn.) 1: How is 'Object' class already available? Who instantiates it? When?
(Qn.) 2: Who instantiates the 'BasicObject' class and when?
(Qn.) 3: How does this recursive definition translate into code?
---------------

```
# Creating new class with instance methods from the Class class
c = Class.new do
  def say_hello
    puts "Hello"
  end

  def say_bello
    puts "Bello"
  end
end

# Instantiate the newly created class
o = c.new

o.say_hello
>> "Hello"
```

### How class objects call methods
*Here the class object refers to the class itself not its instances*
- Messages are sent to the class objects via either the **.** notation or, in case of 
inside a class, using the **self** object
- Object get their methods from the ones defined in the class or the ones inherited 
from the superclass and ancestors or the **singleton** methods
- In case of **class objects** as well, it can receive methods from the superclass 
 e.g. `Ticket.new` - the new method is inherited from the `Class` superclass or 
the ones defined in the class body e.g. `Ticket.price = 44`
- We can add **singleton** methods to the **class object** as well, e.g.
```
def Ticket.expensive(*tickets)
  tickets.max_by(&:price)
end
```
- Here we are adding the `expensive` method to the `Ticket` class object
- `&:` is an abbreviated way of iterating over each element of the array and 
applying a method. Here, it is iterating over each element of the array provided 
as the argument an applying the method `max_by` and *price* is the index to sort by 

**class methods** - Methods that are defined within and called directly upon the
 class object rather than the objects instantiated from the class object

The `new` method is present as both instance and class method for the class `Class`

`File.open` returns a `File` object, so it is an initializer in a sense

We can and should write class methods when:
1. We are returning a new object of the class
2. There is a method that makes sense to be called at class level e.g. most\_expensive
3. When we are creating utility methods e.g. sqrt, pow etc

### Class methods vs. Instance methods
- Classes are objects
- Instances of classes are objects, too
- Classes have their own methods, state and identity that are separate from the
 objects created with that class. These things are not shared with the instances

Whenever a method needs to be called, whether the class methods or instance methods 
they always use the dot notation, e.g. `Ticket.most_exp()` or `a_ticket.price`. 
While referring to the methods available to a class we use `Ticket::method_name`
 whereas referring to the methods available to an object we use `a_ticket#method`

Sometimes, the class methods can also be represented (not called) using the dot 
notation

## Constants
- Name of constants start with an uppercase letter (e.g. class names)
- If defined inside a class to store some value, it is defined at the top of the 
class definition
- A constant definition can be accessed by both the class methods and the instance
 methods 
- We can also access the class constants using `::` notation e.g. `puts Math::PI`  

### Modifying constants
- *Re-assigning* -> Reuse the constant name to refer to something else. irb gives 
a warning
- *Modifying* -> The object to which the constant holds the reference to has been 
changed e.g. `Ticket::VENUES << "New place"` where `VENUES` is an array
-  We don't get any warning while modifying a constant because there are no changes
 to what is stored in the constant - it still stores the reference to the same object
 only the object itself has been changed. This is because Ruby is a dynamic language

-- Classes can change, objects can change with new behavious added dynamically at 
runtime. Which implies that the state of the object (class or instances) can't be 
pre-determined based on the class ancestry. We need to determine the capabilities 
at the runtime (`is_a?` or `respond_to`) to get a sense of what methods are 
available for this object
-- We need to model our problem in such a way that we know where, and if, we need
 to add singleton methods to the object























