# RSpec

### Time

Freeze time:

Timecop

`let(:today) { Timecop.freeze { Time.zone.parse("26 September 2017") } }`


### Matching

Match part if a filename:

`expect(result.filename).to match(/111222_0000060962TR01A_26_09_2017_.+\.csv/)`
