# Chapter 5 - Reducing Costs with Duck Typing
Page 85

Messages are at the design centre of an application & rigorously defined public interfaces
>You can combine these two ideas into a powerful design technique to further reduces costs - *duck typing*.

>Duck types are public interfaces that are not tied to any specific class. There across-class interfaces add enormous flexibility to your application by replacing cost dependencies on class with more forgiving dependencies messages.

>if an object quacks like a duck and walks like a duck, then it class is immaterial, it's a duck.

## Understanding duck typing

Prog languages - type -> describes the category of contents of a variable e.g. defines types to hold strings, numbers, arrays etc.
Knowledge of the category of the contents of a var or its type, means an application can have an expectation about how those contents will behave.

>In Ruby, there expectations about the behaviour of an object come in the form of beliefs about its public interface. If one objects knows another's type, it knows to which messages that object can respond.

The class `Mechanic` contains the public interface for itself. Any object holding onto an instance of `Mechanic` can treat it as it is a `Mechanic`.
You are not limited to an object responding to one interface.
A Ruby object can implement many different interfaces.

>Users of an object should need not, and should not, be concerned about its class. Class is just one way for an object to acquire a public interface.
There maybe public interfaces that cut across classes in an application.
>It's not what an object *is* that matters, it's what it *does*.

### Overlooking the duck
Page 87

`Trip` `prepare` method send message `prepare_bicycles` to something referenced as `mechanic`

```ruby
############## Page 87 ##############
class Trip
  attr_reader :bicycles, :customers, :vehicle

  # this 'mechanic' argument could be of any class
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end

  # ...
end

# if you happen to pass an instance of *this* class,
# it works
class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each {|bicycle| prepare_bicycle(bicycle)}
  end

  def prepare_bicycle(bicycle)
    #...
  end
end
```

![figure 5.1](fig5_1.png)

Page 88

### Compounding the problem

Adding trip coordinator and driver classes

>`TripCoordinator` and `Driver` classes are simple and inoffensive but `Trip's prepare` method is now a cause for alarm.
>It refers to 3 different classes by name and knows specific methods implemented in each.
Risks have gone up.

```ruby
############## Page 88 ##############
# Trip preparation becomes more complicated
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each {|preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
  end
end

# when you introduce TripCoordinator and Driver
class TripCoordinator
  def buy_food(customers)
    # ...
  end
end

class Driver
  def gas_up(vehicle)
    #...
  end

  def fill_water_tank(vehicle)
    #...
  end
end
```

This code is first step in painting you into a corner. Code like this gets written when people follow existing classes blindly and neglect to notice they have overlooked important messages.

This new diagram is very complicated, this complexity is a warning.

>Sequence diagrams should always be simpler than the code they represent then they are not, something is wrong with the design. 

![figure 5.1](fig5_1.png)
