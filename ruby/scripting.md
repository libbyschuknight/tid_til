# Scripting

From Slack discussion with Samson

> A script is basically just a ruby file you run from the command line. Most people mean it as a file that does one task and might be a one-off or throw away thing.
> You might have considered the first few challenges you wrote at EDA as Ruby scripts.
>
> A task that is simple enough to live in one file (even if it has more than one class in it perhaps) and that you run it like `ruby my_script.rb` in the terminal.
>
> If you put a “shebang” at the very first line of a script file like `#!/usr/bin/env ruby` and in the terminal use `chmod +x my_script` (say the file is called `my_script` without the `.rb` at the end) then the user doesn’t even have to know what it is written in. They can just run that script by entering `./my_script` into the terminal or if you put that file into one of your bin PATH folders (`echo $PATH` to see which folders these are) then you could just run it like any other terminal command `my_script`

Example

```ruby
#!/usr/bin/env ruby

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")

require "pry"

require "hangman"
require "console_io"

new_game = Hangman.new
new_game.game_loop
```

To get working in console:
`chmod +x play_hangman.rb` - adds as executable to console

can then run with `./play_hangman.rb`

and even better, make an alias for it (for me in my .zshrc file)

`alias hangman="./play_hangman.rb"`

now can just type `hangman` and the game will run!

Another explanation from Samson via slack:

> some background on running scripts and such:
>
> - Lets say you had a script `my_script.rb` the `.rb` extension in that case tells you the user it is a Ruby file and needs to be run with `ruby my_script.rb`. The computer otherwise doesn’t do much with this. On a desktop it runs a program to figure out from the extension what program to open the file with (like _Sublime_ or something) but that is not the same as executing that script.
> - Mac/Linux/Unix all have a concept of making files “executable” by changing the file permissions using something like `chmod +x my_script`. This is often paired with removing the filename extension so the `my_script.rb` file becomes just `my_script`. Then you can just run it by putting a dot-slash in front of it `./my_script` or other programs can run it.
> - But because there is no longer an extension (because we are trying to hide the implementation details of the script from the user) we need another way to tell the computer what type of script it is and what it needs to run it. That is commonly done with what is called a “shebang” and is something that looks like this as the very first line in the file `#!/usr/bin/env ruby`. Depending on the scripting language being used to run it `#!/usr/bin/env bash`, `#!/usr/bin/env python`, `#!/usr/bin/env node` being other common ones.

> So, next time see if you can open the file and check if it has that _shebang_ to tell the computer what language it is supposed to run it in and then make it executable with `chmod +x script_name` and then double check you can run it in the place you want it run with `./script_name`.
