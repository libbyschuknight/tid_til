# Code Reviews
Collation of tips, ideas, advice on reviewing code.

#### Talking through code
I have grabbed a senior often to help me with code reviews where I'm not to sure what is going on or I kind of have an idea but think it is something that needs to more experience pair of eyes, for example, when the code has to do with authorisation.
I have just done one of these with a senior this morning and points from it:
- "walk" / talk through the code
  - where is it going and what it is doing
- think about what is being "inputted" to the unit/box (class) and what it is "outputting"
  - what message is going in and what do we expect to get out of it?
  - (this was specifically a unit test)
- think about the behavior of the unit/class and if the changes mean that it is staying the same or changing
- keeping in mind what should and shouldn't be tested, for example, internal methods shouldn't be tested, just the behaviour of the class.
