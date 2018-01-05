# November Mistakes & Improvements

### .find or .find_by

>Difference between find and find_by_id (continues........)
>Other than the differences that i mentioned in my last post , one more major difference is there....
>"find" fires an "Exception" if the record related to given ID is not fount. This leads to the "Crash" of the server.
while "find_by_id" doesn't fires an "Exception" , if the record related to given ID is not in Table it simply returns "nil" value, and doesn't halt the running "Server".

http://railssolutions.blogspot.co.nz/2012/02/difference-between-find-and-findbyid.html

DHH explains the difference:
https://stackoverflow.com/questions/4966430/rails-2-model-find1-gives-activerecord-error-when-id-1-does-not-exist/4966553#4966553

  >When you use a finder driven by primary keys, you’re looking for a particular record. You expect it to exist. A call to Person.find(5) is based on our knowledge of the people table. We want the row with an id of 5. If this call is unsuccessful—if the record with the id of 5 has been destroyed—we’re in an exceptional situation. This mandates the raising of an exception, so Rails raises RecordNotFound.

  >On the other hand, finders that use criteria to search are looking for a match. So, Person.find(:first, :conditions=>"name=’Dave’") is the equivalent of telling the database (as a black box) “Give me the first person row that has the name Dave.” This exhibits a distinctly different approach to retrieval; we’re not certain up front that we’ll get a result. It’s entirely possible the result set may be empty. Thus, returning nil in the case of finders that search for one row and an empty array for finders that search for many rows is the natural, nonexceptional response.



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


### Database constraints

I hadn't bothered to put many db constraints into my minishop and no one had said anything about it until now, as was considering feedback found this
[Validation, Database Constraint, or Both?](https://robots.thoughtbot.com/validation-database-constraint-or-both)

which I think explains it well.

Also

[Required Fields Should Be Marked NOT NULL](https://www.viget.com/articles/required-fields-should-be-marked-not-null)

>For example, update_attribute ignores validations, as does save if you call it with the validate: false option.


### Commit messages

Feedback in merge request (credit to @trezona-lecomte)

>So for example on 4b049231, instead of "Small updates" you might say:

>`Add bad_customer fixture for reason x, adjust wording of cuke steps`

>`Because of x, we needed to add a bad_customer fixture. This new fixture allows
us to test y.>`

>`Also, adjust the wording of some cuke steps so that they read more naturally.`


>In general, I like to see the following in a commit message:

>`HEADLINE: the crux of this change. If you read only this line you at least know the gist of what the commit does.`

>`FIRST PARAGRAPH: The cause, motivation, or behaviour prior to this
commit. This gives context, in particular we're trying to illuminate
the *why* of this commit.`

>`NEXT PARAGRAPH: If necessary, this paragraph explains the context of
the solution. Often it's not needed, because the headline + first
paragraph + code are enough to understand the change. However, if your
solution does some non-standard or suprising stuff, then this is a
good place to explain the constraints that prompted you to solve the
problem in this way.
This is just a guide, there are many good templates out there, but in general we want to think about the why of both the problem and the solution.`
