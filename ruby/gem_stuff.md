# Gem Stuff

### [bundle exec](http://bundler.io/man/bundle-exec.1.html)

>This command executes the command, making all gems specified in the Gemfile(5) available to require in Ruby programs.

[What does bundle exec rake mean?](https://stackoverflow.com/questions/6588674/what-does-bundle-exec-rake-mean)


## [Table Display](https://github.com/willbryant/table_display)

```
>> pt Customer.find(7139).purchases, :only => [:id, :purchase_price], :methods => [:start_date?]
+---------+----------------+-------------+
| id      | purchase_price | start_date? |
+---------+----------------+-------------+
| 2587972 |   '51.73'.to_d | false       |
| 2587973 |   '59.75'.to_d | false       |
| 2587974 |   '36.38'.to_d | false       |
| 2587975 |   '10.03'.to_d | false       |
| 2587976 |   '14.04'.to_d | false       |
| 2587977 |  '194.46'.to_d | false       |
| 2587978 |   '41.38'.to_d | false       |
| 2587979 |   '96.31'.to_d | false       |
...
```

```
>> pt User.all.limit(5), :only => [:id, :email, :first_name, :last_name]
+--------+--------------------------------+--------------+------------------+
| id     | email                          | first_name   | last_name        |
+--------+--------------------------------+--------------+------------------+
|   7999 | "user_7999@test@example.com"   | "Kate_7999"   | "Builder_7999"   |
| 120280 | "user_120280@test@example.com" | "Kate_120280" | "Builder_120280" |
| 138529 | "user_138529@test@example.com" | "Kate_138529" | "Builder_138529" |
| 163344 | "user_163344@test@example.com" | "Kate_163344" | "Builder_163344" |
| 167744 | "user_167744@test@example.com" | "Kate_167744" | "Builder_167744" |
+--------+---------------------------------+--------------+------------------+
```