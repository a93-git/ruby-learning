# Control flow techniques

## Conditional execution
Controlling the flow of execution based on certain conditions

### if condtions
Syntax
1. Entire `if` statement on a single line using `then` clause if there are no `else`s
```
if (x > 10) then puts x end
```
2. Entire if statement on single line using semicolons to mimic line breaks
```
if (x > 10); puts x; end
```
3. if / elsif / else
```
if (x > 10)
  puts "Yo"
elsif (x < 0)
  puts "What's up?"
else
  puts "What!!!"
end
```

If no conditions are met the `else` clause will be executed. If there are no else
 clauses, the block terminates and returns `nil`. The keyword `nil` evaluates to
 false itself

We can have nested if statements up to an arbitrary depth

To negate the output of a condtion we can use `not` keyword or `!` operator or 
`unless` keyword. `unless` is equivalent to saying `if not` or `if !`
```
if not (x == 1) then puts "What!!!" end

if !(x == 1) then puts "What!!!" end # Always use parentheses when using ! operator
# This is because ! has higher precedence than `==` operator and it will be 
# executed first so that ! x == 1 will be evaluated as !(x) == 1

unless (x == 1) then puts "Yo" end 
```

We can use `unless` with `else` but it is not a good practice

There is another construct of **condtional modifiers** for simple conditions where
 we don't need an `end` statement. The syntax is `puts "Yo" if (x > 100)`. Here 
we are adding the condition at the end of the statement. But we can't use 
branching and we shouldn't use it with long statements.

### Value of if statements
On a successful condtion matching, the return value of `if` statement is the value 
of the code that is executed on successful matching. If no code blocks match, the 
return value is `nil`

### Local variable assignment during parsing
Whenever the Ruby interpreter encounters a local variable in an if statement or 
such a code block, memory is allocated for that variable (not the assignment) but 
the variable memory allocation takes place and if inspected, we will find that 
it has been initialized to `nil`

### Assignment in a conditional test
Assignment in conditional works as expected and the l-value is assigned the 
value on the right. Ruby will issue a warning if the condition is always going to 
be `true` e.g. `if x = 1` -> this condition is always going to be `true` no matter 
what. 

Such warning is not produced if it is not confirmed that the expression will 
always evaluate to `true` e.g. `if x = y` or `if x = methodcall()` because 
the result of such an expression can be false e.g. `y` can be false or the result 
of the mathematical expression can be `false`

There is almost never a must have reason to use assignment in the conditional 
test but we can use it in cases where the return value can vary between `true`, 
`nil` and `false`

### `case` statements
Syntax
```
case variable_or_object
when "case1", "case3" # multiple match cases
  something
when "case2"
  something
else # catch all
  something 
end
```

Ruby uses the ***case equality operator*** `===` aka **case subsumption** or 
**threequal operator** with the `when` statement. It works like this:
the keyword `case` receives the string that needs to be matched and performs a series
 of tests in form of `when` statements. It goes to the first `when` statement. 
The `when` keyword sends a message to the individual 
match cases with the string as the argument. For example: if we have `when "yes", "y"` 
and the value to be matche is `no` what is happening in the backend is that Ruby 
is doing `"yes" === "no" or "y" === "no"` which in turn means `"yes".===("no") or "y".===("no")` 

It is very much possible to write a `case` conditional expression as a series of 
if-elsif-else statements. It is just a syntactic sugar around the raw method call. 
Also, we are matching objects here using `===` or threequal operator which is 
not defined for string objects and thus, it performs a character by character 
search and returns true if all the characters match each other (exactly like `==`).
If an object doesn't have that method defined, it works similar to `==` double equals operator. 

This means we can define our custom behaviour for the threequal operator for use in 
case statements. For example:
```
class A
  attr_accessor :val

  def ===(other)
    puts "Yooohoooo"
    true if val == other.val
  end
end

o = A.new
o.val = 5

o2 = A.new
o2.val = 5

o3 = A.new
o3.val = 6

case o
when o2
 puts "What!!!"
else 
  puts "No match"
end
```
### Testless case statement
A simple case statement without a test expression. The first `when` that evaluates
 to true wins and its code block is executed. It provides us the freedom to test 
