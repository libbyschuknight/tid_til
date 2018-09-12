# September / October / November Mistakes, Improvements, Stuff

## Translation (yaml) files in Rails

Working at adding a new thing to an Rails app that uses translation files to do lots of stuff.

Copied a `en.yml` file that already existed and needed to update the name of it and some other things in it.

Fired up the server and got this error:

```
I18n::InvalidLocaleData
can not load translations from /Users/libby/flux/powershop/nz/brands/meridian/en.yml: #<Psych::SyntaxError: (/Users/libby/flux/powershop/nz/brands/meridian/en.yml): did not find expected key while parsing a block mapping at line 2 column 3>
```

Thought it might have been other things to do with stuff I was changing. Asked a friend who suggested `check your yml for missing "`.

So I did and this and while making changes to it, I accidently put an extra `z` somewhere:

```yaml
en-NZ-realsurf:
  company_name: Real Surf

  contact_hours: "8am to 8pm, Monday to Friday"
  contact_hours_business: "9am to 5pm, Monday to Friday"z
```
Removed it and yay it works!! Such a small thing! A reminder to be careful when changing things and to check and re-check!

