# Scripting

From Slack discussion with Samson

>A script is basically just a ruby file you run from the command line. Most people mean it as a file that does one task and might be a one-off or throw away thing.
You might have considered the first few challenges you wrote at EDA as Ruby scripts.

>A task that is simple enough to live in one file (even if it has more than one class in it perhaps) and that you run it like `ruby my_script.rb` in the terminal.

>If you put a “shebang” at the very first line of a script file like `#!/usr/bin/env ruby` and in the terminal use `chmod +x my_script` (say the file is called `my_script` without the `.rb` at the end) then the user doesn’t even have to know what it is written in. They can just run that script by entering `./my_script` into the terminal or if you put that file into one of your bin PATH folders (`echo $PATH` to see which folders these are) then you could just run it like any other terminal command `my_script`
