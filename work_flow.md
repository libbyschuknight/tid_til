# Work Flow / Process
> How I try to approach developing a story / writing code


### At the Very Beginning
- be clear about the story and what you are aiming to achieve
- be clear about how approaching task
- only focus on this task, don't get sidetracked by how it fits in with other bits / keep focused on the story
- at the beginning work out exactly what the story is about and clarify things as needed
- draw diagrams of what is happening to help with understanding where at and what want to achieve
- be staunch about only doing what the task is and not doing anything else

#### Definition of a Story
###### [What is a User Story?](https://www.mountaingoatsoftware.com/agile/user-stories)

User stories are short, simple descriptions of a feature told from the perspective of the person who desires the new capability, usually a user or customer of the system. They typically follow a simple template:
> As a <type of user>, I want <some goal> so that <some reason>.

User stories are often written on index cards or sticky notes, stored in a shoe box, and arranged on walls or tables to facilitate planning and discussion. As such, they strongly shift the focus from writing about features to discussing them. In fact, these discussions are more important than whatever text is written.

# TODO: add Simons definition


### At the Beginning of Coding

**RUN THE TESTS!!**

If tests fail, reset the test database: `rake db:test:prepare`  
and remember to reset the development database: `rake db:reset` (depending on what rake tasks are set up)
