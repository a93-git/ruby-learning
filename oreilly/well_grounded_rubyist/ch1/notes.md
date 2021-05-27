# Bootstrapping your Ruby literacy
- *Ruby* is a programming language, *ruby* is its interpreter
- *irb* is the REPL; can be started with ```irb --simple-prompt```

## Variables
### Local Variables
- Start with a lowercase letter or \_
- Snake case by convention
### Instance Variables
- Store information within individual objects of a class
- **Always** starts with an **@**
- Can have an uppercase after @ but never a digit
### Class Variables
- Store information at class level
- **Always** starts with double **@**
### Global Variables
- Start with **$**
- Some pre-defined global variables are: $:, $1, $/, $stdin, $LOAD_PATH
- These must be in all uppercase separated by \_ 

## Constants
- Must be **CamelCase** or \_ separated uppercase

## Keywords
- \_\_FILE\_\_ -> Current files name

## Method names
- Same naming convention as local variables
- They can end in **?**, **!** or **=**
- "Methods don't call attention to themselves as methods but rather blend into 
the texture of program as expressions that provide a value"

## Method calls, messages and Ruby objects
- All values and data structures in Ruby are objects
- Each object understands some _messages_
- A _message_ is a method that the object can invoke
```x = "1000".to_i # Here to_i is message and "1000" is object```
- Invoking a method like above is called "sending a message to object"
- In Ruby objects can intercept unknown messages (for which there is no known 
method) using *method_missing* method
-    Converting a base n number to decimal integer
``` x = "100".to_i(9)```
-    Here "100" is treated to be a base 9 number

- In Ruby, **objects** are more important than **class**
- A **class**' sole purpose is to instantiate an **object**
- Once an object has been instantiated it can change, acquiring methods and 
behaviours that weren't defined in their class

## Checking Ruby files for syntax errors
```ruby -cw filename.rb```

## puts, print and p
- puts - print a line and append a newline if there isn't one already
- print - print a line without adding anything
- p - print a line with extra information about what it is printing

## Reading input 
- ***gets*** - from STDIN
- ***File.read(filename)*** - from a file
- ***gets.chomp*** - Strip the trailing newline char
## Writing output
- *filehandle*.puts 
```
fh = File.new("temp.out", "w")
fh.puts fahrenheit
fh.close
```

***rbconfig*** is an interfact to compiled-in configuration information about 
Ruby installation
- It can be loaded using ```irb --simple-prompt -r rbconfig```

- Things loaded in the program at the runtime can be called - Features,
extensions or Libraries
- In Ruby, extensions, generally, mean a library written in C language
- Library - a set of features that is available to be loaded

## Loading external files and extensions 
### load
- Ruby tries to load the specified **file** when it encounters a load statement
- If the file is in current dir it will be loaded, else Ruby looks for the file 
in the *load path*
- Syntaxt ```load "module_name.rb"
- The current directory is automatically included in the load path
- Load path can be seen from console using ```ruby -e 'puts $:'```
-    Here -e flag to the interpreter means that what follows is an inline script
- The current directory is not present in the output of the load path
- We can use relative paths in the load statement
- load is a method that can be wrapped in a conditional call, can be called 
anywhere in the file
- We can also specify a complete path for the file to be loaded 
- load-ing a file always reloads the file; meaning that the contents are reloaded

### require
- Major difference between require and load is that it mulitple calls to the
 require statement with the same file name won't reload it.
- We don't *require* a *file*, rather a *feature* and thus, no extension needs 
to be provided
- Syntax: ```require './loadee'```
- it allows us to treat extensions written in Ruby the sam ways as the extensions
written in C
- It also accepts the complete path

### require_relative
- Searches for features relative to the directory it was called from

## Default Ruby tools and applications
- ruby - interpreter
- irb -REPL
- gem - library management
- rdoc and ri - documentation
- erb - templating system
- rake - Ruby make
