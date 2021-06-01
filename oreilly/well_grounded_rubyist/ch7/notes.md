# Built in essentials

Core library classes -> Classes that don't need to be `require`d in the Ruby 
program file e.g. File, Float, Integer, Array, Math, String, Hash, IO, Random, Time

Standard library classes -> Classes that ship with the Ruby programming language 
but which we need to `require` in our program files to use them e.g. JSON, YAML, 
CSV, Date, Digest, Prime

Most of the classes can be instantiated using the `new` method except a few e.g.
 Integer or Float or Symbol. Also, some classes can be instantiated using a 
 *literal constructor* i.e. using special notation e.g. 
String -> "abc", 
Array -> [1, 2, 3]
Hash -> {'a': 1}
Symbol -> :a
Regexp -> /^a/
Range -> 0..9
Proc -> ->(x, y) { puts x, y }

Some literal constructors may be overloaded e.g. {} for code blocks, [] for index etc.

## Syntactic sugar

### Defining operators by definings methods
In Ruby operators are methods and can be defined as such. We can attribute any 
behaviour to the operators (e.g. +, -, \*, / etc). It is as simple as overriding 
the method
```
class A
  attr_accessor :a
  def +(val)
    puts "This is how we roll"
    a + val.to_i
  end
end

o = A.new
o.a = 5  
o + 4
>> This is how we roll
>> 9
```

By defining operator methods as above we also get additional ones without 
defining e.g. +=, -+, /=, etc.

We can re-define almost all of the operators except a few e.g. `&&` and `||` or 
literal constructors e.g. "", {}

We can also define unary methods e.g. `+` and `-` or `!` to mean what we want e.g.
 in order to override `+` and `-` behaviour as unary operators, we can do 
`def +@` or `def -@`. Defining the `!` operator also overrides the logical `not` 
for that object 
```
class A
  attr_accessor :value
  def !
    puts "Negating self"
    puts @value
  end
end

o = A.new
o.value = 5
!o
>> Negating self
>> -5
```

### Methods ending with `!`
The methods that end with an exclamation point serve as a warning sign that the 
method is going to do something that can be seen as dangerous. What dangerous means 
depends on who is defining the method. For built in classes methods that end with 
a `!` signifies that the method permanently modifies the caller itself.
```
a = "This"
a.reverse # non-bang version
>> sihT # This is a copy 
a # caller is same
>> This
a.reverse! # bang version
>> sihT
a
>> sihT # The caller has been modified
```

Mostly bang methods appear with a non-bang version and for Ruby's core classes 
the non-bang version provides a modified copy of the caller whereas the bang 
version changes the caller itself 

The `!` methods in itself don't hold any significance. They are just part of the 
convention and best practices. Appending `!` at the end of the method name 
notifies the end user of the possible repercussions. 
- It is best practice to define the m/m! methods in pairs
- ! doesn't mean destructive, it means dangerous or unexpected behaviour follows 
that digresses from what the method name suggests e.g. revers/reverse!

The last best practice means that if we have a method named `clear` that clears 
all the characters of the string and changes it to `""` then there is no need to 
have a bang at the end because the said behaviour is expected from clear

## Conversion methods
Built in conversion methods start with `to_` and represent the class to which the object 
will be converted.
- to\_s -> to string, used by `puts` and string interpolation to provide a  
string representation, can be user defined. If no `to_s` defined for object, it 
will send class and memory location
- to\_sym - to symbol
- to\_f -> to float
- to\_i -> to integer
- to\_a -> to array

When puts is called on an Array object, it calls to\_s on each element of the array
 cyclically, whereas calling an explicit to\_s method on the array object doesn't 
do that

inspect -> provides a string representation like `to\_s` and is used by irb 
automatically after each line of code execution. It provides class and memory 
dump by default and can be overridden

display -> same as `display` and `to\_s` and can write output to a filestream 
directly. Writes to the `STDOUT` by default. Doesn't append `\n` at the end.

All objects that include **Enumerable** module also implement **to\_a** method
which provides an Array representaion of the object. Classes implementing to\_a 
method include `Hash`, `Range`, `Struct` etc.
```
(1..5).to_a
>> [1, 2, 3, 4, 5] 
```

### `splat` operator 
`*` is called the splat or unarray operator and it converts an array into a list 
of its individual elements. It is used by the sponge argument in the argument list. 
The unarrayed array serves as a bare list i.e. individual identifiers or *comma 
separated list*

There is no distinction in how a list and an array are represented but the acutal 
contents inside of an array are actually a list and the `[]` is what makes it an array
```
a = [1, 2, 3]
[a]
>> [[1, 2, 3]]
[*a] # Decomposed into a list
>> [1, 2, 3]
```

`to_i` and `to_f` methods turn a string into an integer or float. There is no 
implicit string to number conversion. Using to\_i or to\_f takes the digit parts
 from the starting and converts to corresponding int or float
```
a = "123hello"
a.to_i
>> 123
a.to_f
>> 123.0

b = "12.3hello"
b.to_i
>> 12
b.to_f
>> 12.3

c = "hello"
c.to_i
>> 0
c.to_f
>> 0.0
```

