# The default object(self), scope and visibility

`self` is the current or the default object. Different objects can assume the role 
of self at different times depending on which context we are in. But in any case 
there is only one self.

At any point when the program is running, there is one and only one self available
 and there is always a self available.

## self object in different contexts/scopes
- At the top level of program (outside of any class or module) the `self` object 
refers to the **main** built-in top level default object
- In a class definition, the self refers to the class itself 
- In a module definition, the self refers to the module object itself
- In a method definition, 
  - the self refers to the ***self of whichever object is calling that method*** if it
 is a top level method. Top level methods (defined in the source file outside any 
class or module definition are available to the class or module methods as private methods)
  - inside a class, self refers to the ***instance of class*** which is responding to the 
message
  - inside a module, self may refer to individual object extended with the module 
or the instance of class that mixes with the module
  - for a singleton method on a specific object, self refers to the ***object*** itself
which may be an instance of the class or the class itself

Example
```
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

o = A.new
o.bello
o.method(:bello).super_method.call

A.hello
M.hello

>> Self at top level is: main
>> Self at module def level is: M
>> Self at class def level is: A
>> Self at instance method level is: #<A:0x00005585c6587680>
>> Self at module instance method is: #<A:0x00005585c6587680>
>> Self at class method level is: A
>> Self at module method level is: M
```

*top level* refers to the program code that is outside any class or module definition.
The `self` at top level is referred to by a special term `main`. We can't refer it
 directly (and if we want, we have to do `a = self` at top level) and it is 
interpreted by the interpreter on our behalf

The keywords `class`, `module` or `def` mark a change in context and, therefore, a 
change in the `self`

In case of inheritance, self will be the class from where the method is being called 

### Defining class methods
1. Method 1
```
class A
  def A.hello # explicitly setting the class name
    puts "Hello"
  end
end
```
2. Method 2
```
class A
  def self.hello # self in this context refers to the class itself
    puts "Hello"
  end
end
```
3. Method 3
```
class A
  class << self # All methods inside this block are class methods
    def hello
      puts "Hello"
    end
  end
end
```

### Self as the default receiver of messages
If the receiver of the message is self, we can let go of the dot notation of 
sending messages i.e. we can use `talk` instead of `self.talk`

*If a variable and a method are given the same name and we use the no dot notation
 of calling the method, the variable will take precedence.* To avoid this, we 
should keep sensible variable names or use the self.method syntax or use a set of 
empty parens `methodname()`

Dotless method calls are generally performed when calling one instance method from 
the another

*Edge case* -> We **must** use dot notation when calling the setter methods of the 
form `venue=()` because Ruby interprets `=` statements as assignments and not using
 self will give us a variable instead of the method call
```
def venue=(loc)
  @venue = loc
end

self.venue = "something"
```

### Instance variables and self
Every instance variable belongs to a `self` and that self is the object that is 
the current self i.e the one who is playing the role of self at the moment

Classes also can have their own private variables that are separate from the 
instances variables
```
class A
  def self.hello
    @a = 1
  end

  def hello
    @a = 2
  end

  def self.show_a
    puts @a
  end

  def show_a
    puts @a
  end
end

o = A.new
A.hello
A.show_a
o.show_a
```

## Determining scope

Scope refers to the visibility of identifiers (variables and constants)

***Instance variables are self bound rather than scope bound*** -> What does this mean?

### Global variables and global scope
Variables declared at the top level of the program with a `$` prefix are called 
global variables and are available everywhere inside the program - inside the 
class definitions, module definitions, instance methods etc. It is alwasy *in* 
scope i.e. even if the value of `self` changes, these variables are in scope
```
$global_var = "Global"

class C
  puts "Here: #{$global_var}"
  def hello
    puts "Still here: #{$global_var}"
  end
end

o = C.new
o.hello
>> Here: Global
>> Still here: Global
```

There are several built-in global variables in Ruby. A few of these are:
- `$0` -> name of the startup file
- `$:` -> ruby load path
- `$$` -> PID of the Ruby process

To get a full list of such built-in global variables, use `require English` which 
provides friendly names for cryptic global variables

It is strongly advised not to use global variables because they break the scope 
and the information is accessible to objects who may not need access to it. 

### Local variables and local scope
A local scope begins at:
- the top level -> it has its own local scope
- class or module definition -> even nested definitions
- method call -> each call creates a new scope with all the variables set to undefined

*To access a nested class inside another class/module, user `::` notations*  
```
class A
  a = 1
  class B
    a = 2
    module M
      a = 3
      class C
        a = 4
        def show
          puts a
        end
      end
     puts a
    end
    puts a
  end
  puts a
end

d = A::B::M::C.new
```
Also, it should be noted that all the code in class and module definition get 
executed when it's first encountered whereas methods aren't executed until an 
object receives appropriate message. In the above examples all the puts statements
 except for the one in the class C's show method will be executed when the file is run

### Interaction between local scope and self
**scope** determiens the visibility whereas **self** determines who is receiving 
messages

A lot of times scope and self changes simultaneously but it is very much possible 
that scope changes without the self changing and vice-versa e.g. in recursive 
calls self remains the same but scope changes

To demonstrate this we can either print the scope `puts scope` or print the object 
id of the object which is a unique value assigned to each object

