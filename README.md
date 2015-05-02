# BookingRoom

## Contribute

Looking for a feature to implement?

* In the [TODO](TODO.md) file, you can find features and other things that needs to be implemented.
* In [contributing](CONTRIBUTING.md) for a guide of how to submit your contributions.

## Devloping

```
git clone git@github.com:buren/booking_room.git
cd booking_room
bundle install
bundle exec rake db:create db:migrate
```

Start the server with foreman or webrick available locally on http://localhost:3000.

```
# Start with foreman (used in production)
foreman start -p 3000 # better_errors doesn't work well with foreman
# or
rails server
```

## Tests

Run the tests with

```
rspec
```

If you want to run relevant tests on file change

```
guard
```

## Delete old session data

Clean up old session data from the console:

```ruby
sql = "DELETE FROM sessions WHERE updated_at < (CURRENT_TIMESTAMP - INTERVAL '14 days');"
ActiveRecord::Base.connection.execute(sql)
```

## Tech

* Ruby >= 2.0
* Ruby on Rails 4.2
* Twitter Bootstrap 3
* jQuery 1.10
* MailGun
* Google analytics
