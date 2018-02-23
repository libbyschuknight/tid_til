# Rails Console

[Rails Console](https://thoughtbot.com/upcase/videos/rails-console)

- using `pry-rails`

### Accessing Helper methods

[Quick Tip: Helper Methods in the Rails Console?](http://code-worrier.com/blog/helper-methods-in-console/)

```bash
include ApplicationHelper
#  Object < BasicObject

helper.in_local_time(time)
#  Wed, 05 Oct 2016 00:00:00 NZDT +13:00
```

### RAILS_ENV

Make sure you are running the production env on the server when ssh-ing in and going into console
```bash
RAILS_ENV=production bundle exec rails c
```


### Changing Time

Need to take day today and get the start of the day as a time and then convert to UTC and follow the iso8061 format.

In `rails console`:


```bash
Time.zone = "Wellington"
# default time zone for Rails is UTC

Time.now.in_time_zone.beginning_of_day
# Mon, 24 Apr 2017 00:00:00 NZST +12:00

Time.now.in_time_zone.beginning_of_day.utc
# 2017-04-23 12:00:00 UTC

Time.now.in_time_zone.beginning_of_day.utc.iso8601
# "2017-04-23T12:00:00Z"
```

Can just do the last one, but wanted to show the different outputs.

To check that I have UTC time for the start of the NZST day:

```bash
Time.parse("2017-04-23T12:00:00Z")
# 2017-04-23 12:00:00 UTC

Time.parse("2017-04-23T12:00:00Z").in_time_zone
# Mon, 24 Apr 2017 00:00:00 NZST +12:00
```

## sandbox
http://guides.rubyonrails.org/command_line.html#rails-console
>going `bundle exec rails c production --sandbox` is super handy
>everything you do is in a transaction that is rolled back when you exit the console
Thanks @terrcin


## rake routes

[5.1 Listing Existing Routes](http://guides.rubyonrails.org/routing.html#listing-existing-routes)

Specific rails command - `rails routes -g user`

[How To Search Rails Routes](https://www.natashatherobot.com/search-rails-routes/#)

console / unix command

```bash
rake routes | grep user

# search of my minishop project

user_reads        GET    /users/:user_id/reads(.:format)             reads#index
                  POST   /users/:user_id/reads(.:format)             reads#create
new_user_read     GET    /users/:user_id/reads/new(.:format)         reads#new
edit_user_read    GET    /users/:user_id/reads/:id/edit(.:format)    reads#edit
 user_read        GET    /users/:user_id/reads/:id(.:format)         reads#show
                  PATCH  /users/:user_id/reads/:id(.:format)         reads#update
                  PUT    /users/:user_id/reads/:id(.:format)         reads#update
                  DELETE /users/:user_id/reads/:id(.:format)         reads#destroy
user_invoices     GET    /users/:user_id/invoices(.:format)          invoices#index
                  POST   /users/:user_id/invoices(.:format)          invoices#create
new_user_invoice  GET    /users/:user_id/invoices/new(.:format)      invoices#new
edit_user_invoice GET    /users/:user_id/invoices/:id/edit(.:format) invoices#edit
user_invoice      GET    /users/:user_id/invoices/:id(.:format)      invoices#show
                  PATCH  /users/:user_id/invoices/:id(.:format)      invoices#update
                  PUT    /users/:user_id/invoices/:id(.:format)      invoices#update
                  DELETE /users/:user_id/invoices/:id(.:format)      invoices#destroy
     users        GET    /users(.:format)                            users#index
                  POST   /users(.:format)                            users#create
  new_user        GET    /users/new(.:format)                        users#new
 edit_user        GET    /users/:id/edit(.:format)                   users#edit
      user        GET    /users/:id(.:format)                        users#show
                  PATCH  /users/:id(.:format)                        users#update
                  PUT    /users/:id(.:format)                        users#update
                  DELETE /users/:id(.:format)                        users#destroy
```