anything. It is similar to (or an alternative way to write the if statement). Example
```
case
when "a" === "b"
  puts "What is this sorcery?"
when 1 === 2
  puts "What is going on here?"
else
  puts "What a beautiful life!"
end
```
The case statements return the value returned by the code in the matching code 
block. If nothing matches entire statement evaluates to false

## Looping
### `loop` loop
This loop starts with the keyword `loop` and takes in a code block withing `{}`
 if it is a single line block or we can put it within `do / end` block. We need 
to explicitly specify the exit condition. Syntax:
```
count = 0
loop do
  count += 1
  puts "Looping #{count} times"
  break if count >= 5 # exit the loop if count is greater than or equal to 5
end

puts
count = 0

loop do
  count += 1
  puts "Looping #{count} times"
  next unless count >= 5 # control goes to the break statement only if count >= 5
  break
end
```

In looping we have `next` and `break` keyword. The `next` keyword takes the control
 to the next iteration directly without executing any further statements. The `break`
 keyword breaks out of the innermost loop.

### while / until loop
Syntaxes
```
while (condition)
  do something
end

# Executed atleast once
begin
  do something
end while (condition)

until (condtion)
  do something
end

begin
  do something
end until (condtion)
```
Example:
```
n = 0

puts "Beginning while loop"
while (n < 5)
  n += 1
  puts n
end

puts "Beginning begin while loop"
begin
  n += 1
  puts n
end while (n < 10)

puts "Beginning until loop"
until (n >= 15)
  n += 1
  puts n
end

puts "Beginning begin until loop"
begin
  n += 1
  puts n
end until (n >= 20)
```

We can have while and until loop in the modifier position as well in case of single 
line statements e.g. `a += 1 while a < 10` or `a += 1 until n >= 10`. Note that the 
loop keywords in this condition don't behave like post-positioned while and until.
 Rather the opposite, if the condition is true before the loop begins the loop 
won't be executed even once.

We can structure loops within a `{}` block like any other Ruby statement that takes 
a block of code

Note: We can have multiple assignments in conditional statements as well ie. we 
can do something like this:
```
if (a, b = [3, 4]) # This evaluates to true because a and b are not nil
  puts a, b
end

>> 3
>> 4
```

### Looping based on a list of values
Using `for / in` keyword we can loop through a list of objects running through
 the code block once for each of the element in the list. Example and syntax:
```
class A
  class << self
    def double(v)
      v * 2
    end
  end
end

n = [1, 2, 3, 4, 5]

for i in n
  puts A.double(n)
end
```

## Iteration
***An iterator is a method***

Iterate over each of the elements of the iterator and execute some task. Here there 
is a switch of scope and then reversal of scope through iteration.

In case of iteration we have two things:
- *code block* - within `{}` or `do / end` block and, 
- `yield` is the keyword that yields back the control to the code block
i.e. an iterator expects a code block and has a `yield` statement to yield the 
control back to the code block

For example, *loop* itself is an iterator that yields the control back to the 
code block infinitely. An implementaion of loop construct in Ruby code would look 
like this:
```
def custom_loop
  yield while true
end

count = 0
custom_loop do
  count = count + 1
  next unless count == 10 
  break
end
```

Here, the custom\_loop method yields the control to the code block, the scope changes,
 the code in the code block is executed and then the control returns to the method.
This whole process of yielding control to the code block from the iterator and 
returning control to the iterator from the code block is happening within the 
method call itself. In other words, yield is different from return. Return marks 
the end of the method call whereas yielding takes place when the method is still 
executing

Also, a code block is the part of the Ruby syntax and it is *not* an argument

Every method call in Ruby consists of:
- a receiver or variable (default is self)
- a dot (if explicit receiver is there)
- a method name (required)
- an argument list (optional, default ())
- a code block (optional, no defaults)

```
class A
  class << self
    def test_loop(count)
      c = 0
      until c == count
        c += 1
        yield c
      end
    end
  end
end

A.test_loop(5) do |i|
  print i.to_s + " "
end
```
In the above example during method call,
- **A** is the **receiver**
- There is a **dot** required for specifying the message
- **test\_loop** is the required method name
- **(5)** represents the argument list
- Everything inside the **do / end** block is the code block

