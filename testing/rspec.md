# RSpec

[The RSpec Style Guide](https://rspec.rubystyle.guide/) - <https://github.com/rubocop-hq/rspec-style-guide>

[RSpec Documentation](https://rspec.info/documentation/)

[RSpec Relish](https://relishapp.com/rspec)

[RSpec - Writing Test Code In Ruby (3/3)](https://dev.to/exampro/rspec-writing-test-code-in-ruby-part-3-of-3-32np)

[Introduction to Ruby and RSpec…](https://medium.com/craft-academy/introduction-to-ruby-and-rspec-135da4051802)

[INTRODUCTION TO RSPEC](https://www.theodinproject.com/courses/ruby-programming/lessons/introduction-to-rspec)

[Transpec: A magical tool for converting your specs to the latest RSpec syntax.](http://yujinakayama.me/transpec/)

[Better Specs { RSpec guidelines with ruby }](http://www.betterspecs.org/)

[RSpec::Expectations Cheat Sheet](https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/)

[RSpec Mocks and Stubs in Plain English](https://www.codewithjason.com/rspec-mocks-stubs-plain-english/)

[Examples of pointless types of RSpec tests](https://www.codewithjason.com/examples-pointless-rspec-tests/)

[rspec-rainbow 🌈](https://github.com/mscoutermarsh/rspec-rainbow)

## Running Specs

[Running Rspec examples by name, or: Running a single shared example](https://makandracards.com/makandra/47400-running-rspec-examples-by-name-or-running-a-single-shared-example)

e.g. `be rspec ./src/components/date_picker/v1_0/ruby/spec/view_helpers_spec.rb --example '#apl_date_picker_field_tag_v1_0'`

### `--order` option

<https://relishapp.com/rspec/rspec-core/docs/command-line/order>

Use `--order defined` if want to run them in the actual order and not randomly


### Time

Freeze time:

Timecop

```ruby
let(:today) { Timecop.freeze { Time.zone.parse("26 September 2017") } }

before do
  allow(Time).to receive(:now).and_return(today)
end
```

### Matching

Match part if a filename:

```ruby
expect(result.filename).to match(/111222_0000060962TR01A_26_09_2017_.+\.csv/)
```

### Change

Discovered that instead of doing

```ruby
expect { post :create, params: params }.to change { Guess.count }.by(1)
```

you can do

```ruby
expect { post :create, params: params }.to change { Guess.count }.from(0).to(1)
```

Which is better then the first expect because it will mean that it will be less likely to fail if there was a race condition (??)

[Understanding RSpec Expect and Change Syntax in the context of Ruby](https://forum.shakacode.com/t/understanding-rspec-expect-and-change-syntax-in-the-context-of-ruby/219)

## Stubbing a helper method

(in a presenter spec)

Wanted to test a presenter (that only returned links), when ran test, a helper method failed

```bash
NoMethodError:
       undefined method `product_end_notice_sent?' for nil:NilClass
```

In test have done this:

```ruby
allow_any_instance_of(ThisHelper).to receive(:show_bananas?).and_return(true)
```

Not sure if `allow_any_instance_of` is good to use.
- no, not anymore - https://rubocop-rspec.readthedocs.io/en/latest/cops_rspec/#rspecanyinstance

do something like this

```ruby
this_helper = instance_double(ThisHelper)
allow(ThisHelper).to receive(:show_bananas?).and_return(true)

# or if need it to return the class
allow(ThisHelper).to receive(:later).and_return(this_helper)
```

## [Aggregating Failures](https://relishapp.com/rspec/rspec-core/docs/expectation-framework-integration/aggregating-failures)

> RSpec::Expectations provides aggregate_failures, an API that allows you to group a set of expectations and see all the failures at once, rather than it aborting on the first failure.
>
> ```ruby
> it "returns a successful response" do
>  response = Client.make_request
>
>  aggregate_failures "testing response" do
>    expect(response.status).to eq(200)
>    expect(response.headers).to include("Content-Type" => "application/json")
>    expect(response.body).to eq('{"message":"Success"}')
>  end
> end
> ```

### RSpec Shared Examples

So, was adding a context in the below spec. I knew when I was adding it that there would be a better way of doing it.

```ruby
# frozen_string_literal: true

require 'spec_helper'

module Api
  module V1
    RSpec.describe NotificationsController do

      describe 'POST#read' do
        subject(:mark_as_read) do
          post(
            :create,
            params: {
              id: something.id,
              ids: notifications.map(&:id)
            }
          )
        end

        context 'when experience is apple' do
          let(:customer) { customers(:apple_for_external_api) }
          let(:access_token) { oauth_tokens(:apple_customer_for_external_api) }

          let(:notification_one) do
            customer_notification_events(:unread_customer_notification)
          end
          let(:notification_two) { notification_one.dup.tap(&:save!) }
          let(:notifications) { [notification_one, notification_two] }

          it 'marks supplied notifications as read' do
            mark_as_read

            expect(notification_one.reload.read_at).to be_present
            expect(notification_two.reload.read_at).to be_present
          end

          it 'responds with 204' do
            mark_as_read

            expect(response.status).to eql(204)
          end
        end

        # added in this context
        # lots of duplication of the first context block
        context 'when experience is banana' do
          let(:customer) { customers(:banana_customer) }
          let(:access_token) { oauth_tokens(:banana_customer) }

          let(:notification_one) do
            customer_notification_events(:unread_customer_notification)
          end
          let(:notification_two) { notification_one.dup.tap(&:save!) }
          let(:notifications) { [notification_one, notification_two] }

          it 'marks supplied notifications as read' do
            mark_as_read

            expect(notification_one.reload.read_at).to be_present
            expect(notification_two.reload.read_at).to be_present
          end

          it 'responds with 204' do
            mark_as_read

            expect(response.status).to eql(204)
          end
        end
      end
    end
  end
end
```

Got feedback in code review around lots of duplication, could be good to break out into using shared examples. Not knowing much about shared examples I was a bit hesitate. However, the reviewer shared this:

<https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples#shared-examples-group-included-in-two-groups-in-one-file>

and I found an example in the code base as well.

So changed the above to this:

```ruby
# frozen_string_literal: true

require 'spec_helper'

module Api
  module V1
    RSpec.describe NotificationsController do
      describe 'POST#read' do
        let(:customer) { customers(:apple_for_external_api) }
        let(:access_token) { oauth_tokens(:apple_customer_for_external_api) }

        let(:notification_one) do
          customer_notification_events(:unread_customer_notification)
        end
        let(:notification_two) { notification_one.dup.tap(&:save!) }
        let(:notifications) { [notification_one, notification_two] }

        subject(:mark_as_read) do
          post(
            :create,
            params: {
              id: something.id,
              ids: notifications.map(&:id)
            }
          )
        end

        shared_examples 'updates notification read_at' do
          it 'marks supplied notifications as read' do
            mark_as_read

            expect(notification_one.reload.read_at).to be_present
            expect(notification_two.reload.read_at).to be_present
          end

          it 'responds with 204' do
            mark_as_read

            expect(response.status).to eql(204)
          end
        end

        context 'when experience is apple' do
          include_examples 'updates notification read_at'
        end

        context 'when experience is orange' do
          before do
            customer.update(experience: "orange")
            access_token.update(customer_id: customer.id)
            notification_one.update(customer: customer)
          end

          include_examples 'updates notification read_at'
        end
      end
    end
  end
end
```

Seems a lot clearer and there is a lot less duplication.

## Matchers - `be true`, `be_truthy`

<https://eddyluten.com/rspec-be_truthy-exists-or-be-true>

<https://relishapp.com/rspec/rspec-expectations/v/3-9/docs/built-in-matchers> - Truthiness and existentialism

<https://medium.com/@bartoszkrajka/a-note-on-truthiness-in-rspec-1484defd7c3c>

## [Working with legacy code](https://relishapp.com/rspec/rspec-mocks/v/3-9/docs/working-with-legacy-code)

>RSpec provides a few features that, while not generally recommended, can be useful when you are getting legacy code under test (or in similar situations). Usage of these features should be considered a code smell.

[allow_any_instance_of](https://relishapp.com/rspec/rspec-mocks/v/3-9/docs/working-with-legacy-code/any-instance)

[receive_message_chain](https://relishapp.com/rspec/rspec-mocks/v/3-9/docs/working-with-legacy-code/message-chains)

## specify

<https://til.hashrocket.com/posts/edefa42db2-rspec-specify>

<https://rubydoc.info/gems/rspec-core/RSpec/Core/ExampleGroup#specify-class_method>

## Using pluck

```ruby
it "only shows stories for child" do
  get :index, params: { q: "story" }, format: :json

  titles = json[:stories].pluck(:title)

  expect(titles).to include(story_for_my_child.title)
  expect(titles).to_not include(story_for_other_child.title)
end
```

## `RSpec.describe`

<https://relishapp.com/rspec/rspec-core/v/3-3/docs/configuration/zero-monkey-patching-mode>

<https://github.com/rspec/rspec-rails/commit/ca0d249858903949052e06884e8e7f9d596cdc79>

>Always using only the non-monkey patched `RSpec.describe`, instead of
>inspecting the configuration, has the benefits of:
>
>- not requiring RSpec to be loaded when the generators are run by Rails
>- not introducing extra logic and state to handle the different states
>- Resolve #1048

## JSON - format or as

In controller tests, if use `format: :json`, as you are passing a hash, it will convert non strings to strings. This caused me issues when I had a validation happening where it was validating `true` and `false`, not `"true"` and `"false"`. I think the default is also `format: :json`.

```ruby
valid_params =
    {
      content: "content",
      announcement: false,
      updated_media_items: [stuff]
    }

  it "returns a 200 OK status" do
    post :create, params: { centre_id: centre.id, community_post: valid_params }, as: :json # default is format: :json

    expect(response).to have_http_status(:ok)
  end
```

```json
{
  "content" => "This is some content for this post.",
  "announcement" => "false",
  "updated_media_items" => [
    {
      "key" => "mi_1",
      "name" => "",
      "size" => "",
      "media_type" => "1"
    }
  ]
}
```

But if you use `as: :json`, then it does pass it properly through as json.

```json
{
  "content" => "This is some content for this post.",
  "announcement" => false,
  "updated_media_items" => [ {
      "key" => "mi_1",
      "name" => nil,
      "size" => nil,
      "media_type" => 1
    }
  ]
}
```

## Skipping tests

Learnt that you can do this

```ruby
describe "media paths", skip: "until we reintroduce profile_medium" do
  it
  it
```

And it will print out like:

```text
  media paths
    returns default url if it doesn't (PENDING: until we reintroduce profile_medium)
    returns a serialized media url if it has one (PENDING: until we reintroduce profile_medium)
```

Could be pretty handy.
