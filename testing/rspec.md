# RSpec

[RSpec Documentation](https://rspec.info/documentation/)
[RSpec Relish](https://relishapp.com/rspec)

[Better Specs { rspec guidelines with ruby }](http://www.betterspecs.org/)

[RSpec::Expectations Cheat Sheet](https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/)

[RSpec Mocks and Stubs in Plain English](https://www.codewithjason.com/rspec-mocks-stubs-plain-english/)

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

```
NoMethodError:
       undefined method `product_end_notice_sent?' for nil:NilClass
```

In test have done this:

```
allow_any_instance_of(ThisHelper).to receive(:show_bananas?).and_return(true)
```

Not sure if `allow_any_instance_of` is good to use.


## [Aggregating Failures](https://relishapp.com/rspec/rspec-core/docs/expectation-framework-integration/aggregating-failures)

>RSpec::Expectations provides aggregate_failures, an API that allows you to group a set of expectations and see all the failures at once, rather than it aborting on the first failure.

>```ruby
>it "returns a successful response" do
>  response = Client.make_request
>
>  aggregate_failures "testing response" do
>    expect(response.status).to eq(200)
>    expect(response.headers).to include("Content-Type" => "application/json")
>    expect(response.body).to eq('{"message":"Success"}')
>  end
>end
>```

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

Got feedback in code review around lots of duplication, could be good to break out into using shared examples. Not knowing much about shared examples I was a bit hesistate. However, the reviewer shared this:

https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples#shared-examples-group-included-in-two-groups-in-one-file

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