If no code block is provided and the function is yielding something nothing will 
happen because there is nothing to yield to. There are methods that still do 
something whether we provide a code block or not e.g. String#split method which 
returns a list of pieces of string split over the give delimiter. If a code block 
is provided, each of the piece is yielded to the code block for further actions.
If it is not provided, still the method works and simply returns the list.

We can use both the `do / end` expression and the `{}` for specifying the code 
block. But there is a difference of **precedence** between the both. If we are 
using the curly brackets it takes precedence over any other method calls whereas 
the do end block has a lower precedence. Example:
```
a = [1, 2, 3]
puts a.map { |n| n * 2 } # interpreted as it should be
>> [2, 4, 6]

# the code below is interpreted as puts(a.map) do/ end block -> this code block
# is for puts method. Since puts doesn't yield it discards it. Also, since the 
# map method doesn't get any code block, it returns an enumerator object
puts a.map do |n|
  n * 2
end
>> Enumerator object
```

**To reiterate, a method may yield to a code block infinite number of times but it** 
**can return only once**

When a method yields it can yield one or more values and this value can be used 
in the code block and the values are picked by the variables specified withing the 
bars `|a, b|`

The code block can return values and the method that yielded control to it can 
accept that return value, meaning we can do `a = yield c`

The block parameters are surrounded in pipes `|` rather than paretheses and follow 
the same rules of parameters as followed by instance methods. There can be multiple 
block parameters as well including default, positional and sponge.

### Code block variable scopes
Variables in outer scope are visible to the code block i.e.
```
def a
  x = 1
  1.times do
    x += 1 # Outer x is incremented, note that there are no block params
  end
  puts x
end

a
>> 2,e
```
If a block param with the same name as the variable in the outer scope is sent then the outer 
variable is masked whereas if the variable names and the param names are different 
then any changes made to the variable with outer variable name will change the outer
 variable as well, i.e.
```
def b
  x = 1
  1.times do |x|
    x += 1
  end
  puts x
end

b()
>> 1

def c
  x = 1
  1.times do |c|
    x += 1 # This is explicit overwriting
  end
  puts x
end

c()
>> 2
```

We can specify multiple block ***parameters*** by separating them with comma such as 
`something.each do |a, b|` whereas if we want to have block level ***variables*** 
that are separate from and *don't overwrite other variables in the scope* (even if 
they have the same name) we need to separate them with semicolons e.g. 
`something.each do |a, b; var1, var2|`. Note that we can't specify block params after 
we have asked for a block variable. Example:
```
def a_method
  a_hash = {"a": 1, "b": 2, "c": 3}
  var1, var2 = 10, 20
  puts "Outside code block"
  puts "var1: #{var1}, var2: #{var2}"
  puts "Entering code block"
  a_hash.each do |k, v; var1, var2|
    var1, var2 = rand(1..100), rand(1..100) 
    puts "Kye: #{k}, value: #{v}, var1: #{var1}, var2: #{var2}"
  end
  puts "Outside code block"
  puts "var1: #{var1}, var2: #{var2}"
end

a_method
```

## Exceptions
A file can be checked for syntax error using `-c` command line flag and we can 
enable the warnings using `-w` flag

Unacceptable behaviour at runtime is handled by raising and handling exceptions

An **exception** is an object that is an instance of or a descendant of **Exception** 
class 

**Raising** an exception means stopping the normal execution of the program and 
then handling the error or exiting the program

An exception can be handled by using a **rescue** clause a block of code that is 
executed when an exception is raised by another block of code

Common exceptions
- RuntimeError - Default exception raised by the `raise` method
- NoMethodError - the method is not defined for the object
- NameError - the identifier doesn't exist
- IOError - IO to an incompatible stream (writing to read only or closed etc.)
- TypeError - A method receives an argument it can't handle (can't add int and String)
- ArgumentError - Incorrect number of arguments provided

The code that needs to be handled for exceptions needs to be in a `begine / end` 
block with `rescue` clause in the middle
```
val = gets.chomp.to_i

begin
  result = 1 / val # won't work if numerator is float
rescue
  puts "Is the number zero"
  exit
end
```

Simply specifying `rescue` rescues any error that is descendant of `StandardError` 
class. We can make it more specific by specifying what to rescue e.g.
`rescue ZeroDivisionError`

