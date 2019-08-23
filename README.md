# Fusebox Insights

## Getting started

These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

[Ruby v2.5.5](https://www.ruby-lang.org), [Bundler](https://bundler.io/), [PostgreSQL](https://www.postgresql.org/), [NodeJS](https://nodejs.org/) and [Yarn](https://yarnpkg.com/).

### Local setup

`git clone https://github.com/TechforgoodCAST/fusebox-insights.git`
`cd fusebox-insights`
`bundle install`
`yarn install`

### Set up database

Do either of the below

#### Create a new database
`rails db:setup`  
You'll need to update `database.yml` with your local Postgres credentials.

#### Clone the existing database
`heroku pg:pull YOUR_EXISTING_DATABASE fusebox_insights_development -app fusebox-insights`  
You'll need to provide your local Postgres credentials:  
`SET PGUSER=YOUR_USER`  
`SET PGPASSWORD=YOUR_PASSWORD`

### Create a new user

If you do not have a user account on the cloned database, you will need to create a new user.  
`rails console`  
`User.create(:username => "USERNAME", :email => "EMAIL", :password => "PASSWORD")`  
Note that the password must meet a certain level of complexity.

### Get the app running

`rails s` to start local development server  
Then go to localhost:3000

### Running tests

`rails test` to run Ruby unit tests.  
`rails test:system` to run browser tests.
