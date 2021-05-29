# Modules and program organization

Modules are a programming construct that allows to break larger entities in 
smaller ones and also allows us to mix and match object behaviour. This means we
 can have a set of behaviours separate from the class or object and we can mix it
 as required. It is very similar to class in the sense that it can encapsulate methods
 and constants and can be used to enhance the abilities of a class by providing 
these methods when mixed in. But they are also different from classes in the sense 
that we can include multiple modules a class and a module can't be instantiated.

***Modules can also be seen as NAMESPACES***

Like classes modules contain methods and constants but they don't have **instances**. 
Instead we have to specify that we want to add the functionality of a module to 
a class or object

*Modules are more generalized, Classes are specialized*

Module -> Class -> Objects --> This implies that objects are instantiated from 
classes and the `Class` object itself is a subclass of `Module` object and the 
`Module` object itself is an `Object`
```
Class.superclass
>> Module
Module.superclass
>> Object
```

## Module creation and use

- Syntax - defined using the `module` keyword
```
module ModuleName
  def say_hello
    puts "Hello"
  end
end
```

- Use - Modules are loaded or *mixed in* to the classes using the `include` method 
or the `prepend` method and it makes the methods of the module available to the 
objects of the class
  - *including* a module works like inheritance i.e. if a module is included in 
a class A and class B is a subclass of A, then B has the methods of the module 
available to it.
```
class ClassName
  inlcude ModuleName
end

o = ClassName.new
o.say_hello
>> "Hello"

class ClassName2 < ClassName # ClassName2 will inherit the say_hello method
end

o2 = ClassName2.new
o2.say_hello
>> "Hello"
```
- We can mix in more than one module with a class (unlike inheritance in Ruby)

*||= (or equals operator) -> return the same value if the l-value is already* 
*initialized to something other than `false` or `nil`*
Example:
```
@stack ||= []
```

## Digression -> Ruby's shortcut operators
**+=** -> `a += 1` is equivalent to `a = a + 1`
**-=** -> `a -= 1` is equivalent to `a = a - 1`
**\*=** -> `a *= 2` is equivalent to `a = a * 2`
**/=** -> `a /= 2` is equivalent to `a = a / 2`
__\*\*=__ -> `a **= 2` is equivalent to `a = a ** 2`
**&=** -> bitwise AND
**|=** -> bitwise OR
**^=** -> bitwise XOR
**%=** -> modulo
**&&=** -> and equals

We can override the operators as well as the existing operators themselves are 
methods defined for classes e.g. `x = x + y` is a shortcut for `x = x.+(y)` where 
`.` means we are sending the `+` message to `x` with argument `y`. Example:
```
class OperatorOverload
  def +(value)
    puts "Yo #{value}"
  end
end

a = OperatorOverload.new
a + "my man"
>> Yo my man
```

## Digression -> Require/load/include/prepend/extend
`require` or `load` or `require_relative` are related to loading *files* from the 
disk whereas `include`, `prepend` or `extend` perform an in-memory operation 

- **Module** names are generally an adjective and the class names are noun. This 
practice emphasizes that modules define the behaviour

## Modules, Classes and Method Lookup
- When a message is sent to an object e.g. `obj.add`, the object looks if it has 
the method defined in its class. If it doesn't find any method defined there, it
 will check if the class includes any modules and it will try to look for the method 
definition in the module. If there are no modules included or the module doesn't 
have the method definition, it will go and look in the superclass and repeat the 
process. This movement up the hierarcy goes up to the `Object` class that includes 
the `Kernel` module (which provides the most of the common functionalities of 
the objects) and then up to the `BasicObject` class. If the method is still not 
found, it will raise an error using a speacial method `method_missing` 

*Every class that doesn't have an explicit superclass is a subclass of `Object`*

### Paradox
`Object` is a subclass of `BasicObject` which is an `Object` which itself is a 
`Class` which is an `Object`

This is a circularity in the Ruby's object model which is required to put everything
 else in place

### Duplicate method definitions
- In class and modules, in case of duplicate method definitions, the later one 
is the one that is kept or executed.
- When the module starts method lookup up the hierarchy the first method that is 
encountered is the winner.
- The same holds true if there are two modules included that provide the same 
method name. In this case, the module containing the said method that was 
included the last wins. This also implies that adding a module more than once 
doesn't have any impact and it won't change the method lookup path
```
module M
  def hello
    puts "M"
  end
end

module N
  def hello
    puts "N"
  end
end

class A
  include M
  include N
  include M
end

o = A.new
o.hello
>> N # Re-including has no impact on the path, it is discarded as already included
```

### include, prepend and extend
**include** -> class is searched for the method before the module
**prepend** -> module is searched before the class and in reverse order (same as 
include)
```
module A
  def hello
    puts "A"
  end
end

class B
  prepend A

  def hello
    puts "B"
  end
end

o = B.new
o.hello
>> A
```
In case there is a mixture of `include` and `prepend`, the module that has been 
`prepend`ed will be looked-into first and then the class methods and the `include`d
 module will be looked-into the last. The cycle will go up the hierarchy and this
 can be verified by the order of the ancestors of the class 

***We can find the list of ancestors of a class using `.ancestors` message***

**extend** -> It makes the module's methods available as the class methods and 
it doesn't show up in the class' ancestor chain
```
module A
  def hello
    puts "A"
  end
end

class B
  extend A
end

B.hello
>> A
B.ancestors
>> [B, Object, Kernel, BasicObject]
```

So, in summary method lookup happens like this:
1. Look in the modules prepended in reverse order (the one prepended the last wins)
2. Its own class
3. Look in the modules included in reverse order (the one included last wins, 
except for duplicates)
4. Go up in chain at superclass level and goto step 1 until reachec BasicObject
  - If found good, else throw `method_missing` error

### `super` keyword
































