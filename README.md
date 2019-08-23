# Fusebox Insights

## Getting started

These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

[Ruby v2.5.5](https://www.ruby-lang.org), [Bundler](https://bundler.io/), [PostgreSQL](https://www.postgresql.org/), [NodeJS](https://nodejs.org/) and [Yarn](https://yarnpkg.com/).

### Install the app

1. `git clone https://github.com/TechforgoodCAST/fusebox-insights.git`
2. `cd fusebox-insights`
3. `bundle install`
4. `yarn install`

### Set up the database

`rails db:setup` (you may need to update `database.yml` with your local Postgres credentials).

### Run the app locally

`rails s` to start local development server then go to localhost:3000.

You will need to create a new user account to sign in, e.g. `rails c` then `User.create(full_name: "My Name", email: "my@name.org", password: "Pa55w0rd")`.

### Running tests

`rails test` to run Ruby unit tests.

`rails test:system` to run browser tests.
