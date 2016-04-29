# Today I Did...Today I have worked on...

#### 29 April 2016
... got a csv file downloading with header and rows. It felt like it all went really well. Definietly a lot quicker then last year when doing a similar thing. 

#### 28 April 2016
... progressed well today. Feel more confident in creating modules to do work/logic and not leaving this in models or controllers. As well as thinking or remembering ways to improve finding records in the databases, ie `scope` in Rails.

#### 27 April 2016
... have been playing around in a big Rails app. Calling an external API to populate a drop down list. Adding in another controller which makes so many. And will be doing stuff to make a csv! Exciting. I also attended the first Wagtail Meetup at Springload ([See meetups](courses.md#meetups))

#### 26 April 2016
... session with boss re development plan. Went well. Good things to focus on for the coming year.

#### 22 April 2016
... finished of endpoint. Learnt how to generate an UUID in bash with alias.

#### 21 April 2016
... learnt how to checkout a tag in a git repo. Have been working on creating a new endpoint for returning another collection. Following similar way did last one. An issue recently as been big changes to code happening in one branch for an app and a gem. The gem of which is used in many other apps. See see [Gem Stuff](gems/gem_stuff.md) for more information.

#### 20 April 2016
... more work on code review. Issues with passing in a JSON array it working with params using Grape. Fixing up of specs.
> Pairing - trying to figure out using Grade params to get stuff out of JSON with an array inside.

#### 19 April 2016
... changes following code review! Heaps of stuff, a lot of what has been added to TIL.

#### 18 April 2016
...tidy up of pull request for feature branch. This involved checking to much sure I had covered everything in the story, specs passing etc. Have started on next task, attempted to write stories for these. This was quite good as it helped me clarify what was expected.

#### 15 April 2016
... specs for state machine. Performance review stuff.

#### 14 April 2016
... fix up specs due to changes to model and how the state machine was implemented. Using [State Machines gem](https://github.com/state-machines/state_machines).

#### 13 April 2016
Today I learnt that you have to be very careful with dropping tables, renaming, dropping columns etc. It might all work fine in your development environment but when pushed to test server (god forbid if it even happens to me when pushing to prod!) it does not. This issue came about by wanting to change a name of a table. Say `Cats` to `Dogs`. Simple to do with `rename_table`, but I decided to look at the postgresql database and in there the now `Dogs` table that had a relationship with the `Homes` table, has the naming of the keys still as `Cats`. After having a chat with someone I decided to remove `home_id` of `Cats` (so dropping the column), change `Cats` to `Dogs`, then add `foreign_key` for `Homes` to `Dogs`. This worked fine locally but when it was pushed to test server environment as there was a `null: false` on `home_id` (or something like that), it wouldn't run the migrations. So, the fix involved rolling back to the migration before last problematic migration and then deleting the problematic migrations. Luckily the problematic migrations were not in production. Phew! Provides for an interesting day, especially when trying to get something on the test server for demo time. I wonder if there had been more oversight by a senior dev if this issue would have come out a lot earlier and therefore wouldn't have had this issue when trying to deploy. Another thing I was thinking was it could work to have more scheduled or semi-formal-ish check ins on what I have done and why.
I think also the fact that there was data in the test server database that would have been lost with the dropping of a column. Whereas locally I could just reset the database. I wonder what would be a better workflow in this instance?

Attend a StripeGirls meet up, mostly looking at modules.

#### 12 April 2016
...getting new api endpoint working and amending one. Fixing up specs after making changes.

#### 11 April 2016
...working on adding this state machine in. Needed to do some migrations to add and drop columns. Add in `pg_json` extension for Sequel to store chucks of JSON.

#### 8 April 2016
... trying to implement State Machine in established code base. Paired for a couple of hours with Samson and implementing the state machine into existing codebase. It was great pairing on this as I firstly wasn't sure how the state machine worked (using State Machines gem) and was at a loss of how to go about implementing in current codebase. In general the things I got for this pairing session were a lot of reminders. Samson was good at making it clear how he was approaching the task at hand. Although we are working on part of a bigger picture, where what we are implementing may effect other parts, he was clear about only focusing on the part we had, at this point. Keeping focused on the story we have to do and doing that and not anything else. He also, at the start, spent time working out exactly what the story was about and clarifying things. He drew out a diagram to get an understanding of where we were and what we wanted to achieve.

#### 7 April 2016
... renaming models. Looking at using State Machine gem.

#### 5 April 2016
...I have been getting frustrated with forgetting small things I need to change to make codebases work together when running locally. E.g. pointing an app to local gem, changing environment host constant to localhost. Learnt how to add an enum value in Sequel. And that I need to pay more attention or think more laterally when making changes. It might pay to try and write at when I first start a story what I think I am doing and keep referring back to this, as I feel some things have gotten lost as I have progressed on current story.

##### 4 April 2016
... trying to get my head around working on numerous different branches in the same code base. Also, understanding apis and keeping old stuff in it that services use, even if updating bits that the services will use. This is so to be able to do backwards compatibility. I think also I need to be clearer in my communications with seniors around my large gaps in knowledge.

##### 2/3 April 2016
Seido site. Seed dump gem, sorting gitignore for images.

##### 1 April 2016
... I have been back into api endpoints, representers and plugging stuff together. I have had a view hiccups during the day which is mainly been down to not paying enough attention to the naming of things through the different apps. As well as copying and pasting and not paying enough attention on the small parts that need to be changed. I blame it on being a Friday! Yeah nah! Have been reviewing code review comments of my pull requests and making changes accordingly. I am wondering at what point I will start to recognise when I should be using different patterns...

##### 31 March 2016
... we have had a "technical debt" day at work. Where we have been working on refactoring code that is poor and can be improved. I have been working on a gem for our front-end styling and learning a lot about mixins. More to come on this tomorrow.

##### 30 March 2016
... I have been given advice that it is important to remember to look at the whole forest and not get stuck just looking at the trees. Rescued database error, see ruby/errors.md. Written more specs, which will be useful for next piece of work, as will be changing a lot of what I have just done.

##### 29 March 2016
Today I have worked on adding facades/representers to extend out and complete (hopefully!) the endpoint I started making the other day. Seem to have a better understanding of making them but still no idea how it all works under the covers. All based on using ROAR and Grape.

##### 28 March 2016 (Easter Monday)
Today I worked on Seido Guide again. Added update, edit actions. Updated styling, added "add stance" button on pages.

##### 27 March 2016 (Easter Sunday)
Today I worked on the Seido Karate guide again. Added index page for stances.

##### 26 March 2016
Today I have work on my Seido Karate guide again. Worked on the controller for stances and controller and feature specs.

##### 25 March 2016 (Good Friday)
Today I have worked on my [Seido Karate Guide](https://github.com/libbyschuknight/libs_seido_guide). I have added in a stances model and added in images to it using Paperclip. Have added some capybara tests for the static home page. Having some trouble with the styling of the form for creating a stance. Think it is a bootstrap issue.

##### 24 March 2016
Today I have worked on another story for another endpoint in the api that I have been working on. Adding in new facades, representers. Remembering more about database stuff and learning about how frustrating it is when things a coupled together.

##### 23 March 2016
Today I have done/learnt more specs and learnt to think about what is being passed into OpenStructs, how to delete a tag when pushed accidentally.

##### 22 March 2016
Today I have worked on getting my branches of three different things working with changes others have made. There has been an issue with backward compatibility and updating of gems and not of apps using gems.

##### 21 March 2016
Today I have added specs for roles and parties. Created pull requests and tried to make sense of how handle different versions of own gems when more than one person working on them and needing to merge.

##### 20 March 2016

Today I have been working on starting to create my Seido Guide for my karate. I have created a new Rails app, added bootstrap-sass and started developing it from the simple starter them of getbootstrap.com.

##### 18 Mar 2016
Today I did... more disco stuff. Realised was missing conditional in creation of role and party. Updated app using new properties. Broke out logic from facade into a service model, which will make it easier to test this logic. Samson helped me with breaking the conditional logic out into a method, so there would be less branches needed in testing.

Notes from Retro:
- work in breaking out more stories if I think a story I am on it more than one.
- pull requests - need to have a good description, tag people for specific parts of the code, review patterns as well as syntax of code.


##### 17 Mar 2016
Today I did... disco and resources, added in another facade and endpoint. Wrote some new specs. Embedded more understanding of how things interrelate.

##### 16 Mar 2016
Today I did... disco and resources. Added in another representer so as to get links in the embedded property. Update specs.

Today I learnt that it is not always good to be over zealous with merging master into a branch I am on. I was working in an app that used one of our own gems, which someone else had updated. I merged this into my local version of the gem and then it broke some specs in the app I was in. Learnt how to revert from a `git merge master`.

##### 15 March 2016
Today I worked on disco and resources. Continued to fix specs that were failing due to changes. And learnt about hard coding UUIDs into factories. Numerous times I have find this online [Diff Checker](https://www.diffchecker.com/) very useful. It was very useful today.

##### 14 March 2016
Today I worked on disco and Resources. Mainly in netdisco. Adding properties to the representers and fixing up specs due to changes. Good use of factory girl, nested factories. See [Factory Girl](/testing/factory_girl.md)
