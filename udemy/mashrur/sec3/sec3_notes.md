# Introduction to Ruby on Rails

## MVC (Model View Controller)
It provides a separation of presentation layer (what the end user sees) from 
the business logic layer (what happens in the backend)

### Model
- Any resource in the web app - users, blog posts, videos etc.
- Most commonly these are accompanied with a persistence layer (e.g. database)

### View
- The visible layer - what the user sees in their app
- Comprise of HTML, CSS, JS and *embedded ruby code*
- View files (aka *templates*) have extension of .erb (e.g. home.html.erb)

### Controller
- The logic or the brain behind the app
- Handles user requests and routing of requests or responses, auth etc.

## Installing rails
*It is assumed that Ruby is already installed and we are working on a 
Linux machine*

### Install rails
`gem install rails`

### Create a sample app
`
rails new app_name
cd app_name
rails server
`
### Verify installation
Go to a browser and navigate to localhost:3000 - a rails welcome page should
be there

## Routes
- The routes are populated in the *app_root_folder*/config/routes.rb

### Root route
- The default page which is rendered when a user navigates to the homepage
- Root routes name is **root**

### Adding a route to the routes.rb file
- root route -> *route_name* "controller#action"
- other routes -> *http_method* *route_name* *"controller#action"*

- The controllers are present in the *app_root_folder*/controllers/ folder 
- Controller names end with \_controller.rb but it is not mentioned in the 
routes.rb file - it is taken for granted by rails
- If we have a controller named "application", the corresponding class name
 will be "ApplicationController"
- Adding a route means specifying which method of which controller will be 
invoked when user visits a particular page or performs a specific action

## Controllers
- They are classes with actions defined in them
- The default controller named "application" inherits from "ActionController::Base" 
class and all the rest of the controllers inherit the "application" controller
- The default controller provides some out of the box functionalities
- When a user visits a page (or route) it redirects the request to a controller
that has methods to handle the request

### Generating controllers
- To create a new controller and the corresponding views folder with the given 
 name:
`rails generate controller name`
- It will also create a few other helper and assets resources
- The corresponding controller will be "name\_controller.rb" with the skeleton
 class
- The corresponding template will be created in app/views/*name* 
- The controller will be created in app/controllers/*name*\_controller.rb

### Setting up an action in controller
- Creating an empty function in the controller file will make rails to look 
for a corresponding template in the views folder
- The expected name will be *controller_name*.html.erb
- The name of the views template will be the same as the name of the controller 
without the \_controller part

## Structure of a Rails application
- The 'app' folder
├── app
│   ├── assets - contains the static files - images, app-wide css, config
│   ├── channels - real time communication, application cable
│   ├── controllers - houses the default application and all other controllers
│   ├── helpers - helper methods to help with views (exclusively)	
│   ├── javascript - contains all the js files, bundled using webpack
│   ├── jobs
│   ├── mailers
│   ├── models - contains all the models, default model -> application 
│   └── views - contains all the views template

- The 'config' folder - It contains all the configuration files - credentials, 
API keys, routes, development and production environment configuration etc.
- The 'db' folder - contains the testing and development sqlite3 database tables, 
schemas and migration files
- The 'Gemfile' file - we can add/remove gems here
- The 'Gemfile.lock' file - It is like pip freeze output but for gems
- The 'package.json' file - contains the node packages added using yarn

## Git discourse
### Add remote origin to a repo on local machine and push the files to remote
`git remote add origin git@github.com:someuser/somename.git`
`git push -u origin main`

## Models
- Models communicate with the database tables - it is what connects our app 
with the database
- Rails uses an ORM (Object Relational Mapper) that translates the ruby code 
into something that the database can understand. We are making queries from 
the Rails app using ruby code.
- This ORM is called 'ActiveRecord'
- There is a default 'Application' model provided with Rails that inherits 
the ActiveRecord::Base class
- All other models inherit the 'Application' model
