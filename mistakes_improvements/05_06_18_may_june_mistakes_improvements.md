# May / June Mistakes, Improvements

## Passing args into rake task when using zsh

[How To Use Arguments In a Rake Task](https://robots.thoughtbot.com/how-to-use-arguments-in-a-rake-task)
where it has `rake tweets:send\[cpytel\]`

So tried:
`rake brands:create\[test_brand\]` worked

See - [rake tasks and zsh](terminal/terminal_stuff.md#rake tasks)


## ruby - .insert

Had to do some stuff with tab links that are in an array. Changed the order of when they were created, which meant one that was second to last ended up being last.
To get this back into the right position I used `.insert`

```ruby
letters = Array.new(['a', 'b', 'c'])
 => ["a", "b", "c"]

 letters.insert(letters.length - 1, 'Z')
 => ["a", "b", "Z", "c"]
 ```

 https://gistpages.com/posts/ruby_arrays_insert_append_length_index_remove

 https://ruby-doc.org/core-2.5.0/Array.html#method-i-insert


 ## exclude from git (not git ignore)

 Found this useful again for a place to add notes when doing reading

 Add to `.git/info/exclude`

 e.g. if you want to have a local folder but not have it in git or in the `gitignore` file

 `local/*`

 [Exclude files from git without committing changes to .gitignore 🙅](https://hackernoon.com/exclude-files-from-git-without-committing-changes-to-gitignore-986fa712e78d)
