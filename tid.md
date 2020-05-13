# Today I learnt...

10 Oct
Learning how useful `to_sql` on ActiveRecord queries is; that I like using BEM for CSS; and when bug hunting thing FIRST of what the user has inputted and if it is correct!!

5 Oct
About how to access helper methods in rails console (although didn't seem to work on staging server). Also, dealing with time! And how useful it is to set timezone in `.env.development`.

4 Oct
Have had a break from this but feel like it was useful so starting again.

3 Oct
...about BEM
>Block Element Modifier is a methodology, that helps you to achieve reusable components and code sharing in the front-end
I paired with Merrin today on using haml and BEM to style counting of applications.

## Today I Did...Today I have worked on...

6 July
...have been busy and have forgotten to add to this. Currently working on the app that is internal facing. This app/service is a hybrid in that one page is in one service and another is in an old app that is still being used. Proves for interesting times.

... looking into adding a credit card set up. Adding eligibility checkers into a new app that will need to be passed back and forth between two different services. Probably will be turned into an API end point.

15 - 17 June 2016
... campsite day/s. Tidying up the Trello board. There were a few things that got parked to get something else out. I am enjoying going back and getting things finished. The main thing I am tidying up is a report that needs to be run, ideally every work, about customers networks.

14 June 2016
... worked on optimising calls to external API.

13 June 2016
...still on new app. Two others working on these as well and have demo tomorrow, so will be interesting to see it pulled together. Particularly as it is using two different apps and data is being passed back and forth.

3 - 10 June 2016
...be pairing with junior colleague on a new Rails app for a biggish project. Been using form model object. We are going well and it has been good to pair again.

2 June 2016
... have moved onto working on new biggish project with a couple of other devs, that needs to be done soonish. Another dev was working on front end stuff and have been trying to figure out what is happening. It is a combo of a new Rails app and an old Rails app. Using form model object in both, which is something I haven't used  before.

1 June 2016
... READ the rspec errors carefully!! Was failing on incorrect factory making rather then the actual test!!

31 May 2016
... working on improving seed script and methods used to create models. Some ambiguous language used in methods so has been unclear exactly what is happening and why.

30 May 2016
... issue with seed script running and not showing when things haven't been created.

25 May 2016
... bug fixing app deploy.

24 May 2016
... have spent time deploying using Capistrano and finding errors on Rollbar and fixing. See [miscellaneous.md](miscellaneous.md).

23 May 2016
... be very careful when deleting migration files. Think carefully about rolling back and when to delete! Especially if you have data you want to use.

20 May 2016
... working on join form but also got report story into UAT. Which is now involving writing a migration to change some data on some models.

19 May 2016
... have started on next story which is adding things to a join form in a big Rails app, which is mapped to SalesForce!

18 May 2016
... issues again today with doing a migration and then actually realising that other things depended on the column. So had to rollback, re do things and then delete migration file. Frustrating!!

17 May 2016
... next stories don't involve TDD, which is a goal/aim for the next few months. Will have to be proactive about getting the one after this to include the opportunity for some TDD. Also had a team discussion around testing, which will be ongoing.

16 May 2016
... code review for last story. Moving onto some front-end work! Yay!

#### 13 May 2016

... more specs. More doubles. Good retro around resources, pairing, writing smaller stories.

#### 12 May 2016

... more specs. Issue with a test not seeming to local an ActiveRecord model created in the test. Think it is a issue with the big huge app rather then the test or ActiveRecord.

#### 11 May 2016

... been working away today at writing specs. Using doubles and mocks/stubs (?), using allow. I have obviously learnt something as I was able to look at other specs and figure out what I could do for the specs I was working on. Pretty happy with that.

#### 10 May 2016

... made a silly mistake today re a migration in [Rails][_pages/rails.md], lesson learnt again, don't copy and paste!!

#### 9 May 2016

...first day back from holiday. Taking awhile to get my head back into the game. Did figure out how to test for an instance variable. Will try and add tomorrow.

#### 29 April 2016

... got a csv file downloading with header and rows. It felt like it all went really well. Definitely a lot quicker then last year when doing a similar thing.

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

Today I worked on disco and Resources. Mainly in netdisco. Adding properties to the representers and fixing up specs due to changes. Good use of factory bot, nested factories. See [factory bot](/testing/factory_bot.md)
