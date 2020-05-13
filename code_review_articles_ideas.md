# Code Reviews

[How to Do Code Reviews Like a Human (Part One)](https://mtlynch.io/human-code-reviews-1/) 📖

[How to Do Code Reviews Like a Human (Part Two)](https://mtlynch.io/human-code-reviews-2/) 📖

[One weird trick for handling code review feedback](https://medium.com/@raquelxmoss/one-weird-trick-to-help-you-handle-code-review-feedback-better-d999a08620b1) ✅

[Code review thoughts](https://twitter.com/schuknight/status/1003802645465714688?s=11)

  >5 Jun 2018
  >Some thoughts on code reviews during team chat: developer/review like author/editor; always a conversation; we all write code differently; everything is an opinion; if the code works, no one is wrong; "no" is never the answer, "no, because..." is an answer

[Code Review Best Practices](https://www.kevinlondon.com/2015/05/05/code-review-best-practices.html) ✅

[Thoughbot - Code Review](https://github.com/thoughtbot/guides/tree/master/code-review) ✅

Collation of tips, ideas, advice on reviewing code.

## Talking through code

I have grabbed a senior often to help me with code reviews where I'm not to sure what is going on or I kind of have an idea but think it is something that needs to more experience pair of eyes, for example, when the code has to do with authorisation.
I have just done one of these with a senior this morning and points from it:

- "walk" / talk through the code
  - where is it going and what it is doing
- think about what is being "inputted" to the unit/box (class) and what it is "outputting"
  - what message is going in and what do we expect to get out of it?
  - (this was specifically a unit test)
- think about the behavior of the unit/class and if the changes mean that it is staying the same or changing
- keeping in mind what should and shouldn't be tested, for example, internal methods shouldn't be tested, just the behaviour of the class.

## Code Review / Pull Request Emojis

This is what we used at Flick Electric when I was working there.

When reviewing a Pull Request, the more Emoji the better ✨. These ones have a defined meaning:

- 💡 **FYIs**           *(such as: "💡In another service, we solve a similar problem in this way")*
- ⚠️ **blocking**      *(such as: "⚠️ I don't think this will work for these edge cases")*
- 🐘 **non-blocking**  *(such as: "🐘 This could be more elegant by doing it a different way")*
- 🍄 **code smell**   *(such as: "🍄 This seems like a lot of logic for a view")*
- 💭 **thought**      *(such as: "💭I wonder if we could use this pattern in other services?")*
- ✨ **compliments**  *(such as: "✨This is some great code, computer friend!")*
- ❓ **questions**   *(such as: "❓Why have you done this this way?")*
- 👠 **style**  *(such as: "👠 Add some spaces inside the curly braces")*
- :mortar_board: or 📚 **learning**  *(such as: ":mortar_board:  "I haven't used geckoboard, wondering where this method comes from?")*
- ♿️ **accessibility** *(such as: "♿️ The link text 'click here' might not make sense to someone using a screen reader if they encounter it out of context")*

- 🔧 **todo / building next**

Addition from Storypark

- 🎈a **thought** *("such as: "Just a thought, you can change if you want but not blocking")*
