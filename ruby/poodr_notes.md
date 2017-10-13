# POODR - Practical Object-Oriented Design in Ruby

## Chapter 1 Object-Oriented Design

>... a series of messages that pass between objects.
> once you acquire an object-oriented perspective the rest follows naturally

> change is unavoidable

>Applications that are easy to change are a pleasure to write and a joy to extend. They're flexible and adaptable.

>OO design is about managing dependencies.
>In the absence of design, unmanaged dependencies wreak havoc because objects know too much about one another.

>You must not only write code for the feature you plan to deliver today, you must also create code that is amendable to being changed later.

>The purpose of design is to allow you to do design later and its primary goal is to reduce the cost of change.

#### Design Principles

SOLID
S ingle Responsibility
O pen-Closed
L iskov Substitution
I nterface Segregation
D enpendncy Inversion


DRY - Dont' Repeat Yourself

**NOTE: find Sandi Metz's recent article about DRY issues**

Law of Demeter

#### Design Patterns
>Each well-known pattern is a near perfect open-source solution for the problem it solves.
>However, ... pattern abuse by novice programmers, who, in an excess of well-meaning zeal, applied perfectly good patterns to the wrong problems.

**NOTE: find out more about design patterns**

#### A Brief Introduction to OO Programming

OO Languages
>Instead of dividing data and behaviour into two separate spheres... .Ruby combines them together into a single thing, an object.
>Objects have behaviour and may contain data, data to which they alone control access. Objects invoke one another's behaviour by sending each other messages.

>Every object decides for itself how much, or how little, of its data to expose.

>Class-based OO languages...allow you to define a class that provides a blueprint for the construction of similar objects
A class defines methods (definitions of behaviour) and attributes (definitions of variables). Methods get invoked in response to messages.

>Once the String class... . Every newly instantiated String implements the same methods and use the same attribute names but each contains it own personal data.

>They share the same methods so they all behave like Strings; they contain different data so they represent different ones.

>Knowledge of an objects' type(s) therefore lets you have expectations about the messages to which it responds.


## Chapter 2 Designing Classes with Single Responsibility

>The foundation of an OO system is the message, but the most visible organisational structure is the class.

>The problem is not one of technical knowledge but of organisation; you know how to write the code but not where to put it.

>The classes you create will affect how you think about your application forever.

- Transparent - the consequences of changes should be obvious in the code that is changing and in distant code that relies upon it.

- Reasonable - the code of any change should be proportional to the benefits the change achieves.

- Usable - existing code should be usable in new and unexpected contexts.

- Exemplary - the code itself should encourage those who change it to perpetuate these qualities.

>The first step in creating code that is TRUE is to ensure that each class has a single, well-defined responsibility.

###7 Creating classes that have a single responsibility
>A class should do the smallest possible **useful** thing; single responsibility.

> A class that has more than one responsibility is difficult to reuse.


#### Determining if a class has a single responsibility

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
