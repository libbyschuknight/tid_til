# [Mastering the Shell](https://thoughtbot.com/upcase/mastering-the-shell)

Printing out text from a file

`cat readme.md` - whole file

`head readme.md` - first 10 lines

`tail readme.md` - last 10 lines

Different number of lines, pass the `-n` flag

`head -n 5 readme.md` first 5 lines


`grep` to search

`grep Hello greetings.txt` - will find all the `Hello`'s in the file

`grep --ignore-case rails tid.md` - ignores case
`grep -i rails tid.md` - same as above

`grep` supports some regex, with `grep -E` it does all regex

`grep -E '[Rr]ails' tid.md` - find all rails lower or upper

`grep --invert-match rails tid.md` - find all lines without rails in it
`grep -v rails tid.md`

`grep -i -v rails tid.md` - finds all lines with rails or Rails in it


 With `ls`, can list what is inside a directory:

 `ls rails` - will show all files and directories

 Using `tree` - `brew install tree`, can show tree structure of directories:

 `tree rails/how_to_rails`

 ```
 rails/how_to_rails
├── 1_my_go_surf_project.md
├── 2_my_go_surf_project.md
├── 3_my_go_surf_project.md
└── images
    ├── adding_remote.png
    ├── creating_repo.png
    ├── go_surf.JPG
```

 Can do this is search one file:
 `grep surf rails/how_to_rails/3_my_go_surf_project.md`

If want to search more then one file:

`grep -r surf rails/how_to_rails`

prints out file name and line that has word on it

```
rails/how_to_rails/3_my_go_surf_project.md:  @surf_spot = SurfSpot.new(surf_spot_params)
rails/how_to_rails/3_my_go_surf_project.md:  @surf_spot.save
rails/how_to_rails/3_my_go_surf_project.md:  redirect_to @surf_spot
```

`grep -v -r surf rails/how_to_rails`


`sed` - command line tool to that changes text and prints out new text

`sed 's/rails/bananas/' tid.md` - will replace `rails` with `bananas` in what is printed out but will not change the content of the file

`sed` can use regex and takes a `-E` flag as well, for advanced regular expressions

To change the original file:

`sed -i '.old' 's/Hello/Goodbye/' greetings.txt`

`-i` inline, and then add `.old` saves the old file to another file

`sed -i '' 's/Hello/Goodbye/' greetings.txt` basically saves over current file
