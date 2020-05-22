# Testing - general

[Tips to improve speed of your test suite](https://medium.com/appaloosa-store-engineering/tips-to-improve-speed-of-your-test-suite-8418b485205c)

[TestUnit - Writing Test Code In Ruby (1/3)](https://dev.to/exampro/testunit-writing-test-code-in-ruby-part-1-of-3-44m2)

[MiniTest - Writing Test Code In Ruby (2/3)](https://dev.to/exampro/minitest-writing-test-code-in-ruby-part-2-of-3-4306)

[RSpec - Writing Test Code In Ruby (3/3)](https://dev.to/exampro/rspec-writing-test-code-in-ruby-part-3-of-3-32np)

[Introduction to Ruby and RSpec…](https://medium.com/craft-academy/introduction-to-ruby-and-rspec-135da4051802)

[INTRODUCTION TO RSPEC](https://www.theodinproject.com/courses/ruby-programming/lessons/introduction-to-rspec)

## Running a specific test

If you want to run one particular spec or feature scenario, you can specific the line

`bundle exec spring cucumber core/features/admin_premium_providers_capybara.feature:41` - will run the scenario for line 41

You can also do more than one `bundle exec spring cucumber core/features/admin_premium_providers_capybara.feature:41:46`

Same with RSpec:

`bundle exec rspec core/spec/controllers/admin/brands_controller_spec.rb:67`

## Using Fixtures in Rails

[7 REASONS I'M STICKING WITH MINITEST AND FIXTURES IN RAILS](http://brandonhilkert.com/blog/7-reasons-why-im-sticking-with-minitest-and-fixtures-in-rails/)

[TIME TO BRING BACK FIXTURES](https://collectiveidea.com/blog/archives/2014/08/06/time-to-bring-back-fixtures)

[Define Fixtures With Polymorphic Association](http://ruby-journal.com/rails/define-fixtures-with-polymorphic-association/)

### Fixtures in ActiveRecord

```ruby
ActiveRecord::FixtureSet.identify(:<fixture_name)

# e.g. you have this record which is a fixture
Assignee.csr_ticket_access
[
    [0] #<Assignee:0x00007fcb686b6170> {
                      :id => 657985557,
                    :name => nil,
        :administrator_id => 352583627,
                    :type => nil,
              :created_at => 2019-11-21 13:14:39 +1300,
              :updated_at => 2019-11-21 13:14:39 +1300
    }
]

# the name of the fixture is "ticket_admin_group_csr"

ActiveRecord::FixtureSet.identify(:ticket_admin_group_csr)
# 657985557
```

## Four Phase Test Pattern

Reminded about from here <https://designcode.commandrun.com/testing-rails-simple-guide-part-2-17d629645187>

First came across here <https://robots.thoughtbot.com/four-phase-test>

```code
test do
  # setup - Prepare object for this test
  # exercise - Execute the functionality we are testing
  # verify - Verify the exercise's result against our expectation
  # teardown - Resetting all data to pre-test state
end
```

An example of when I have used:

```ruby
# pseudoscope

describe "#processing?" do
  context "when payments are being processing" do
    # setup - Prepare object for this test
      # payment_schedule

      # payments, that belong to payment_schedule
        # all in processing - pipeline_processing_status == processing

    # exercise - Execute the functionality we are testing
      # payment_schedule.processing?

    # verify - Verify the exercise's result against our expectation
      # expect payment_schedule to eq processing
  end
end
```

## Tools

[I am confused with terms Cucumber, Capybara and RSpec. Which of these should I go for in my new Rails application?](https://www.quora.com/I-am-confused-with-terms-Cucumber-Capybara-and-RSpec-Which-of-these-should-I-go-for-in-my-new-Rails-application)

[Difference between rspec, capybara and cucumber](https://stackoverflow.com/questions/22491145/difference-between-rspec-capybara-and-cucumber/22491329#22491329)

> rspec is a full-featured testing framework that will let you write what Rails considers unit tests, functional tests, and integration tests. All of these exercise Ruby code through various layers of your Rails application. All of these tests simulate requests to your Rails application, but don't actually run the application end-to-end over the network.
>
> cucumber is a browser based integration testing framework, which allows writing automated tests that run against the entire Rails application accessed from within an automated web browser. This allows you to write automated tests about in-browser behavior for JS or CSS. Cucumber provides a unique angle on integration testing that uses plain english specification mapped to code via regular expressions. This allows a more natural "Behavior Driven Development" model - describing what a web application should do, in plain language, from the perspective of the user.
>
> capybara is a particular web driver powering the cucumber integration testing framework, that uses headless webkit. This allows running a headless (without UI) Chrome/Webkit browser for automated testing. This is very useful both in development, but especially on a remote test/continuous integration server.
>
> So rspec and cucumber are similar in being testing frameworks with their own way of specifying things. rspec has a nice DSL that's very readable while being actual code. cucumber maps plain text descriptions to real code.
>
> Though cucumber is usually used on top of capybara, you can also use rspec to drive capybara integration tests. The tests are written in either rspec or cucumber, but capybara is an integration engine underneath.

[A repeatable, step-by-step process for writing Rails integration tests with Capybara](https://www.codewithjason.com/repeatable-step-step-process-writing-rails-integration-tests-capybara/)

## Try to remember to read the RSpec errors really carefully!!

Just had a number of fails but was due to not coding the factories properly rather then any error a test itself.

## Rails Conf 2013 The Magic Tricks of Testing by Sandi Metz

A must watch and re-watch - [Rails Conf 2013 The Magic Tricks of Testing by Sandi Metz](https://www.youtube.com/watch?v=URSWYvyc42M) 👀

## Using OpenStructs

When using OpenStruct in tests, need to look at the things that are being passed into the object you are wanting to recreate.

e.g.
module representer for api

```ruby
    module Role
      include ::Representers::Base

      property :id

      property :kind

      property :role

      property :identifiers, class: OpenStruct do
        property :something_id
      end

      property :party, embedded: true, extend: Representers::Party, class: ::Party

      link :self do
        "/party_roles/#{id}"
      end

      link :party do
        "/parties/#{party_id}"
      end
    end
  end
end
```

creating objects to use in spec

```ruby
let(:st_id) do
  OpenStruct.new(something_id: "FLCK")
end

let(:party) do
  OpenStruct.new(
    id: "e4e5300b-600c-4335-a139-2050edbed254",
    kind: "party",
    name: "The Part Party"
  )
end

let(:object) do
  OpenStruct.new(
    id: "999ec5a8-4037-45ba-bbf0-1dc9db8f9fcc",
    kind: "party_role",
    role: "entertainer",
    identifiers: st_id,
    party: party,
    party_id: party.id
  )
end
```

My point being, make sure that what the properties are in the OpenStruct object, are the same as what is in the Role. For example, `party_id` needs to be `party.id`.

## Params

If you change the columns on your table, remember to change the 'strong params' that are allowed to pass through.

## TIME

### Stub out in RSpec

```ruby
allow(Time).to receive(:now).and_return(Time.parse('2016-03-02'))
```

Needed to use `Time.utc(2016, 8, 1, 14, 34, 56)`, otherwise was failing on Travis due to different timezones.

Another stubbing:

```ruby
    let(:model) { double('New Ticket Form', method => value, :errors => { :updated_at => "error update" }) }
```

Lots of other stuff was going on with the above stubbing but this part `:errors => { :updated_at => "error update" }` is what worked with needing to be able to handle errors and get the spec to work with the code checking this stuff:

```ruby
object.errors[method] if object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[method].present?
```

Also see # August Mistakes & Improvements - Testing with Time

## Using Doubles

```ruby
let(:role) do
    double( "animal_role",
      identifiers: double("identifiers", animal_code: "DOG"),
      participant: double("animal",
        name: "Rover",
        links: { self: double(
          "href", href: "/animals/1234"
          )
        }
      )
    )
  end

  let(:animals_roles_search_results_mock) do
    double("animals_roles_search", animal_roles: [role])
  end
```

## Test if something changes number of records

```ruby
params = { "address" => "31 Te Whiti Street, Kilbirnie, Wellington 6003" }
expect{ post :create, params }.to change{ Application.count }.by(1)
```

## RSpec

### `let()` & `let!()`

[RSpec: What is the difference between let and a before block?](http://stackoverflow.com/questions/5974360/rspec-what-is-the-difference-between-let-and-a-before-block?answertab=active#tab-top)

[When to use RSpec let()?](http://stackoverflow.com/questions/5359558/when-to-use-rspec-let)

[Let vs. Let! vs. Instance Variables in RSpec](https://mixandgo.com/learn/let-vs-instance-variables-in-rspec)

<https://relishapp.com/rspec/rspec-core/v/2-11/docs/helper-methods/let-and-let>
<http://www.betterspecs.org/#let>
<https://stackoverflow.com/questions/5359558/when-to-use-rspec-let/5359979#5359979>

[All about RSpec let](https://medium.com/@tomkadwill/all-about-rspec-let-a3b642e08d39)

Asked this in Ruby NZ Slack channel

>Hey people! Hope the week is going well. I have a quesiton about RSpec (@jonrowe). I've been discussing with colleagues the use of let vs let! . I >lean towards trying not to use let! and instead using let's if needed and then evaluating it in a before block. I feel I have ended up having this >preference because of some pain with tests in the past where strange things seemed to be happening and we realised it was due to the use of a let! >(I can't remember anything specific about  this though) and also these tweets around that time were brought to my attention - <https://twitter.com/>penelope_zone/status/767850685329203200>
>
>RSpec advice:
>don't use let!
>use let and evaluate it in a before.
>
>it's really hard to visually differentiate let and let!. An evaluation in a before is really really obvious.
>Keen to hear thoughts on others here. Thanks (edited)
>
>RSpec advice:
>don't use let!
>use let and evaluate it in a before.

Some of the answers that were useful:

>jemmyw
>let! is evaluated immediately of course. Now I disagree with a blanket no use. When you understand what it does then it's fine to use. It's just >that it's use should be occasional. You require a value to be setup and another let or before block requires a side effect of that setup. Doesn't >come up often but if you have callbacks then it can
>
>And let! can do something that an evaluation in a before cannot... let you override in contexts

Performance cost / scoping

>RM
>let! can come with a performance cost when it’s not scoped correctly in specs. If you’re using let! and not scoping it to only the specs that need >that object (e.g. in a describe or context block) then you may be inadvertently creating extra objects when they’re not needed, slowing down your >specs. If you’re declaring something with a let at the top of the file and then evaluating it as required, you can be a bit more intentional about >it. Personally I just like to sanity-check that I’ve scoped everything so that I’m creating the minimal number of objects per spec run, and think >about future-proofing, for when the next developer comes along and adds a spec to the file.
>
>Obviously you have the same problem if you’re using let with a before and not scoping it correctly, I think it’s just easier for it to slip under the radar with a let! ¯\_(ツ)_/¯


>jemmyw
>I agree. However, with before you have a different issue in that because you cannot override it, if you run a setup on too high a scope and need >another setup with a new before in the nested scope, you're doing the work twice
>
>jemmyw
>but it's not something I've seen much, most specs are reasonably scoped regardless
>
>jemmyw
>In my opinion it comes down to know and understand your specs and tools, rather than disallowing a built in like let! because you once or twice >made a mistake. You can make a mistake with anything. OTOH if a dev personally decides to avoid it and your code is still nice and clean then all >power to them

Some thoughts from colleahues after reading the above

>EP
>Thanks for following up on that Libby!
>
>A couple of takeaways for me :
>
>`let!` is fine as long as it is close to where it is used (e.g. avoid them at the top of the file). If it's too far away, it is easy to miss and may cause headaches in the future
>
>`let!` is effectively a before block, so avoid mixing `let!` s and befores in the same scope. I.e. The order they run in isn't always the same as the >order you read them and may cause headaches in the future

Also

>From RSpec core lead
>These are identical:

>```ruby
>let(:name) { do_thing }
>before { do_thing }
># or
>let!(:name) { do_thing }
>```
>
>The reasoning behind not using `let!` is its harder to see whats going on.
>
>Its not immediately executed, it is placed in a`before` scope, which means ordering can be subtly unexpected.
>
>For example there is a precedence order to hooks so its possible that say, a `before(:context)` thats declared after the `let!` will execute before the `let!`

### `subject()`

<https://rspec.rubystyle.guide/#subject>

<https://relishapp.com/rspec/rspec-core/v/3-9/docs/subject/explicit-subject>

<http://www.betterspecs.org/#subject>

### Autoloading Error

```bash
LoadError:
  Unable to autoload constant Billing::Resources::PaymentSchedule, expected /Users/libby/Code/payments/app/services/billing/resources/payment_schedule.rb to define it
```

Had three specs that were randomly failing - two would fail and one would pass, and it would change when had order as random.
The issue was this:

```ruby
let(:schedules_resource)  { Resources::Schedule.new.from_json(schedule_response_json) }
```

After having a think and remembering that with `lets` there is lazy loading, so added a ! to the let - `let!(:schedule_resource)`
and specs passed.

From rspec:

> Note that let is lazy-evaluated: it is not evaluated until the first time the method it defines is invoked. You can use let! to force the method's invocation before each example. <https://relishapp.com/rspec/rspec-core/v/3-4/docs/helper-methods/let-and-let>

Then were running this pass other devs, got from @Ootoovak

> This came across my Twitter feed a few days ago (by one of the RSpec core team members)
>
> <https://twitter.com/samphippen/status/767850685329203200> Extraordinary Alien @samphippen
>
> RSpec advice:
>
> don't use let!
>
> use let and evaluate it in a before.

> <https://twitter.com/penelope_zone/status/767850817156177920>
>
>it's really hard to visually differentiate let and let!. An evaluation in a before is really really obvious.

So have done this:

```ruby
before do
  payment_schedules_resource
  # other code...
end
```

And the specs are passing! Yay!

### RSpec Formatting

Repo is set with `--format documentation`, which will output all the documentation strings. In an app that has a lot of specs this can be slow.
Can set when you run `rspec` to run as the default, which is no strings, just dots, F's and P's.

```ruby
rspec -f p

or

rspec --format progress
```

### Stubbing vs Using VCR

Discussion at Flick about using doubles / allows to stub versus

With the specs, for the `SupplyNodeDeprovisioner` spec, I used the `Claimer` and `Remover` specs as a guide.
Those were all stubbed.
This then led me to stub in the `DeprovisioningApi` spec as well.

Not too sure about stubbing. I guess though that as long as the Network assignment_suspension endpoint is tested well in Network then it is okay to stub?? Rather then use VCR??
@ootoovak
ootoovak 4 hours ago
Yeah, I think that is fine, like if you are thinking as servers as objects (just at a different level) then stubbing out calls to other servers is like a unit test. This does leave the problem of how we write "integration" level tests between our services. @mermop started the test suite for this but we have not come to a consensus about maintaining it and adding to it. One thing we have to overcome is how we manage state changes between servers. That level of tests might have to wait until the day we get containers with seed data. Then we could potentially spin up a test version of all our services, run all the "service/integration" level tests on them, then spin it down again. Meaning the data would be fresh between each run even if some tests changed the seed data.
@ootoovak
ootoovak 4 hours ago
As for VCR vs manually stubbing kind of the same as using FactoryGirl.build(:user) vs User.new(...). As in there is not much difference the former provides more convenience the latter has has less dependence on external tool that could be overused/debugged. In either case it is stubbing the call to a service and both can drift over time form the actual API if not maintained.

#### Strategy

This is what Samson and I did when I was writing a feature spec for an api.

```ruby
service_client = instance_double("Invoiced::Client")
invoiced_invoice = double(
                    "InvoicedInvoice",
                    balance: "105.00".to_f,
                    paid: false,
                    items: [],
                  )
allow(service_client).to receive_message_chain(:Invoice, :retrieve).and_return(invoiced_invoice)

allow(InvoicedClient).to receive_message_chain(:new, :client).and_return(service_client)
```

Worked the above backwards. Starting with stubbing (or is it mocking) out an external call `InvoicedClient` and have the return an instance_double.
Then the `service_client` was stubbed out and returned a double which to start with was just `invoiced_invoice = double("InvoicedInvoice")` and then ran the spec to see what messages the object was wanting to respond to.

## Capybara Testing

<https://rubydoc.info/github/teamcapybara/capybara/master>

[Write Reliable, Asynchronous Integration Tests With Capybara](https://thoughtbot.com/blog/write-reliable-asynchronous-integration-tests-with-capybara)

Useful page - has node methods (as in `fill_in`) and session methods (using `page`, `page.body`, `page.save_page`)

[Class: Capybara::Session](http://www.rubydoc.info/github/jnicklas/capybara/Capybara/Session)

When using [`save_and_open_page`](https://www.stefanwille.com/2010/12/printing-the-page-content-in-capybara/), to use the assets so the page has the correct styling, in your `config/environments/test.rb` file, add these:

```ruby
config.assets.debug = true
config.action_controller.asset_host = "http://localhost:6001"
```

## Unit tests

After having a chat with Sam about testing and unit tests.

![unit testing](testing.jpg)

## Getting into being a tester

Some resources people have suggested:

[To The New Tester](https://www.satisfice.com/blog/archives/958)

[Ministry of Testing](https://www.ministryoftesting.com/)

[ASSURITY Courses](https://education.assurity.nz/courses)

[ISTQB](https://www.istqb.org/)
