# Rails-Sprockets-Template

Rails 6 Template without webpacker

### Requirements
1. Ruby 3.0
2. Rails 6.1 (Latest stable version)
3. Postgres 12
4. Node js and Yarn

# Getting started

1. Create repo by clicking on use this template.
2. Clone new repo.
3. Update `.ruby-gemset` file with your project name and create gemset with same name.
4. Install bundler within `gem install bundler`.
5. Install dependencies using bundler `bundler install`.
6. Create Database and migrate `rails db:create db:migrate`
7. Start Server `rails s` and visit `http://localhost:3000`


##### Adding gems

You should use [pessimize](https://github.com/joonty/pessimize) to add the right version for new gems.

```console
$ gem install pessimize
```

Then, when adding a new gem to the Gemfile:

```console
$ bundle install
$ pessimize --no-backup
```


##### Credentials
We are using Rails way to add critical credentials
And for testing we are using Heroku and SERVER_URL ENV variable.