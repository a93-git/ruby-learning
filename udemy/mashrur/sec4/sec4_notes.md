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






