It is a good practice to rescue specific exceptions to void the chances of 
covering up other problems

Inside a method or code block (which already have a begin and end specified), we 
don't need to use separate `begin - rescue - end` block (though we can to be more
 specific about the code that we want to rescue in which case we need to add an 
explicit `return` statement to exit the parent block) and we can simply put rescue at 
the end of the code block or method definition (just before the last `end` 
statement) and we have convered the whole method or block and the def and end keyword 
server the purpose of delimiting the scope of the rescue operation
```
def open_file
  puts "file to open: "
  filepath = gets.chomp
  fh = File.open(filepath)
  yield fh
  fh.close
  rescue
    puts "Couldn't open the file"
end
```
The same logic applies for the code within `do / end` block and rescue applies 
to all the statements preceding it.

### Debugging
We can debug by inserting `binding.irb` statement in our code. Where ever this 
statement is included our program stops execution and an irb session is opened 
with the current context (all the variables and other things from the context 
are available and accessible). We can exit the session using `exit` command and 
the program execution will resume from the next statement onwards
```
puts "Want number:"
val = gets.chomp.to_i
binding.irb
puts "Number is: #{val}"
```

Note that it can have side effects e.g. new exceptions being raised so it shouldn't 
be used in the production code

### Safe navigation operator
`&.` is the safe navigation operator. Using this we can ensure that `NoMethodError` 
doesn't occur. This operator tells Ruby to call the next method only if the 
receiver is not nill i.e. the current call's return value is not nil. If it *is* 
nil, then nil is returned

It is helpful while method chaining

### Raising exceptions
Exceptions can be raised using `raise ExceptionName` syntax. We can also use the 
method `raise` by itself but it will either re-raise the exception that was being 
handled or raise a generic `RuntimeError`. Note that the name of the exception object 
must be an existing one

We can also provide a second argument that is the message or we can *only* provide the 
message in which case Ruby will raise a RuntimeError with the given message
```
def a(x)
  raise ArgumentError, "Number less than 10" if x < 10
end

a(5)
```

### Capturing an exception in rescue clause
An exception object can be assigned to a variable using `=>` operator e.g. 
`rescue ArgumentError => e`. This exception object responds to messages e.g.
`message` which holds the error message and `backtrace` which holds the information 
about where the error occurred and it contains an array of strings representing the 
call stack at the time of error. Example:
```
def a
  begin
    raise ArgumentError 
  rescue ArgumentError => e
    puts e.message
    puts e.backtrace
  end
end

a()
```

The raised exceptions are instances of exception classes and not the classes itself

Calling the `raise` method on its own from within the `rescue` clause re-raises the 
same exception that was rescued

### ensure class
An `ensure` clause is used to run a block of code no matter what error occurs and 
how it is handled e.g. closing a file when error occurs while reading it.

So the complete `rescue` clause looks like:
```
begin
  # do something risky
rescue ExceptionName => e
  # handle the exception
ensure
  # must be executed no matter what whether exception raised or not
end
```

Qn: Can we do multiple rescues? What about nested rescues?
Qn: Does ensure clause get executed even if the error is not handled?

### Custom exception classes
We can create custom exception classes and we can even namespace them by defining 
them in modules or classes. Syntax:
```
class CustomException < Exception
end

def a
  puts "Start" 
  raise CustomException
  rescue CustomException => e
    puts e.message
  ensure
    puts "Error"
end 
```

It is a good practice to create custom exception classes for specific issues and 
put the exceptions in meaningful namespaces to prevent name clashes

```
begin
  class A
    begin
      class B
        begin
          module C
            class SuperDuperException < Exception
            end
            begin
              raise SuperDuperException, "Error in Module C"
            rescue SuperDuperException => e
              puts e.message
            end
          end
          raise C::SuperDuperException, "Error in Class B"
        rescue C::SuperDuperException => e
          puts e.message 
        end
      end
      raise B::C::SuperDuperException, "Error in Class A"
    rescue B::C::SuperDuperException => e
      puts e.message
    end
  end
  raise A::B::C::SuperDuperException, "Error in <main>"
rescue A::B::C::SuperDuperException => e
  puts e.message
end
```

