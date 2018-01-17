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

#### Pry in rails without adding gem to gemfile

https://stackoverflow.com/questions/8377263/rails-console-with-pr

`pry -I . -r config/environment` works to launch pry in a Rails environment, so I can just alias `rails pry` to that in my `bashrc`.

#### Getting awesome print working
Add to `./pryrc`

```
require "awesome_print"
AwesomePrint.pry!
```



##### ENV
When using `pry` or `irb`, you can type `ENV` and it will show all the environment variables! Yay!

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
  "<<"    combination  eql?              inspect      push                  select(!)  to_a            unshift   # get formatting working, had to had the ""
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
I have been using Pry and `binding.pry` a lot in a Ruby app using Sequel ORM. When using `pry` I haven't been able to use `next`, `continue` etc. I finally took the time to look into this and I needed to add `pry-byebug`. This is because `pry` doesn't have these navigation commands, however, `pry-rails` does (I think), which is what I have been used to
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

# Terminal Basics

### Renaming / Moving

http://themackhack.blogspot.co.nz/2012/10/mac-osx-terminal-how-to-rename-file-or.html

```bash
mv old-folder-name new-folder-name
mv /path/to/old /path/to/new
```

## Find directory path of current folder

```bash
pwd
```

## Keyboard Commands

`ctrl + u`    deleting a line    
`ctrl + y`    bringing that back   
`ctrl + r`    back search   
`open .`      will open the current dir in the finder   
`cmd + r`     take off screen   
`cmd + k`     will get rid of forever   
`ctrl - a`      beginning of line   
`ctrl - e`      end of line   
`opt - f`       forward word   
`opt - b`       backward word   
`ctrl - f`      forward character   
`ctrl - b`      backward character   
`ctrl - d`      delete character   
`ctrl - l`      clear screen   

Copy the Current Path from Terminal to the Clipboard in Mac OS X\
`pwd|pbcopy`

Save Mark/Jump to Mark
`cmd - shift - M`   save mark
`cmd - shift - J`   jump back to it with


## Screen sessions (remote servers)
[GNU Screen](http://aperiodic.net/screen/quick_reference)

check if any screens running
```
screen -ls
```

to start session
```
screen -S <name> # can add name if want to
```
press return
do what you want, e.g. console stuff to db

to detach `ctrl + a d`

to go back in

```
screen -ls
screen -r <number or name>
```

to exit screen, this will stop things running
`exit`


Scrolling when in a screen -

can do Shift + Pg_up & Shift + Pg_down

 https://www.cyberciti.biz/faq/scroll-up-down-look-at-data-in-gnuscreen-using-pageup-pagedown-keys/
CTRL-A, then [, then

CTRL-u and CTRL-d scroll the display up/down by the specified amount of lines while preserving the cursor position. (Default: half screen-full).
CTRL-b and C-f scroll the display up/down a full screen.



http://smallbusiness.chron.com/scroll-up-linux-screen-46302.html - haven't tried this

## Terminal Commands
Lists out in datetime order
`ls -l`
```bash
drwx------   6 libby  staff   204 29 Mar 08:37 Applications
drwxr-xr-x  24 libby  staff   816  1 Jun 15:22 Code
drwx------+ 31 libby  staff  1054 21 Jun 08:52 Desktop
drwx------+ 20 libby  staff   680 24 Jun 10:21 Documents
drwx------+ 45 libby  staff  1530 29 Jun 12:31 Downloads

```
Lists hidden folders/files as well
`ls -a`
```bash
.                                      .npm                                   Applications
..                                     .nvm                                   Code
.CFUserTextEncoding                    .oh-my-zsh                             Desktop
.DS_Store                              .phantomjs                             Documents
.Trash                                 .pry_history                           Downloads
.atom                                  .pryrc                                 Dropbox
```



`ls -la | pbcopy`  ||  `ls | pbcopy`
pipes the
`ls -la` || `ls`

e.g
```
README.md
api_stuff
articles_links_etc.md
code_reviews
courses_etc.md
databases
gems
git_github
html_css
miscellaneous.md
non_technical.md
notes.md
php
questions.md
rails
ruby
server_rack.md
terminal
terms.md
testing
text_editors
tid.md
work_flow.md
```

### [Stop rails server from the command line](https://www.codementor.io/tips/2171438772/stop-rails-server-from-the-command-line)
stoping rails server if `ctrl + c` doesn't work or PIDs are still running and need to be shutdown.

`ctrl + z` will also quit out of a rails server of `ctrl + c` doesn't work.


### Remote servers

#### Ruby applications

Open up an irb console:
`bundle exec irb -r "./config/application.rb"`

Or pry:
`bundle exec pry -r ./config/environment`

Open up the postgres DB:

`psql <database_name>` or should `psql ENV["DATABASE_DSN"]` work? (am not sure?)

To find the database name, you can go into irb console and then type
`ENV["DATABASE_DSN"]`.


How to get syntax highlighting when using `cat`. First in the terminal:
(thanks to @Ootoovak)
```
brew install python # if you haven't already
pip install pygments
```
Then edit you `~/.zshrc` file and add:
```
alias cat='pygmentize -g -O style=colorful,linenos=1' # I actually alias mine to `show`
```
Got that from: http://stackoverflow.com/a/27501509/908793


## Manually running report, download as CSV

Example of when might need to use, if have a report that times out on server, then want to run report manually in rails console.

Go onto server, open up rails console

```ruby
params = ActiveSupport::HashWithIndifferentAccess.new({
    "thing_ref" => "ref_thing_here",
                 "file_status" => "I"
})

things =
  ThingsFetcher.retrieve_things(
    thing_ref: params[:thing_ref]
  )

presenter =
  ThingPresenter.new(
    params: params,
    things: things
  )

filename = "#{Rails.root}/#{presenter.filename}"

File.open(filename, 'w') { |file| file.write(presenter.to_csv) }
```

##### Get file from server
You have to be in local terminal NOT on server.

```bash
scp server.name:/apps/customer_app/releases/20160922043147/filename.csv ~/Downloads/filename.csv
```

## irb - interactive ruby

>Irb has a built in help function. While in irb, you can type `help 'Hash#reduce'` for example and get the docs & an example in your terminal. Try `help 'Object#tap'`.
Raquel Moss - #tech-links FlickElectric


## Programs installed via Homebrew (see gist)

### [Fuzzy Finder](https://github.com/junegunn/fzf)

- fzf is a general-purpose command-line fuzzy finder

- install via homebrew `brew install fzf`

To get working:

`/usr/local/opt/fzf/install`

then reload shell (e.g `source ~/.zshrc`)

use `ctrl + r` and should bring up the fuzzy search

TODO: add images

[fzf](http://sourabhbajaj.com/mac-setup/iTerm/fzf.html)





## Things
### Get Date and Time

```bash
date
# Wed 12 Jul 2017 14:46:27 NZST

date +"%T"
# 14:46:52
```

[Linux: Bash Get Time](https://www.cyberciti.biz/faq/unix-linux-bash-get-time/)
[Display Date And Time In Linux](https://www.cyberciti.biz/faq/linux-display-date-and-time/)
