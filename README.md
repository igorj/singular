# Singular: Sinatra-Angular.js starter application

Singular is a starter application for dynamic web applications with Angular.js frontend and Sinatra-JSON backend.

It uses Bundler, NPM and Twitter Bower for managing dependencies.
It uses Grunt as build tool.
It uses MiniTest for ruby unit tests, Karma and Jasmine for JavaScript unit tests and Capybara, PhantomJS and Poltergeist for webtests.
It uses Twitter Bootstrap and SASS for layout
It uses Mongo as persistence store
It offers live reload and autotest for all unit tests
It uses Git for source control and BitBucket as remote git repository
It is deployed on Heroku
It uses Foreman for running the application on Heroku

## Installation

**npm install**: Install all node.js modules defined in *package.json* to *node_modules*
**bower install**: Install all Bower components defined in *component.json* to *public/vendor/components*
**bundle install**: Install all ruby gems defined in *Gemfile*

## Create admin user

In development:
RACK_ENV=development ruby app/server/init.rb

In production:
RACK_ENV=production ruby app/server/init.rb

## Configuration

Configuration is done with environment variables.
For development, env-variables should be defined in the RubyMine Run/Debug configuration
For production, env-variables are defined with the heroku config command-line tool

Following environment variables should be set:

- SESSION_SECRET
- AMAZON_ACCESS_KEY_ID
- AMAZON_SECRET_ACCESS_KEY
- MONGOLAB_URI (only in production)

## Run the application in development

**rackup -p 4000**: Starts the Sinatra application
**grunt watch**: Compiles the client and watches for any changes to do live reload in the browser
**grunt autotest**: Watches for any changes and run the Jasmine unit tests

Open in the browser: <http://localhost:4000>

## Deploy to Heroku

**grunt deploy**

## Database backup and restore

Backup from production:

mongodump -h ds053937.mongolab.com:53937 -d heroku_app14448348 -u heroku_app14448348 -p <password> -o backup

Restore from production:

mongorestore -d translations --drop backup/heroku_app14448348



