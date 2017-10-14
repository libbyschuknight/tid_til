## Chapter 2 Designing Classes with Single Responsibility
Page 15

>The foundation of an OO system is the message, but the most visible organisational structure is the class.

>The problem is not one of technical knowledge but of organisation; you know how to write the code but not where to put it.

>The classes you create will affect how you think about your application forever.

- Transparent - the consequences of changes should be obvious in the code that is changing and in distant code that relies upon it.

- Reasonable - the code of any change should be proportional to the benefits the change achieves.

- Usable - existing code should be usable in new and unexpected contexts.

- Exemplary - the code itself should encourage those who change it to perpetuate these qualities.

>The first step in creating code that is TRUE is to ensure that each class has a single, well-defined responsibility.

### Creating classes that have a single responsibility
Page 17

>A class should do the smallest possible **useful** thing; single responsibility.

> A class that has more than one responsibility is difficult to reuse.


#### Determining if a class has a single responsibility
Page 22

>Replace each on of its methods with a question, asking the question ought to make sense.

>Another way to hone in on what a class is actually doing is to attempt to describe it in one sentence. Remember that a class should do the smallest possible **useful thing**. The thing ought to be simple to describe. If the simplest description you can devise uses the word "and", the class likely has more than one responsibility. If it uses the word "or", then the class has more than one responsibility and they aren't even very related.

>OO designers use the word *cohesion* to describe this concept. When everything in a class is related to it central purpose, the class is said to be *highly cohesive* or to have a single responsibility.

>... that everything the class does be highly related to its purpose.


#### Determining when to make design decisions

>Do not feel compelled to make design decisions prematurely. Resist, even if you fear your code would dismay the design gurus. When faced with an imperfect and muddled class like Gear, as yourself: *"What is the future cost of doing nothing today?"*

>When the future cost of doing nothing in is the same as the current cost, postpone the decision.

>Other developers believe that your intentions are reflected in the code; when the code lies you must be alert to programmers believing and then propagating that lie.

>This "improves it now" vs "improve it later" tension always exists. Applications are never perfectly designed/ Every choice has a price. A good designer understands this tension and minimizes costs by making informed trade offs between the needs of the present and the possibilities of the future.


### Writing code that embraces change
Page 24

>change is inevitable, coding in a changeable style has big future payoffs
>a few well-known techniques..

#### Depend on behaviour, not data

>Behaviour is captured in methods and invoked by sending messages.
>DRY

>**Hide instance variables**

always wrap instance variables in accessor methods instead of directly referring to variables. ...
Making instance variables into methods using accessor methods, changes them from data (which is referenced all over) to behaviour (which is defined once).

e.g
```ruby
class Gear
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

#####
class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

# default implementation via attr_reader
def cog
  @cog
end
```

>Send messages to access variables, even if you think of them as data.

**Hide data structures**
>If being attached to an instance variable is bad, depending on a complicated data structure is worse
Example - ObscuringReference class

```ruby
class ObscuringReferences
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def diameters
    # 0 is rim, 1 is tire
    data.collect {|cell|
      cell[0] + (cell[1] * 2)}
  end
  # ... many other methods that index into the array
end
```

```ruby
############## Page 27 ##############
# rim and tire sizes (now in milimeters!) in a 2d array
@data = [[622, 20], [622, 23], [559, 30], [559, 40]]
```

>However, since data contains a complicated data structure, just hiding the instance variable isn't enough.
>To do anything useful, each sender of data much have complete knowledge of what piece of data is at which index of the array.
>It depends upon the arrays structure. If that structure changes, then this code much change.
references are leaky, escape encapsulation, are not DRY

>Direct references into complicated structures are confusing, because they obscure what the data really is...

>In Ruby its easy to separate structure from meaning...you can use the Ruby Struct class to wrap a structure.

example

```ruby
############## Page 28 ##############
class RevealingReferences
  attr_reader :wheels
  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect {|wheel|
      wheel.rim + (wheel.tire * 2)}
  end
  # ... now everyone can send rim/tire to wheel

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect {|cell|
      Wheel.new(cell[0], cell[1])}
  end
end
```

>This style of code allows you to protect against changes in externally owned data structures and to make your code more readable and intention revealing.

>If you can control the input, pass in a useful object, but if you are compelled to take a messy structure, hide the mess even from yourself.


#### Enforce single responsibility everywhere
Page 29

**Extract extra responsibilities from methods**

>Methods, like classes, should have a single responsibility.
easy to change, easy to reuse
ask them questions about what they do and try to describe their responsibilities in a single sentence

```ruby
############## Page 29 ##############
#  2 responsibilities - iterates over wheels and calculates diameter
  def diameters
    wheels.collect {|wheel|
      wheel.rim + (wheel.tire * 2)}
  end

############## Page 29 ##############
  # first - iterate over the array
  def diameters
    wheels.collect {|wheel| diameter(wheel)}
  end

  # second - calculate diameter of ONE wheel
  def diameter(wheel)
    wheel.rim + (wheel.tire * 2)
  end
```

>Separating iteration from the action thats being performed on each element i a common case of multiple responsibility that is easy to recognise.

Extract hidden things (e.g calculation of wheel diameter) into new methods, this will make it easier to examine the class's responsibilities.

```ruby
############## Page 30 ##############
  def gear_inches
      # tire goes around rim twice for diameter
    ratio * (rim + (tire * 2))
  end

############## Page 30 ##############
  def gear_inches
    ratio * diameter
  end

  def diameter
    rim + (tire * 2)
  end
```

>The refactoring does not alter how diameter is calculated; it merely isolates the behaviour

>Do these refactorings even when you do not know the ultimate design. They are needed, not because the design is clear, but because it isn't. You do not have to know where you're going to use good design practices to get there. Good practices reveal design.

>The impact of a single refactoring like this is small, but the cumulative effect of this coding style is huge. Methods that have a single responsibility confer the following benefits:

- expose previously hidden qualities
  >Refactoring a class so that all of its methods have a single responsibility has a clarifying effect on the class.

- avoid the need for comments
  >If a bit of code inside a method needs a comment, extract that but into a separate method.

- encourage reuse
  >Small methods encourage coding behaviour that is healthy for your application.

- are easy to move to another class
  >Small methods lover the barriers to improving your design.


**Isolate extra responsibilities in classes**
Page 31

>Once every method has a single responsibility, the scope of your class will be more apparent.
>Your goal is to preserve single responsibility in Gear while making the fewest design commitments possible. Because you are writing changeable code, you are best served by postponing decisions until you are absolutely forced to make them.

Gear example, with the Wheel Struct extended with a block.

```ruby
############## Page 32 ##############
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @wheel     = Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + (tire * 2)
    end
  end
end
```

>If you identify extra responsibilities that you cannot yet remove, isolate them. Do not allow extraneous responsibilities to leak into your class.

**The real wheel**
Page 33

```ruby
############## Page 33 ##############
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end
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

  def circumference
    diameter * Math::PI
  end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference
# -> 91.106186954104

puts Gear.new(52, 11, @wheel).gear_inches
# -> 137.090909090909

puts Gear.new(52, 11).ratio
# -> 4.72727272727273
```

## Summary
The path to changeable and maintainable OO software begins with classes that have a single responsibility. Classes that do one thing isolate that thing from the rest of your application. This isolation allows change without consequence and reuse without duplication.
