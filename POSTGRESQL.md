# Set up the application

## Install postgresql (if it's not installed)

* ```
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-common
sudo apt-get install postgresql-9.3 libpq-dev
sudo -u postgres createuser "username" -s
* ```

## Rerun the the db setup

Development:
```rake db:drop db:create db:migrate ```

Production rails:
```rake db:create db:migrate RAILS_ENV="production"```

Production heroku:
```heroku rund db:create db:migrate```

## Comment

You might have to add this to config/database.yml: 
```
username: myapp
password: password1
```

But I didn't think that is because i choice the same username for postgresql as my unix login name. It looks kind of insecure to keep that in a open file
