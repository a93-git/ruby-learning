# Section 4 - Alpha Blog application
## Resource requirements in Rails
### Model
- The naming convention is to name it as an individual instance of the resources 
- Example - article for articles, student for students, game for games, video for videos etc. 
- The corresponding model filename will be article.rb or student.rb etc and follows *snake_case_naming_convention*
- The corresponding model class name will be in *CamelCase* e.g. Article
- The models reside in the app/models directory and can be created manually

### Table 
- The naming convention is to name it as the plural of the model name
- Example - articles for article, students for student, games for game etc.
- "id" field in the table is automatically generated 

### Controller 


### Views

## Migration
- Migration *migrates* the changes in the migration file to the actual database
- It is a method to alter the database schema over time
- It helps various teams to be aware of the changes and provides consistency
- It is DB agnostic as it uses a Ruby DSL and we don't have to write SQL queries
- We can rollback migrations as well (deleting the table) 

### Generating migration file
- `rails generate migration migration_name`
- It will create a migration file in the db/migrate directory with the name *timestamp*\_*migration\_name*.rb
- The class name in the migrate file will be of the form *MigrationName*
- The timestamp part of the migration file name is used by Rails to track these migrations
- So, instead of doing it by hand, we use a generator as described above
- It will also fill in the code to create a table with the *name* part of the *migration\_name* - not in all cases\*

### Running migration
- To run the migration: `rails db:migrate` from within the application root
- Running the migration will create a schema.rb file in the db directory
- Running this command runs any new migration file or any migration file that has not been run yet since the last time the command was issued
- Editing a migration file that has already been run and then running the migration won't impact the table - we need to rollback it first and then edit the migration file and then run the migration again
- To rollback the migration: `rails db:rollback` 
- Rollingback updates the schema file and the table - Rollingback changes is not a preferred way to perform changes to the table or schema
- The preferred way is to create a new migration file

## Models
### Create a new model
- Create a model file in app/models directory
- Create a class with the same name as the model file in CamelCase
- Make the model class inherit the ApplicationRecord class
### CREATING new entries to the database using model
#### Using Rails Console
- Open Rails console from the application root: `rails console`
1. Create and save a new object in the table corresponding to this model's table: `ModelClassName.create(fieldName: "fieldValue", ...)`
2. Create a new model object by running:
`object_name = ModelClassName.new`
`article.field1 = fieldvalue`
`article.field2 = fieldvalue`
`article.save`
3. Or, the third method is to use the constructor to create the object
`object_name = ModelClassName.new(field1: "fieldValue", field2: "fieldValue", ...)`
`object_name.save`

### READING, UPDATING and DELETING entries in the table
#### Reading
- List all the objects in the table corresponding to a particular model: `Article.all`
- Find the first article: `Article.first`
- Find the last article: `Article.last`
- Find article by ID: `Article.find(id)`
#### Updating
- Use a variable to store the output of the search, e.g.:
`article = Article.first` or,
`articles = Article.all`
- Use setters to update individual fields, e.g.:
`article.title = "Modified title"`
`article.save` to save the article to the table
#### Deleting
- Use a variable to store the output of the search, e.g.:
`article = Article.first`
- Delete the item using the 'destroy' method
`article.destroy`
- NOTE: The item is deleted right away and the change is committed to the table without using the save operation

## Model Validations
- Field validations e.g. the title should not be empty or the length should be between a given maximum or minimum value
- Validation is specified in the model file e.g. article.rb in the Article class
- It start with the *validates* keyword and then contains the field that needs to be 
validated followed by a comma and then the properties to validate e.g.:
1. presence - the field value shouldn't be nil e.g. presence: true
2. length - the field length should be within a given range e.g. length: {minimum: 5, maximum: 100}
- To reload the model file after the changes in the Rails console use `reload!`
- To check the error messages while saving the item to the database, use - 
`item.errors.full_messages`

## Routes, Actions and Views
- In order to get all the routes for a resource (or model) update the 
routes.rb file and add the keyword `resource` followed by the name of the 
resource
`resource :article`
- To verify the routes use `rails routes --expanded`
- Adding a resource parameter adds all the default routes for the resource
- To specify which routes are created, use:
`resources :article, only: [:show, :update]`

## Naming conventions
- The model file start with lowercase and has snake case; its name is the singular of resource that we are creating
- Model file is a standalone file in the app/models directory
- Controller is a file in the app/controllers directory. Its name starts with 
lowercase and is appended with \_controller.rb
- Each controller has a separate folder in the app/views directory
- The views directory name is controller name minus the \_controller.rb part
- The corresponding views directory contains individual templates for the 
individual actions defined in the controller
- The name of the class in the controller is in *CamelCase* and inherits from the 
ApplicationController base class

## Forms
### Form helper
- *form_with* helper submits the form using ajax but it can be configured to 
submit the form via HTTP method as well
- We need to provide the model we are working with using the *scope* parameter 
as a symbol. Then we need to provide the *url* or the location where the form 
will be submitted. This will serve as the action attribute for the form element
- To specify that we want to use HTTP method instead of AJAX we need to 
provide the `local: true` attribute as well 
- The `|f|` in the syntax below is the local variable name for the form
- The url is appended with `_path` which is Rails' way of specifying urls
- Syntax
`<%= form_with scope: :article, url: articles_path, local: true  do |f| %>`
`	<p>`
`	<%= f.label: :title, "Title" %><br>`
`	<%= f.text_field: :title %>`
`	</p>`
`	<p>`
`	<%= f.label: :description, "Description" %><br>`
`	<%= f.text_area: :description%>`
`	</p>`
`	<%= f.save %>`
`<% end %>`

### Corresponding controller actions
- There are total 7 controller actions:
  - index
  - show
  - new
  - edit
  - create
  - update
  - destroy 
- We define the model variables as class variables ie. starting with *@*
- These variables then can be accessed in the corresponding view template 
- In the *create* action, we need to use the following pattern to handle any 
errors:
```
if @article.save
  do something
else
  do something else
end
```
- Here the *@article.save* action saves the data in the *@article* variable to 
the corresponding database table
- If there are any errors while saving the item the check will fail and then 
the else clause will come in effect
- To access the error messages, we can check if there are any messages first 
and then display the messages accordingly in our view. Add the following to the
 view template:
```
<% if @article.errors.any? %>
<ul>
<% @article.errors.full_messages.each do |message| %>
<li><%= message %></li>
<% end %>
</ul>
<% end %>
```

### Permitted parameters
- In any of the controllers where params are required, use:
```
@article = Article.new(params.require(:article).permit(:title, :description))
```
- *:article* in the params.require is the name of the parameter hash
- *:title, :description* in the .permit() block are the hash symbols we are 
looking for in the *:article* hash

### Flash messages
- To display notifications (e.g. article was saved successfully) we can use 
flash messages
- flash messages can hold 2 types of values: :notice, :alert
```
flash[:notice] = "Article saved successfully"
```
- It should be put in the *application* view page in the views/layouts dir 
before yield
```
<% flash.each do |name, msg| %>
  <%= msg %>
<% end %>

## REST
- Rails *resources* provide REST-ful routes to rails resources
- REST - REpresentational State Transfer
- REST maps HTTP verbs (POST, GET, PUT/PATCH, DELETE) to CRUD actions in Rails
 (create/save, show/index, edit/update, destroy)













