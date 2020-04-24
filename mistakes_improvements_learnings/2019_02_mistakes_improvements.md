# Feb / March 2019 Mistakes, Improvements, Learning and Stuff

### Testing an API controller `before_action`:

Not sure if this is necessarily a good way to test this.

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

### VSCode

Just a reminder on how to do this. If want to include/exclude certain file types in the search, e.g. `*_spec.rb`

### Fixtures

Need to learn more about polymorphic associations.
This is useful when using fixtures - <http://ruby-journal.com/rails/define-fixtures-with-polymorphic-association/>
