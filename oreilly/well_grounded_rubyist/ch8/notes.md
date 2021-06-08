# Strings, symbols and other scalar objects

Scalar is an object that represents a single value e.g. ints, floats, strings. 
In other words they are objects that don't *contain* other objects the way 
arrays or hashes have

## Working with strings
`String` and `Symbol` are used to represent textual data in Ruby. 

### Strings
Syntax (single or double quoted literals)
```
"ABC"
'abc'
```
*String interpolation only works with double quoted strings* and we can disable 
string interpolation in double quoted string using backslashes
```
"Hello #{s = ''; rand(5..10).times { s << rand(65..91).chr}; s}"
```

Escape sequences don't have significance in single quoted strings and the 
matching quotes needs to be escaped if required inside the string. Also, we 
need to escape the escape sequences if it needs to be displayed as it is.
```
'Hello M\'Ann'
'This is printed as it is: \n \t'
"This is \nprinted on a new line"
"This is escaped escape sequence: \\n"
```

