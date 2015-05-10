# Set up the application

## Set ENV["SECRET_KEY_BASE"]

* Open the terminal
* cd to the skanken folder
* Run ```$ rake secret ```
* Copy the output
* Open ```~/.bashrc in a text editor```
* Append the line ```export SECRET_KEY_BASE="Paste the output from rake secret here"```

## Install postgresql (if it's not installed)

* ```$ sudo apt-get install postgresql postgresql-contrib```
* ```sudo -u postgres psql postgres```
* Set password by running
* ```\password postgres```
* And then set your password when prompted
* Create a postgresql user, when prompted
* Createuser by running and select the user to be a superuser
* ```createuser --interactive the_user_name```

## Rerun the the db setup

Development:
```rake db:drop db:create db:migrate ```

Production:
rake db:create db:migrate RAILS_ENV="production" 

## Comment

You might have to add this to config/database.yml: 
username: myapp
password: password1

But I didn't think that is because i choice the same username for postgresql as my unix login name. It looks kind of insecure to keep that in a open file
