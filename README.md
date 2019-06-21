# Fusebox Insights

## Getting started

These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

[Ruby v2.5.3](https://www.ruby-lang.org), [Bundler](https://bundler.io/), [PostgreSQL](https://www.postgresql.org/), [NodeJS](https://nodejs.org/) and [Yarn](https://yarnpkg.com/).

### Local setup

1. `git clone https://github.com/TechforgoodCAST/fusebox-insights.git`
2. `cd fusebox-insights`
3. `bundle install`
4. `yarn install`

### Set up database

Do either of the below

#### Create a new database
5. `rails db:setup`
You'll need to update `database.yml` with your local Postgre credentials.

#### Clone the existing database
`heroku pg:pull YOUR_EXISTING_DATABASE fusebox_insights_development -app fusebox-insights`
You'll need to provide your local Postgre credentials:
`SET PGUSER=YOUR_USER`
`SET PGPASSWORD=YOUR_PASSWORD`

### Create a new user

If you do not have a user account on the cloned database, you will need to create a new user.
`rails console`
`User.create(:username => "USERNAME", :email => "EMAIL", :password => "PASSWORD", :is_staff => true)`
Note that the password must meet a certain level of complexity.

### Get the app running

1. `rails s` to start local development server
2. Then go to localhost:3000

### Running tests

- `rails test` to run Ruby unit tests.
- `rails test:system` to run browser tests.
