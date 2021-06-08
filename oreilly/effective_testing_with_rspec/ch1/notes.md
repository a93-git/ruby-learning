# Getting started with RSpec

## Install RSpec

`gem install rspec`

## Terminology

1. Spec -> Short for specification; defines the desired behaviour of a code
2. Example -> shows how a particular Api is intended to be used (starts with `it`
and ends with `do`
3. Example group -> Contains a set of examples (like a test suite) starts with `RSpec.describe`
4. Expectation -> Asserts that the output of the Act meets expectation (starts with `expect`

## Writing specs

```
require 'rspec'

RSpec.describe 'what we are testing' do
  it 'example` do
    Arrange

    Act

    Assert
  end
end
```

## Purpose of specs

1. Documents what our APIs (code, classes, modules) should do
2. Verifies that it does so

## Reduce duplication by segregating setup code
The setup code by any of the below methods is run once before each example's 
execution. 

1. Hooks - `before { @sandwich = Sandwich.new }` runs before any of the examples. 
2. Helpers - a helper method that returns what is required, uses memoization. 
Not suitable for scenarios where we want to store nil values or expect some objects 
to store nil values as it will run the or operation again and again

```
def sandwich
  @sandwich ||= Sandwich.new
end
```

3. `let` declarations - `let(:sandwich) {Sandwich.new}` -> binds a name to the 
result of the computation block

## Miscellanious

1. Check if a collection is empty: `be_empty`
2. Check if a something is: `to`
3. Check if something is not: `not_to`

