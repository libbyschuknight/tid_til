# POODR - Practical Object-Oriented Design in Ruby

Code examples - https://github.com/skmetz/poodr

Someone else's notes with references to code - http://ericfarkas.com/posts/notes-on-poodr

## Chapter 1 Object-Oriented Design
Page 1

>... a series of messages that pass between objects.
> once you acquire an object-oriented perspective the rest follows naturally

> change is unavoidable

>Applications that are easy to change are a pleasure to write and a joy to extend. They're flexible and adaptable.

>OO design is about managing dependencies.
>In the absence of design, unmanaged dependencies wreak havoc because objects know too much about one another.

>You must not only write code for the feature you plan to deliver today, you must also create code that is amendable to being changed later.

>The purpose of design is to allow you to do design later and its primary goal is to reduce the cost of change.

### Design Principles

Page 5

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

Page 6

>Each well-known pattern is a near perfect open-source solution for the problem it solves.
>However, ... pattern abuse by novice programmers, who, in an excess of well-meaning zeal, applied perfectly good patterns to the wrong problems.

**NOTE: find out more about design patterns**

#### A Brief Introduction to OO Programming

Page 11

OO Languages
Page 12

>Instead of dividing data and behaviour into two separate spheres... .Ruby combines them together into a single thing, an object.
>Objects have behaviour and may contain data, data to which they alone control access. Objects invoke one another's behaviour by sending each other messages.

>Every object decides for itself how much, or how little, of its data to expose.

>Class-based OO languages...allow you to define a class that provides a blueprint for the construction of similar objects
A class defines methods (definitions of behaviour) and attributes (definitions of variables). Methods get invoked in response to messages.

>Once the String class... . Every newly instantiated String implements the same methods and use the same attribute names but each contains it own personal data.

>They share the same methods so they all behave like Strings; they contain different data so they represent different ones.

>Knowledge of an objects' type(s) therefore lets you have expectations about the messages to which it responds.
