# October Mistakes & Improvements

### git config

Had issue with using the zsh command `gcmsg`, which is `git commit -v`, it would open atom but in the terminal kept coming up with
`Aborting commit due to empty commit message.`

Quick searched showed I needed to set the config to wait:
`git config --global core.editor "atom --wait"`

Now, working all good!


### gotcha - ruby class, attr_accessor

Oh! a gotcha! was just trying out swapping around some `attr_readers` and `attr_accessors` and had this code:

```ruby
class State
  attr_reader :letters, :correct_letters, :incorrect_letters
  attr_accessor :lives,

  def initialize
    @letters = WordGenerator.random_word.chars
    @lives = 10
    @correct_letters = []
    @incorrect_letters = []
  end
   ...
end
```
And when my test was doing `state = State.new` and then `state.lives` and getting `nil` I was very confused! as I had been sure it was working just before.
Well, it is that little comma I left after `lives`!
