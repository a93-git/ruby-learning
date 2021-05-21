# Section 4 - Alpha Blog application
## Resource requirements in Rails
### Model
- The naming convenction is to name it as an individual instance of the resources 
- Example - article for articles, student for students, game for games, video for videos etc. 
- The corresponding model filename will be article.rb or student.rb etc and follows *snake_case_naming_convention*
- The corresponding model class name will be in *CamelCase* e.g. Article

### Table 
- The naming convention is to name it as the plural of the model name
- Example - articles for article, students for student, games for game etc.
- "id" field in the table is automatically generated 

### Controller 


### Views

## Migration
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
- Rollingback updates the schema file and the table
- Rollingback changes is not a preferred way to perform changes to the table or schema
- The preferred way is to create a new migration file
