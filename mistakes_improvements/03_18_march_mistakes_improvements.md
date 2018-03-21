# March Mistakes, Improvements

Asked this question:

>Just been looking at the code review template - when should we do this `Any new files begin the with # frozen_string_literal: true pragma, and/or this pragma is added to existing files as appropriate`?

got this answer:
>Basically when we add new rb files we should put that at the top
> https://freelancing-gods.com/2017/07/27/friendly-frozen-string-literals.html

Was going to add to the repo, but have already!! Remember to check here first! And to back myself!

## Working on Specs - Spec helpers

When doing some pairing with colleague for a fix to the api, on setting up a spec for a gas consumer, he looked into if there were any spec helpers that would be useful.
There was one called `readings_spec_support.rb`, which had some useful methods in it. Which could be used in the spec by including the spec helper in the file or actually using similar code from the spec helper in the spec file.
(This is an app that is HUGE!!)

Learning / improvement - look around for things that might be helpful, look at spec helpers / spec support, ask others if they know of anywhere that might have some useful stuff, rather than trying to set things up from scratch every time.


## Copying records

Have plan 1 and want to copy all costs from plan 1 to plan 2

```ruby
costs.each do |cost|
  new_cost = cost.dup # this makes a new record, associations aren't copied
  new_cost.plan_id = 2
  new_cost.save!
end
```

If wanting to copy one record:

```ruby
old_plan = Plan.find(plan_id)
new_plan = Plan.new(old_plan.attributes)

# still need to update things
new_plan.id = 44
```
