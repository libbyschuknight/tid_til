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
