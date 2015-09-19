# Skanken

## Overview
Skanken is a worker list webapplication. It is basicly a table containing the information about the workers. Made to simplify the contact between a nations foreman and the nations workers. Skanken is open source and licensed under the MIT license.

## Contribute

Looking for a feature to implement?

* On the issues page, you can find features and other things that needs to be implemented.
* In [contributing](CONTRIBUTING.md) for a guide of how to submit your contributions.

## Devloping

```
git clone git@github.com:pbl/skanken.git
cd skanken
bundle install
bundle exec rake db:create db:migrate
```

Start the with rails available locally on http://localhost:3000.

## To test the code in production

To run the code in production in rails you need to set ENV["SECRET_KEY_BASE"]

* Open the terminal
* cd to the skanken folder
* Run ```$ rake secret ```
* Copy the output
* Open ```~/.bashrc in a text editor```
* Append the line ```export SECRET_KEY_BASE="Paste the output from rake secret here"```

Migrate the database:
```rake db:create db:migrate RAILS_ENV="production"```

```
rails server
```



## Tech

* Ruby >= 2.0
* Ruby on Rails 4.2
* Twitter Bootstrap 3
* jQuery 1.10
