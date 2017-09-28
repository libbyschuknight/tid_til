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
