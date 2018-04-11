# RSpec

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
