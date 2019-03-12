# 2019 Mistakes, Improvements, Learning and Stuff

### Testing an API controller `before_action`:

```ruby
module Api
  class NotificationsController < Base
    before_action :fetch_id, -> { allow_traits(:apple, :banana) }

    def create
      ...
    end
  end
end
```

```ruby
module Api
  RSpec.describe NotificationsController do
    describe 'POST#read' do
      # this use of expect_any_instance_of will mean that the tests in this spec will fail if any other traits are added or removed in the controller
      #  e.g. if we added in orange
      #    before_action :fetch_id, -> { allow_traits(:apple, :banaan, :orange) }
      #    see below for error message
      before do
        expect_any_instance_of(Api::NotificationsController).to receive(:allow_traits).with(:apple, :banana).and_call_original
      end

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
        ... # some code here

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
```

The RSpec error message you would get if you added another trait:

```
received :allow_experience_traits with unexpected arguments
         expected: (:apple, :banana)
              got: (:apple, :banana, :orange)
```

And the same would happen if a trait was removed from the controller.
We ended up doing this instead of adding a separate test to test the "sad path", as we are really just wanting to test that this endpoint is only used of the trait is either `apple` or `banana`.



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


### VSCode
Just a reminder on how to do this. If want to include/exclude certain file types in the search, e.g. `*_spec.rb`


### Fixtures

Need to learn more about polymorphic associations.
This is useful when using fixtures -http://ruby-journal.com/rails/define-fixtures-with-polymorphic-association/
