## Chapter 3
Page 35

>Objects reflect qualities of a real-world problem and the interactions between those objects provide solutions.
>A single object cannot know everything, so inevitably it will have to talk to another object.

Desired behaviour - an object either
- knows it personally - chapter 2 - single responsibility
- inherits it - chapter 6
- Knows another object that knows it - chapter 3 - managing dependencies

This chapter - getting access to behaviour when that behaviour is implemented in other objects.

>Well designed objects have a single responsibility, their very nature requires that they collaborate to accomplish complex tasks.
>To collaborate, an object must know something about others. Knowing creates a dependency. If not managed careful, these dependencies will strangle your application.


### Understanding Dependencies
Page 36

>An object depends on another object if, when one object changes, the other might be forced to change in turn.

```ruby

############## Page 36 ##############
class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end
# ...
end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end

  def diameter
    rim + (tire * 2)
  end
# ...
end

Gear.new(52, 11, 26, 1.5).gear_inches
```

>Gear has at least four dependencies on Wheel.

#### Recognising dependencies
Page 37

>An object has a dependency when it knows:

- the name of another class. `Gear` expects a class named `Wheel` to exist.
- The name of a message that it intends to send to someone other than `self`. `Gear` expects a `Wheel` instance to respond to `diameter`.
- The arguments that a message requires. `Gear` knows that `Wheel.new` requires a `rim` and a `tire`.
- The order of those arguments. `Gear` knows the first argument to `Wheel.new` should be `rim`, the second `tire`.

> Most of these dependencies are unnecessary and make the code less reasonable.
These dependencies will probably force changes to the code throughout the application.

>Your design challenge is to manage dependencies so that each class has the fewest possible; a class should know just enough to do its job and not one thing more.

#### Coupling between objects (CBO)
`Gear` and `Wheel` are coupled. Are dependent on each other.
>The more `Gear` knows about `Wheel`, the more tightly coupled they are. The more they behave like a single entity.

#### Other dependencies
Page 38

A few other common dependencies:
Message chaining - creates a dependency between the original object and every object and message along the way to its ultimate target. This is a Law of Demeter violation, covered in chapter 4.

Test dependent on code - new programmers tend to write tests that are tightly coupled to code. Design of tests is covered in chapter 9.

>As long as you recognise dependencies, avoidance is quite simple.


### Writing Loosely Coupled Code
Page 39

>Reducing dependencies means recognising and removing the ones (dots - glue) that you don't need.

#### Inject dependencies
>Referring to another class by its name creates a major sticky spot.

>The code above exposes an unjustified attachment to static types. It is not the class of the object thats important, it's the message you plan to send to it.

>`Gear` does not care and should not know about the class of the object. It is not necessary for `Gear` to know about the existence of the `Wheel` class in order to calculate `gear_inches`. ... it just needs an object that responds to diameter.

`Gear` know expects to be initialised with an object that can respond to `diameter`

```ruby
############## Page 41 ##############
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end
# ...
end

# Gear expects a 'Duck' that knows 'diameter'
Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
```
