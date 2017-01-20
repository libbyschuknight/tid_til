# Tech Talks @ Flick
---
### Errors
20 Jan 2017

###### Result Error Object - Samson

```ruby
Result = Struct.new(:result. :data) do
  def success?
    result == :ok
  end
end
```

###### Rating Errors - using the errors app - Michael
<!-- add link to example -->

###### UI error presentation - Merrin
[How to fix a bad user interface](http://scotthurff.com/posts/why-your-user-interface-is-awkward-youre-ignoring-the-ui-stack)

THE UI STACK
- blank state
- loading state
- partial state
- error state
- ideal state

Use of `en.yml` for translating error messages
[Rails Internationalization (I18n) API](http://guides.rubyonrails.org/i18n.html#configure-the-i18n-module)

###### Right / Left, monads, Api Styles - Col
Right  / Left - wtf
Monads - wtf

Api Styles @ Flick
- http status codes
- status object structure
https://github.com/FlickElectric/how_to_tech_team/blob/master/api_styles/api.md

---
