#Objects, methods and local variables

- In Ruby everything is an *object*
- Any operation that is performed is via an object
- Any thing that we store is an object
- Object oriented software design -> figuring out what our objects are - what 
they should do, how do they interact with data, how many of them there sould be

- Objects can learn behaviour that wasn't taught to them
- Even classes are themselves an object

### Adding a method to an object
```
obj = Object.new # Create a generic object
def obj.talk
  puts "I am an object"
  puts "Do you object?"
end
```
- Here *obj* is the object to which the method will belong
- *talk* is the method name aka the **message**
-  "talk" is the message sent to the "obj" receiver
- What follows is the method body
- The same syntax applies when creating a method elsewhere except for the **.**
 part
- An object **responds to** a message if there is a method defined whose name 
corresponds to the message
- If there is no method by the name of the message, error is thrown

### parameters and arguments
- **parameter** - Values specified in the function signature
- **argument** - Actual values passed during method call

- Parameters can be required or optional
- When the method takes no arguments, we should not use the parantheses
- If the method takes arguments, it is best practices to include the parantheses
 for cases where we may need method chaining

### Return values
- Every expression in Ruby evaluates to and returns a value
- e.g. 2 + 2 evaluates to and *returns* 4
- assignment `c=100` evaluates to the value being assigned 
- Method calls are also expressions and return a value
- **Important** Return value of any method is the same as the value of the last
 expression evaluated during the execution
- We can omit *return* keyword if we are returning a single value
- If we return mulitple values, they are wrapped in a list and then returned, 
e.g. `reutrn 1, 2, 3` will return `[1, 2, 3]`
- Also, we need to use return keyword when we want to be explicit about the 
the return value and under conditional blocks
- A call to a function with empty body returns `nil`

**String interpolation**
```
a = "Sparta"
puts "This is #{a}"
```
### Methods that return boolean value
```
def ticket.available?
  false
end
```
- Such methods end with a ***?*** and may return **true** or **false**
- *true* and *false* are also objects
- Every object in Ruby has a truth value and every object in Ruby is *true* 
except for the `false` and `nil` objects
- Even `0` is true in Ruby

### Innate methods
- A list of methods (messages) available for an object can be listed using 
the *methods* method `puts Object.new.methods.sort`
- ***object_id*** method -> gives the unique ID of the object
-  This method can be used for checking if two objects are equal (whether they 
point to the same object)
- ***respond_to*** method -> check if the object *responds to* a message
- It is a reflective or introspective method
- ***send*** method -> Send message (method name) to the object
`obj.send(symbol_name)`
- When we use *send* to send a message to the object, that message will be 
invoked on the object 
- We can use *__send__* instead of *send* to avoid name collision 
- We can also use *public_send* method if we don't want it to be able to access
 the private methods
- Don't use send arbitrary messages to objects if those messages are based on 
user choice or input

## Method arguments
- If a function has a prameter it will always be bound to a value, event if it 
is an empty array

### Positional Arguments
- Required arguments
```
def obj.argument(x)
  puts "It takes one required argument"
end
```

- Optional arguments
-  They start with a \*
-  An optional argument can also be specified by providing a default value
```
def obj.argument(\*x)
  puts "This takes in zero or more arguments"
  puts "The arguments are provided to the method body as a list"
end
```
```
def obj.argument(x=2)
  puts "This takes one optional argument"
end
```

- Mixing required and optional args
```
def obj.argument(a, b, \*c)
  puts "I take 2 required and an optional args"
end
```

- Order of parameters and arguments
-  If there is a \*o parameter in the list, \*o gets the lowest priority
-  First the positional arguments are assigned values and the optional gets the
 remainder (0 or more)
