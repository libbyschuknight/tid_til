# Terminal Stuff

Can do 'more <file_name>` and will show more information that is in file.
E.g.
`more .env.local`

```bash
DATABASE_DSN="postgresql://localhost/$(echo $SERVICE_NAME)_$(echo $RACK_ENV)"
ERRORS_TOKEN="XXXXXXXXXX"
ENVIRONMENT="test"
USERNAME=""
PASSWORD=""
```
`cat .env.local` will do the same thing.

A quick search of what `cat` is and found this link - [10 Terminal Commands That Will Boost Your Productivity](http://code.tutsplus.com/articles/10-terminal-commands-that-will-boost-your-productivity--net-14105).


### Pry
When using a `binding.pry` to debug stuff, really useful command to know is:
```bash
whereami
```
this will take you to where you are in the code. Very useful if you have been trying out different things and where you were as disappeared of the screen.

```
20: def event(params:)
21:   event = Models::Event.new_event(params: params)
22:   binding.pry
23:   if state_machine.can_new_event?
24:     state_machine.fire_state_event(:get_new_event)
25:     self.state = state_machine.state
26:     save
27:     true
28:   else
29:     event.invalid!
30:     false
31:   end
32: end
```

##### Pry-Byebug
I have been using Pry and `binding.pry` a lot in a Ruby app using Sequel ORM. When using `pry` I haven't been able to use `next`, `continue` etc. I finally took the time to look into this and I needed to add `pry-byebug`. This is because `pry` doesn't have these navgiation commands, however, `pry-rails` does (I think), which is what I have been used to.z tid
https://github.com/pry/pry/wiki/Available-plugins#pry-byebug
