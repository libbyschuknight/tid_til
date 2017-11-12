# Chapter 6 - Acquiring Behaviour through Inheritance
Page 105

## Understanding Classical Inheritance

At its code, inheritance, is a mechanism for *automatic message delegation*.

>It creates relationships such that, if one object cannot respond to a received message, it delegates that message to another. You don't have to write code to explicitly delegate the message, instead you define an inheritance relationship between two objects and the forwarding happens automatically.

classical inheritance -> relationships defined by creating subclasses
classical -> class (not archaic)
messages forwarded from subclass -> superclass, shared cod define in class hierarchy

## Recognising where to use inheritance
Page 106

### Starting with a concrete class

`Bicycle` class, each road bike going on trip is represented by instance of `Bicycle`

```ruby

############## Page 107 ##############
class Bicycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size       = args[:size]
    @tape_color = args[:tape_color]
  end

  # every bike has the same defaults for
  # tire and chain size
  def spares
    { chain:        '10-speed',
      tire_size:    '23',
      tape_color:   tape_color }
  end

  # Many other methods...
end

bike = Bicycle.new(
        size:       'M',
        tape_color: 'red' )

bike.size     # -> 'M'
bike.spares
# -> {:tire_size   => "23",
#     :chain       => "10-speed",
#     :tape_color  => "red"}
```

This class works until something changes.

Mountain bikes!

### Embedding multiple types
Page 109

>When a pre-existing concrete class contains most of the behaviour you need, it is tempting to solve this problem by adding code to that class.

```ruby
############## Page 110 ##############
class Bicycle
  attr_reader :style, :size, :tape_color,
              :front_shock, :rear_shock

  def initialize(args)
    @style       = args[:style]
    @size        = args[:size]
    @tape_color  = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
  end

  # checking 'style' starts down a slippery slope
  def spares
    if style == :road
      { chain:        '10-speed',
        tire_size:    '23',       # milimeters
        tape_color:   tape_color }
    else
      { chain:        '10-speed',
        tire_size:    '2.1',      # inches
        rear_shock:   rear_shock }
    end
  end
end

bike = Bicycle.new(
        style:        :mountain,
        size:         'S',
        front_shock:  'Manitou',
        rear_shock:   'Fox')

bike.spares
# -> {:tire_size   => "2.1",
#     :chain       => "10-speed",
#     :rear_shock  => 'Fox'}
```
>This example is simply a detour that illustrates an *anti-pattern*, that is, a common pattern that appears to be beneficial but is actually detrimental, and for which there is a well-known alternative.

These changes have made `Bicycle` worse. It now has more responsibility, contains things that may change for different reasons and can't be reused.

>This code contains an if statement that checks *an attribute that holds the category self* to determine what message to send to self.

This pattern indicates a missing subtype -> subclass.
