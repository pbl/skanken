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
* ```createuser --interactive joe```


## Rerun the the db setup
```rake db:drop db:create db:migrate ```
