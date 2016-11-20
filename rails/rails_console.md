# Rails Console

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
