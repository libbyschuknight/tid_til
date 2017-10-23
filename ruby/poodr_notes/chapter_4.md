# Chapter 4 - Creating Flexible Interfaces
Page 59

>...but an object-oriented application is more than just classes. It is *made up of classes* but *defined* by messages. Classes control what's in your source code repository; messages reflect the living, animated application.
>Design, therefore, must be concerned with messages that pass between objects.
>The conversion between objects takes place using their interfaces.

## Understanding Interfaces

![figure 4.1](fig4_1.png)

>In the first application, the messages have no apparent pattern. Every object may send any message to any other object. If the messages left visible trails, there trails would eventually draw a woven mat, with each object connected to every other.
>In the second application, the messages have a clearly defined pattern. Here the objects communicate in specific and well-defined ways. If these messages left rails, the trails would accumulate to create a set of islands with occasional bridges between them.

>The objects in the first application are difficult to reuse. Each one exposes too much of itself and knows too much about its neighbours. ... No object stands alone; to reuse any you need all, to change on thing you much change everything.

>The second application is composed of plug-able, component-like objects. Each reveals as little about itself, and knows as little about others, as possible.

>The roots of this new problem lie not in what each class does but with what it reveals. In the first application each class reveals all. Every method in any class is fair game to be invoked by any other object.

>In the second application, the message patterns are visibly constrained. This application has some agreement about which messages may pass between its objects. Each object has a clearly defined set of methods that it expects others to use. These exposed methods comprise the class's *public interface*.

>...first kind of interface, that is, methods within a class and how and what to expose to others.

## Defining Interfaces
Page 61

Restaurant kitchen example of a public interface

>Each of your classes is like a kitchen.
>The class exists to fulfil a single responsibility but implements many methods.
>Some of these methods represent the menu for your class and should be public; others deal with internal implementation details and are private.