### Constants in scope
To access a nested constant use the syntax `M::C::D::N::X` where `M` is the module
 that nests the class definition `C` which has the nested class `D` that 
encapsulates the class `N` which in turn holds the constant `X`

Constants and globals are different in the sense that the global variable permeates 
the class and module definitions and it is not bound by any scope whereas the 
constants are scoped i.e. constant x in one scope is different from constant x in 
another scope
```
$g = 10
module M
  X = 1
  puts "Global variable at scope 1: #{$g}"
  puts "Constant X at scope 1: #{X}"
  class C
    X = 2
    puts "Global variable at scope 2: #{$g}"
    puts "Constant X at scope 2: #{X}"
    class D
      X = 3
      puts "Global variable at scope 3: #{$g}"
      puts "Constant X at scope 3: #{X}"
      module N
        X = 4
        puts "Global variable at scope 4: #{$g}"
        puts "Constant X at scope 4: #{X}"
      end
    end
  end
end

>> Global variable at scope 1: 10
>> Constant X at scope 1: 1
>> Global variable at scope 2: 10
>> Constant X at scope 2: 2
>> Global variable at scope 3: 10
>> Constant X at scope 3: 3
>> Global variable at scope 4: 10
>> Constant X at scope 4: 4
```

Constant lookup is similar to file lookup on the filesystem. We need to use the 
relative path for the constant if we are already inside a scope. In the above example 
in order to refer to the constant X inside module N from within class C we need to
 use `D::N::X` instead of `M::C::D::N::X` that we would need from module M 

If we need to provide the **absolute path** for the constant we can prefix `::` 
before the name to specify that we want to search for the constant starting from
 the top level. Example: `::String`

### Class variable syntax, scope and visibility
Syntax of class variables -> `@@varname`

Class variables are visible to itself and its instances and no other object. It 
can be defined at the class method level or instance method level or the top of 
the class method level

Class variables are visible to the class methods and the instance methods and in
 doing so they are cutting across scopes because at class level and at class method
 level the self is the class object itself whereas at the instance method level 
the self is the instance object of the class

### Class variables and the class hierarchy
Class variables are scoped to the ***class hierarchy*** meaning that if we have 
a class variable in a class and another class inherits from this class then it is 
also inheriting the same class variable and it can change that variable's value 
which will be reflected in the first class as well. It is not only limited to 
direct descendants but to all the classes lower in the heirarchy
```
class A
  @@value = 100
end
class B < A
  @@value = 100
end
class A
  puts @@value # value printed is 100
end
```

## Method access rules

### Private
Private methods are methods that can only be invoked by the instance methods and 
not any other way (not even from the class definition)

Private methods can be specified by using the `private` keyword either by listing
 a list of methods that need to be private or creating a private section in the 
class. Example
```
class A
  def a
    puts "Hello"
  end

  private
  def b
    puts "Bello"
  end
end
```
OR, we can say
```
class A
  def a
    puts "Hello"
  end
  
  def b
    puts "Bello"
  end

  private :b
end
```

Private methods are called without a dot notation, which means that we don't specify 
a receiver when calling these methods. This limitation limits where we can call this 
method from. We can't call it from outside of the class as a message to the object 
because then we would need to specify the object as the receiver but it can't have one.
 We can't call it from the class definition level because then the receiver would be 
the class itself and that would be similar to calling *ClassName*.methodname which
 is not possible either because the method is not a class method. So, it can be
 called only from one scope and that is from an instance of the class that has 
a self with capability to receive the message and invoke the method without 
explicitly specifying a receiver. This condition is satisfied whenever an instance 
method of the class is invoked, thus, a private method can only be called from within
 an instance method.

Private methods are different from the singleton methods- first in the sense that 
these methods are public by default (we can have private singletons) and singleton 
methods belong to only one object whereas the private methods are shared with all
 the objects of the class. 

In case of setters for private methods (methods ending with `=`), the limitation of
not having an explicit receiver is not applicable but the receiver has to be the 
`self` - not a reference but the keyword explicitly needs to be there
```
class A
  def set_age=(age)
    @age = age
  end

  def yo
    self.set_age = 55
  end
  private :set_age=
end
```

### Protected methods

Protected methods are the methods that can be called on an object as long as that 
object's self is an instance of the same class or its ancestor or descendant

This is used in situtations where one instance of a class needs to call a method of 
another instance of the same class (e.g. in comparison)

The syntax is same for protected methods - either define a protected block or 
specify the private methods explicitly

In case of inheritance, the subclass' objects exhibits the same access behaviour as the 
parent class' objects. But if any of the rules are overridden then those rules take 
precedence over the inherited rules

## Top level methods
The top level methods are actually private methods of the `Object` class that's
 why they are always called without any receiver specified. Also, these methods
 can be called from anywhere in the script file because the `Object` class is in
 every class' method lookup path (except `BasicObject`).

***How are top level methods available to all if they are private? The self will be 
different in different scopes***

*No matter what self is, it will be able to recognize the message you send to it
 if that message resolves to a private instance method of Object class*
This is possible because all the methods of Object class are visible to all the 
objects.

### Pre-defined top-level methods
Private instances methods of Kernel module (available because Object classes 
mixes it):
puts
print

The top level methods that we create are private methods of the Object class

To view a list of all the private instance variables that the Kernel provides:
`ruby -e 'p Kernel.private_instance_methods.sort'`

