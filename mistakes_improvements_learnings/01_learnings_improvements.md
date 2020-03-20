# Learning and improvements

The aim of this is to have a list of things I have realised I could do to get better, or other people have suggested.

## Plan and then ask

When starting a new story/card/ticket, plan my approach and then get someone elses though on my approach before I start diving into the code.

## Ask questions

When I am reviewing work from a senior, it is okay to ask lots of questions to help understand what is going on.

And to push back against things you think might not be quite right around patterns / code smells, issues.

## Read files working in way more carefully, take the time to do this

First story, new job, dived right into it. Was simple, just needed to add some attributes to an JSON output that was being generated. This attribute needed to return `true` or `false`. Thought I had it sorted but it was returning `"true"` or `null`.

It was for a `User` model and a `Group` model. As I was working through this, one of the files was a `concern`. I haven't really worked with Rails concerns before and didn't really pay attention to it.

```ruby
class User < ApplicationRecord
  # Concerns, mixins
  include Options

  # ...
end
```

The `concern` file looked like this:

```ruby
module Options
  extend ActiveSupport::Concern

  def option_enabled?(option)
    option = option.to_s
    (options || {})[option].present?
  end

  def enable_option(option)
    option = option.to_s
    return if option_enabled?(option)
    self.options = {} if options.nil?
    self.options[option] = true
  end

  def enable_option!(option)
    enable_option(option)
    save!
  end
end
```

I didn't read either of these carefully enough and didn't pay enough attention to the fact that the `User` model was including a `concern` and that the `Options` module was a Rails concern.

I should have read the methods in the concern carefully and figured out exactly what was happening.

Would it have been helpful to have asked for help sooner? Not sure about this, as I might not have learnt the things I have and been doing this reflecting now.
