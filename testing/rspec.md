# RSpec

[RSpec Documentation](https://rspec.info/documentation/)
[RSpec Relish](https://relishapp.com/rspec)

[Better Specs { rspec guidelines with ruby }](http://www.betterspecs.org/)

[RSpec::Expectations Cheat Sheet](https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/)

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
