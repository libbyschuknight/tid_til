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
##### binding.pry
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

##### ENV
When using `pry`, you can type `ENV` and it will show all the environment variables! Yay!

```
=> {"ADDRESSFINDER_CLEANSING_KEY"=>"XXXXX",
"ADDRESSFINDER_CLEANSING_SECRET"=>"XXXXX",
"AWS_ACCESS_KEY_ID"=>"XXXXX",
"AWS_REGION"=>"XXXXXX",
"AWS_SECRET_ACCESS_KEY"=>"XXXXXX",
"Apple_PubSub_Socket_Render"=>"/private/tmp/com.apple.launchd.zBbBBbxFLf/Render",
"BUNDLE_BIN_PATH"=>"/Users/libby/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/exe/bundle",
"BUNDLE_GEMFILE"=>"/Users/libby/Code/customer_app/Gemfile",
"BUNDLE_ORIG_MANPATH"=>
"/Users/libby/.XXXXXXXXX",
....
"API_HOST"=>"https://uat.XXXXXXX",
```

This was important as I though I was running something in localhost but it was actually still connected to UAT.

##### ls for methods

```bash
[5] pry(main)> ls Array

Object.methods: yaml_tag
Array.methods: []  try_convert  wrap
Array#methods:
  &       bsearch      drop_while        hash         prepend               rindex     sort!           to_xml
  *       clear        each              include?     pretty_print          rotate     sort_by!        transpose
  +       collect      each_index        index        pretty_print_cycle    rotate!    take            uniq
  -       collect!     empty?            insert       product               sample     take_while      uniq!
  <<      combination  eql?              inspect      push                  select(!)  to_a            unshift   # (!) is just in this line, to make formatting below work properly
  <=>     compact      extract_options!  join         rassoc                select!    to_ary          values_at
  ==      compact!     fetch             keep_if      reject                shelljoin  to_csv          zip
  []      concat       fill              last         reject!               shift      to_default_s    |
  []=     count        find_index        length       repeated_combination  shuffle    to_formatted_s
  any?    cycle        first             map          repeated_permutation  shuffle!   to_h
  append  delete       flatten           map!         replace               size       to_param
  assoc   delete_at    flatten!          pack         reverse               slice      to_query
  at      delete_if    frozen?           permutation  reverse!              slice!     to_s
  blank?  drop         grep              pop          reverse_each          sort       to_sentence
```

##### Pry-Byebug
I have been using Pry and `binding.pry` a lot in a Ruby app using Sequel ORM. When using `pry` I haven't been able to use `next`, `continue` etc. I finally took the time to look into this and I needed to add `pry-byebug`. This is because `pry` doesn't have these navgiation commands, however, `pry-rails` does (I think), which is what I have been used to
https://github.com/pry/pry/wiki/Available-plugins#pry-byebug

##### Exiting out of Pry/Rails when running `binding.pry` in code/server
Any of these:

```bash
exit-program / !!! / exit-p / exit! / disable-pry
```

# Generate random UUID
```bash
uuidgen

# output
55AD6699-780F-499A-A49B-AF0AF6D2747E
```
This is cool, but I don't like that letters are in upper case. Found this:
https://coderwall.com/p/t_sz3q/generate-uuid-at-shell-prompt

```bash
alias uuid="uuidgen | tr -d - | tr -d '\n' | tr '[:upper:]' '[:lower:]'  | pbcopy && pbpaste && echo"

# output
3ff7489e07644c93a444fd8c54f15965
```
Now missing the hyphens which want to keep, so have taken out the deleting of the `-`

```bash
alias uuid="uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]'  | pbcopy && pbpaste && echo"
```