-  We can have a default value parameter before the optional argument but not 
the other way around e.g. `def a(a, *b, c=1)` is invalid
```
def obj.mixed_args(a, b, *c, d)
  puts "Arguments: "
  p a,b,c,d
end
obj.mixed_args(1, 2, 3, 4, 5)
obj.mixed_args(1, 2, 3)
// Output
Arguments:
1
2
[3, 4]
5

Arguments:
1
2
[]
3

def obj.mixed_args2(a, b=1, *c, d, e)
  puts "Arguments: "
  p a,b,c,d,e
end
obj.mixed_args2(2, 3, 4, 5, 6)
obj.mixed_args2(1, 2, 3, 4)

// Output
Arguments:
2
3
[6]
4
5

Arguments:
1
2
[]
3
4
```
### Keyword Arguments

## Local variables and variable assignment
- Names can be alphanumerice
- Can start only with char or \_
- Lone \_ is a valid variable name
- snake\_case names are preferred for local variables
- *Local* means local in scope - to a function or a loop or a condition

### Variable assignment
*A variable stores the reference to the object it is supposed to store* - Above
 statement is valid for all objects except for ***integers, symbols, `true`, 
`false` and `nil`***. What this means is that if we have `a = 'This'` and 
`b = a`, then what `a` has is a reference to a string object that has the `This`
 string. Also, what gets stored in `b` as part of assignment `b = a` is a copy
 of the reference stored in `a`.

Thus if we do `a.replace("blah")` -> it performs an *in-place* replacement of 
characters meaning the object is same but the characters stored in it have 
changed. Since the variable `b` contains the reference to the same object, if 
we print its contents we will see the updated value

References have a many to one relationship meaning that one object can have 
multiple variables holding a reference to it and any of those variables can 
send a message to the object, thereby changing the object for all the variables.

Upon variable re-assignment the stored references change

All of this referencing and de-referencing is handled by Ruby itself

Examples

```
a = "This"
b = a
puts a, b

>> This
>> This

a.replace("That")

puts a, b

>> That
>> That

a = "Them"

puts a, b

>> Them
>> That
```

In case of ***integers, symbols, true, false and nil*** the variables store the
 value itself. So, if we have `a = 5`, we can't do `a++` because if it were so,
and since `a` stores the value itself rather than the reference, 5 would become 6
and no longer remain 5

It also means that for such values it doesn't matter how many variables it is 
assigned to the value always remains the same

If there are no references to an object its memory space is released and reused

*The same variable assignment and re-assignment rules apply to all types of 
variables - local, global, class and instance. In other words all the l-values
follow the same rule*

*An l-value is an identifier that can be on the left hand side of an expression*

*Ruby doesn't have typed variables* - meaning that any variable can be bound to
any object of any class at any time

### References and method arguments
The following behaviour is observed in Ruby:
```
def a(s)
  s.replace("New")
end

b = "Old"
a b
puts a

>> "New"
```

This is because:
1. When a method is called with arguments we are passing object references to 
it
2. We are passing a *reference* to the object as the variable stores the 
reference, not the value itself (except for the exceptions)
2. The *replace* method changes the object that the reference was referring to
3. If we used `s = "New"` there wouldn't be any impact on the passed object

### Protecting objects from changes
***dup*** -> It duplicates the objects, dup of frozen object isn't frozen
***freeze*** -> Freezes the object from any further changes. Once frozen, they 
can't be unfreezed.
***clone*** -> like *dup* but the clone is also frozen

It is possible to freeze an array but still be able to change its individual 
elements if they are not frozen individually

Examples
```
a = ["one", "two", "three"]
b = a.dup # duplicates the array, no references are shared
b[0] = "four"

puts a, b
>> ["one", "two", "three"]
>> ["four", "two", "three"]

b.freeze
b << "five" # throws error

c = b.clone
c[0] = "five" # throws error, clone of frozen, assignment means updating ref 

c[0].replace("five") # this is possible 

puts c
>> ["five", "two", "three"]
```

A reference to an object inside a collection is ***not*** the same as the reference 
to the collection itself

### Distinction between keyword, variable name or method
1. Ruby has an internal list of keywords, if the identifier matches any of 
these, it is a keyword
2. If there is an "=" sign after the identifier, it is a local variable
3. Else it is assumed to be both variable or method call and evaluated as such

