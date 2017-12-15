# November Mistakes & Improvements

### .find or .find_by

>Difference between find and find_by_id (continues........)
>Other than the differences that i mentioned in my last post , one more major difference is there....
>"find" fires an "Exception" if the record related to given ID is not fount. This leads to the "Crash" of the server.
while "find_by_id" doesn't fires an "Exception" , if the record related to given ID is not in Table it simply returns "nil" value, and doesn't halt the running "Server".

http://railssolutions.blogspot.co.nz/2012/02/difference-between-find-and-findbyid.html

DHH explains the difference:
https://stackoverflow.com/questions/4966430/rails-2-model-find1-gives-activerecord-error-when-id-1-does-not-exist/4966553#4966553


### safe navigation activerecord

Had this `last_guess && last_guess.correct`, can do as this `last_guess&.correct`

[The Safe Navigation Operator (&.) in Ruby](http://mitrev.net/ruby/2015/11/13/the-operator-in-ruby/)


# December Mistakes & Improvements

### Where to put methods on activerecord models with associations

In a pretend app, have a `User`, that has many `Reads`, had this on the `Read` model:

```ruby
class Read < ApplicationRecord
  belongs_to :user

  validates :kwh,
            presence: true,
            numericality: { greater_than: 0 }

  validate :greater_than_last_reading

  scope :most_recent_first, -> { order(updated_at: "desc") }

  def greater_than_last_reading
    unless user.reads.empty?
      if kwh < most_recent_read.kwh
        errors.add(:kwh, "must be greater than last reading")
      end
    end
  end

  private

  def most_recent_read
    user.reads.most_recent_first.first
  end
end
```

So, getting `reads` and `most_recent_read` by going to the user first. Following code review have changed to:

```ruby
class Read < ApplicationRecord
  belongs_to :user

  validates :kwh,
            presence: true,
            numericality: { greater_than: 0 }

  validate :greater_than_last_reading

  private

  def greater_than_last_reading
    if user && !user.reads.empty?
      if kwh < user.most_recent_read.kwh
        errors.add(:kwh, "must be greater than last reading")
      end
    end
  end
end
```

And added things onto the `User` model:

```ruby
class User < ApplicationRecord
  has_many :reads

  ...

  def most_recent_reads_first
    reads.order(updated_at: "desc")
  end

  def most_recent_read
    most_recent_reads_first.first
  end
end
```


### Testing destroy

Instead of doing this in a controller test, which could be affected by another database action:

```ruby
let(:read) { Read.create!(kwh: 234.45, user: customer) }

it "destroys the reading" do
  read
  expect {
    delete :destroy, params: { user_id: customer.id, id: read.id }
  }.to change(Read, :count).by(-1)
end
```

Have done this:

```ruby
let(:read_id) { Read.last.id }

before do
  Read.create!(kwh: 234.45, user: customer)
end

it "destroys the reading" do
  delete :destroy, params: { user_id: customer.id, id: read_id }
  expect(Read.find_by(id: read_id)).to eq(nil)
end
```

Now, it is specifically looking for a particular id, and doing `find_by(id: id)` returns `nil` if there is nothing found.
