# [Refinery](http://www.refinerycms.com/)

### [Guides](http://www.refinerycms.com/guides)
These are pretty good once I got my head around them being out of date:
>This guide is based on Refinery CMS 2.1.0 so some of the code shown here may not work in earlier versions of Refinery.

and the most up to date version of Rails being 5, but Refinery not working with 5 yet, and having to create a Rails up with an older version of Rails.

Which I realised further down the Getting Started page can be done like this:

```
rails _3.2.15_ new rickrockstar -m http://refinerycms.com/t/2.1.0
```

I did
```
rails _4.2.7.1_ new rickrockstar -m http://refinerycms.com/t/3.0.4
```
as that is the most recent Rails version before 5, and the most up to date RefineryCMS version.

changing the default db and skipping test-unit
```
rails _4.2.7.1_ new learn-2-code-nz -m http://refinerycms.com/t/3.0.4 --database=postgresql --skip-test-unit
```



## Karate site
Generations

```ruby
rails generate refinery:engine singular_model_name attribute:type [attribute:type ...]

rails generate refinery:engine person first_name:string last_name:string photo:image dojo:string

rails generate refinery:engine grade dan:boolean level:integer

# here added it into 
rails g refinery:engine grade dan:boolean level:integer  --extension people --namespace people

rails generate migration AddGradeToRefineryPeople grade_id:integer
```