`Integer` and `Float` perform a stricter conversion and will throw an error if 
there are non-numeric characters except `.`

In Ruby there is no typecasting in traditional sense. An objects' type here is 
the aggregate of everything it can do at a particular time

***Very Important*** -> In Ruby it doesn't matter much which object a class belongs 
to; what matters is what the object can do

### `to_str` and `to_ary` methods
These two methods are used to provide a representation of the object as a String 
or Array class object. This is required by certain core methods that require their 
arguments to belong to a certain class.

Concatenation is one such operation where the String (`+` or `<<`) or the Array 
(`concat` method) are looking for an String or Array object (not a to\_s string 
representation
```
class A
end

o = A.new
"Yo, " + o
>> TypeError

class A
  def to_str
    "what's up"
  end
end

m = A.new
"Yo, " + m
>> Yo, what's up
```

## Boolean states, boolean objects and nil

Every object in Ruby is either `true` or `false`. `true` and `false` are 
themselves objects and they can be treated as either *states* (in case of 
conditional statements) or *objects* otherwise

We can do `if e` where `e` can be any object or an expression which is first 
evaluated; the result of which is, again, an object. This verifies that every  
object in Ruby is either true or false

A class definition evaluates to last expression inside its definition. A 
method definition evaluates to a symbol representing the name of the method 
and strings and integers evaluate to true. An empty class defintion, on the 
other hand, evaluates to nil, which has a boolean value of false. An 
expression e.g. `100 > 4` evaluates to either true or false which is an 
**object** having boolean value (or state) of true or false

These `true` and `false` objects are only instances of their respective 
classes - `TrueClass` and `FalseClass`
```
puts true.class
puts false.class

>> TrueClass
>> FalseClass
```

The terms true and false are also Ruby keywords meaning that these can't be 
used as variable names. As these are objects they can be passed around as 
objects, can be sent as arguments.

Everything i.e every object has a boolean value of **true** (even empty strings, 
0, empty arrays, hashes) except `false` itself and `nil`

### nil
`nil` is an (and the only) object of the class `NilClass`. It has some 
ambiguities e.g. it evaluates to `false` by default.

`nil` denotes the absence of something e.g. the value stored in an 
uninitialized variable (but not a local variable which are not initialized to 
anything by default, not even to nil) or a value at a non-existent index. 

Its object id is **8** and its integer representation is **0** and its string 
representation is ""

## Comparing two objects

`Object` class defines 3 types of equality testing methods `==`, `eql?` and 
`equal?` all of which evaluate, at the `Object` class level whether the 
objects are the exact same objects. Further down the line they can be 
overridden by inheriting class to mean different thing. Generally, `==` and 
`eql?` methods are overridden to perform custom comparisons of equality and 
`equal?` method holds its original meaning and checks if the objects being 
tested are the same object 

It is a best practice to *not* override the `equal?` method

When we define `==` we already get `!=`

To have a full suite of comparison methods (<, >, <=, >=, == and !=) we need 
to:
1. include **Comparable** module -> comes with Ruby
2. define an instance method <=> (spaceship operator) - which defines what it 
means for an object to be less than, equal to or greater than the other object 
the return values are 0 -> equal, -1 -> self is less than other, 1 -> self is 
greater than the other
```
class A
  attr_accessor :a

  def <=>(value)
    if (self.a < value.a)
      -1
    elsif (self.a > value.a)
      1
    else
      0
    end
  end
end
```

After defining the spaceship operator we have all the comparison methods 
available to us, including `between?` method which asserts whether the caller 
is between two given objects

## Inspection and Reflection
Both these refer to the various ways in which an object can tell us about 
itself during its lifetime. e.g. the `inspect` method gives us a string 
representation of the object.

We can also use the *reflective* method `methods` to know which methods are 
available to the current object
```
class A
  def a
  end
end

A.methods.sort
>> [A list of methods that the class object A understands]

o = A.new
o.methods.sort
>> [A list of methods that the object o understands]
```

The `methods` method return value includes the singleton methods and it 
includes all the methods that the object has including the one it has inherited 
from its superclass and included modules

To list only singleton methods we can use `singleton_methods` method

**Important** -> Adding a module to a class or a singleton method to the class 
after an object has been instantiated will add the methods to the method 
lookup path and the existing objects will have it too. It doesn't matter when 
the module was added to the method lookup path. What matters is what exists 
at the time of the lookup.

To find what methods a class or module object provides its instances use the 
`instance_methods` method on the class object e.g. `String.instance_methods` or 
we can provide argument `false` to this method to exclude any methods courtsey 
of ancestors `String.instance_methods(false).sort` -> this will exclude any 
methods defined in the superclass of included modules

We can also use the following methods at object or class level to find out the 
methods as suggested by the name:
- `obj.private_methods`
- `obj.public_methods`
- `obj.protected_methods`
- `obj.singleton_methods`
- `Class.private_instance_methods`
- `Class.protected_instance_methods`
- `Class.public_instance_methods`

