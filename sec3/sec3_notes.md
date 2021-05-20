# Introduction to Ruby on Rails

## MVC (Model View Controller)
It provides a separation of presentation layer (what the end user sees) from 
the business logic layer (what happens in the backend)

### Model
- Any resource in the web app - users, blog posts, videos etc.
- Most commonly these are accompanied with a persistence layer (e.g. database)
- Models communicates with the database tables

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
*route_name* "controller\_name#method\_name"

- The controllers are present in the *app_root_folder*/controllers/ folder 
- Controller names end with \_controller.rb but it is not mentioned in the 
routes.rb file - it is taken for granted by rails
- Adding a route means specifying which method of which controller will be 
invoked when user visits a particular page or performs a specific action

## Controllers
- They are classes that are sub-classes of ActionController::Base class
- When a user visits a page (or route) it redirects the request to a controller
that has methods to handle the request

