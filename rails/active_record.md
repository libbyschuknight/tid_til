

https://robots.thoughtbot.com/activerecords-wherenot

This query:

`User.where.not(name: 'Gabe')``

is effectively the same as this:

`User.where('name != ?', 'Gabe')``
