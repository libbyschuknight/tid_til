# Patterns / Ideas

A comment I added in a code review:

```ruby
class TransactionsController
  def index
    ...
  end

  def refund
    ...
  end
end
```

>The changes I have been making in here I have moved towards using the RESTful/ CRUD action mapping and avoiding adding in different controller actions. The aim being to try and keep controllers tidy, and with the thinking that if there are other actions, there maybe it is time for another object/controller.

Thoughts from a senior:
>Ah the eternal REST debate, is refund a resource, in which case you would have a RefundsController with a Create action, or is it a non-crud action on a payment transaction resource. How do REST and CRUD relate, and does being RESTful mean using only CRUD actions.
>I don't think so, because it feels like we are forcing complex business scenarios into a Create-Read-Update-Delete pattern for no apparent reason. A guiding principle I follow is:
*Does this thing make sense as a resource on it's own? If so, it should be a resource. If not it should be an action on another resource.*

>What would the JSON API for a refund object look like? Would it be exactly the same as that for a payment transaction?
>Can we imagine any other actions we might want relating to refunds?
>There's no right answer...
