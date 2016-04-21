# Work Flow / Process
> How I try to approach developing a story / writing code


### At the Very Beginning
- be clear about the story and what you are aiming to achieve
- be clear about how approaching task
- only focus on this task, don't get sidetracked by how it fits in with other bits / keep focused on the story
- at the beginning work out exactly what the story is about and clarify things as needed
- draw diagrams of what is happening to help with understanding where at and what want to achieve
- be staunch about only doing what the task is and not doing anything else

#### Definition of a Story
###### [What is a User Story?](https://www.mountaingoatsoftware.com/agile/user-stories)

User stories are short, simple descriptions of a feature told from the perspective of the person who desires the new capability, usually a user or customer of the system. They typically follow a simple template:
> As a <type of user>, I want <some goal> so that <some reason>.

User stories are often written on index cards or sticky notes, stored in a shoe box, and arranged on walls or tables to facilitate planning and discussion. As such, they strongly shift the focus from writing about features to discussing them. In fact, these discussions are more important than whatever text is written.

### TODO: add Simons definition


### At the Beginning of Coding

**RUN THE TESTS!!**

If tests fail, reset the test database: `rake db:test:prepare`  
and remember to reset the development database: `rake db:reset` (depending on what rake tasks are set up).


### When writing code

Remember to:
- look at refactoring code BEFORE creating pull request
- single responsibility methods, rather then lots of logic in one method or (god forbid) in the initialize method!

E.g
Before:

```ruby
def initialize(bubbles)
  @bubbles = bubbles

  begin
    @bubbles = bubbles.collect do |bubble|
      facade = Facades::BubbleFacade.new(bubble)
      facade.extend(Resources::Representers::Bubble)
    end
  rescue Sequel::DatabaseError
    @bubbles = []
  end
end
```

After:
```ruby
def initialize(bubbles)
  @bubbles = wrap_in_facades(bubbles)
end

def wrap_in_facades(bubbles)
  begin
    bubbles.map { |bubble| wrap_in_facade(bubble) }
  rescue Sequel::DatabaseError
    []
  end
end

def wrap_in_facade(bubble)
  facade = Facades::BubbleFacade.new(bubble)
  facade.extend(Resources::Representers::Bubble)
end
```

### Strategies for solving difficult things

##### Adding things in
If you have working code and you want to add to it (might be refactoring or adding DSL) and it is providing difficult, revert code back to working and then add bits back in one at a time.
Make it as general as possible.

For example when trying to add in more `params` to Grape API endpoint:

```ruby
desc "Receive all data for changing a bubble"
  params do
    requires :change_bubbles, type: Array # this is what works
  end
  post "/bubble_event" do
    bubble_id = params[:change_bubbles][1][:id] # don't want to use index on array

    if Bubble.process_change_bubble(params: params, bubble_id: bubble_id)
      status 200
    else
      status 400
    end
  end
```
Was aiming to access the `id` in the JSON array without using index of the array. Each element of the array holds a different Hash with different keys/values. And it is the second element  that has the first `id`

Did try:
- `type: Array[JSON]`
- `given`, `values`, `optional`
from https://github.com/ruby-grape/grape#parameter-validation-and-coercion
