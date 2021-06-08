# From writing specs to running them

## Formatting
The default formatting shows us the progress of tests by showing a dot for a 
successful test and a `F` for failed test

Use `rspec --format documentation` or `rspec -f d` to produce output in documentation 
format

## Profiling
Use `rspec --profile 2` to find the top 2 slowest tests

## Running specs
To run a spec, from the parent directory, run `rspec` and it will automatically 
find all the files ending with *\_spec* and run it.

To run a sepcific file or files from a specific directory, run:

```
rspec spec/unit # Load *_spec files in this and all subdirectories 

rspec spec/unit/specific_spec.rb # Load a sepcific file

rspec spec/unit spec/smoke # Load multiple directories

rspce spec/unit spec/smoke/test1.rb # Mix files and directories
```

To run examples that contain a give string, use `rspec -e string`

To run a specific test at a given line, use `rspec spec/some_spec.rb:25` -> runs 
the test in the file at line 25

To rerun failures, we first need to configure a status persistence file in the 
**spec file**, like this:

```
RSpec.configure do |config|
  config.example_status_persistence_file_path = "path/to/file"
end
```

Once configured, use `rspec --only-failures` to run the failed specs within this 
spec file (note other specs will run as it is)

### Focusing examples
If there are specs that need to be focused upon or filtered temporarily 
(for whatever reason) - can't think of a usecase now but this feature is 
available. Replace *context* with *fcontext* and *it* with *fit* and *describe* 
with *fdescribe*. Note that this change in keyword is for one place only, i.e. 
if we mark the whole example group as focused, no need 
to mark the individual examples as focused as well.

Once done, we need to configure the same spec file to run only focused tests using 

```
RSpec.configure do |config|
  config.filter_run_when_matching(focus: true)
end
```

Now when we execute `rspec` it will simply run the focused ones instead of all the 
specs. If there are no focused specs, it will run all of them.

### Tag filtering 

We can use tag filters at the CLI

```
rspec --tag last_run_status:failed
rspec --tag focus:true
```

We can also specify tags while defining an example or an example group like:

```
context 'with milk', focus: true do 
...
end
```


