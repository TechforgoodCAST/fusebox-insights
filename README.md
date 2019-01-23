# Fusebox Insights

## Getting started

These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

[Ruby v2.5.3](https://www.ruby-lang.org), [Bundler](https://bundler.io/), [PostgreSQL](https://www.postgresql.org/), [NodeJS](https://nodejs.org/) and [Yarn](https://yarnpkg.com/).

### Local setup

1. `git clone https://github.com/TechforgoodCAST/fusebox-insights.git`
2. `cd fusebox_insights`
3. `bundle install`
4. `yarn install`
5. `rails db:setup`
7. `rails s` to start local development server

As the database will likely be empty you will need to create a new `User` from the `rails console` to make use of the site.

### Running tests

- `rails test` to run Ruby unit tests.
- `rails test:system` to run browser tests.
