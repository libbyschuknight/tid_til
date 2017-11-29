# Chapter 7 - Sharing Role Behaviour with Modules
Page 141

Alternative to classical inheritance, use of techniques of inheritance to share a *role*.

## Understanding Roles

>Some problems require sharing behaviour among otherwise unrelated objects.

Using roles creates dependencies and these introduce risks.

### Finding roles

>The `Preparer` duck type from Chap 5, is a role. Objects that implement `Preparers` interface play this role. `Mechanic, TripCoordinator and Driver` each implement `prepare_trip`; therefore, other objects can interact with them as if they are `Preparers` without concern for their underlying class.

>The existence of a `Preparer` role suggests that theres also a parallel `Preparable` role (these often come in pairs). The `Trip` class acts as a `Preparable` in Chap 5, it implements the `Preparable` interface.

>To play the `Preparer` role, all an object needs to do is implement its own version of `prepare_trip`.

Many OO languages have a way to define a named group of methods that are independent of class and can be mixed in to any objects.
In Ruby they are *modules*.

>Methods can be defined in a module and then the module can be added to any object. Modules thus provide a perfect way to allow objects of different classes to play a common role using a single set of code.

>When an object includes a module, method become available via automatic delegation.

>The total set of messages to which an object can respond includes:
- those it implements
- those implemented in all objects above it in the hierarchy
- those implemented in any module that has been added to it
- those implemented in all modules added to any object above it in the hierarchy


### Organising responsibilities

![figure 7.1](fig7_1.png)

>The knowledge about what values to use does not belong in `Schedule`, it belongs in the classes whose names `Schedule` is checking.
>Instead of knowing details about other classes, the `Schedule` should send them messages.


### Removing unnecessary dependencies
Page 145

>The fact that the `Schedule` checks many class names to determine what value to place in one var suggests that the var name should be turned into a message, which in turn should be sent to each incoming object.

#### Discovering the schedulable duck type

![figure 7.2](fig7_2.png)

This removes the check on class, changes method `schedulable?` to send the `lead_days` messages to its incoming target argument.

This change moves the responsibility for knowing lead days into the last object.

>The `Schedule` expects its `target` to behave like something that understands `lead_days`, that is, like something that is "schedulable". You have discovered a duck type.

#### Letting objects speak for themselves
Page 147
e.g `StringUtils.empty?(some_string)`

>This specific example illustrates the general idea that objects should manage themselves; they should contain their own behaviour. If your interest is in object B, you should not be forced to know about object A if your only use of it is to find things out about B.

>Just as strings respond to `empty?` and can speck for themselves, targets should respond to `schedulable?`. The `schedulable?` method should be added to the interface of the `Schedulable` role.


## Writing the concrete code
Page 147

`Schedulable` role only has an interface, need to add `schedulable?` method to it, must decide what the code should do and where the code should go.

![figure 7.3](fig7_3.png)

Easiest is to separate the two decisions. Add method to concrete class e.g. `Bicycle` and implement directly. Once working, can refactor to allow `Schedulables` to share the behaviour.

Code example (simple version)

```ruby
############## Page 148 ##############
class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "This #{schedulable.class} " +
         "is not scheduled\n" +
         "  between #{start_date} and #{end_date}"
    false
  end
end
```

```ruby
############## Page 149 ##############
class Bicycle
  attr_reader :schedule, :size, :chain, :tire_size

  # Inject the Schedule and provide a default
  def initialize(args={})
    @schedule = args[:schedule] || Schedule.new
    # ...
  end

  # Return true if this bicycle is available
  # during this (now Bicycle specific) interval.
  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  # Return the schedule's answer
  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  # Return the number of lead_days before a bicycle
  # can be scheduled.
  def lead_days
    1
  end

  # ...
end

require 'date'
starting = Date.parse("2015/09/04")
ending   = Date.parse("2015/09/10")

b = Bicycle.new
b.schedulable?(starting, ending)
# This Bicycle is not scheduled
#   between 2015-09-03 and 2015-09-10
#  => true
```

This hides `Schedule` and what it does inside of `Bicycle`.

## Extracting the Abstraction
Page 150

Above code solves first part of problem, has decided what `schedulable?` should do. `Bicycle` is not the right place for it though, as other things are `schedulable`. Need to rearrange so can be used by objects of different classes.

Example new `Schedulable` module.

```ruby
############## Page 150 ##############
module Schedulable
  attr_writer :schedule

  def schedule
    @schedule ||= ::Schedule.new
  end

  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  # includers may override
  def lead_days
    0
  end

end
```

`Bicycle` using `Schedulable`

```ruby
############## Page 151 ##############
class Bicycle
  include Schedulable

  def lead_days
    1
  end

  # ...
end

require 'date'
starting = Date.parse("2015/09/04")
ending   = Date.parse("2015/09/10")

b = Bicycle.new
b.schedulable?(starting, ending)
# This Bicycle is not scheduled
#    between 2015-09-03 and 2015-09-10
#  => true
```

Now that have created this module, other objects can make use of it to become `Schedulable` themselves.
>They can play this role without duplicating code.
