# October & November 2019 Mistakes, Improvements, Learning and Stuff

My mac at home needs to be updated. It is still on Sierra. I was doing some updating and upgrading of brew things and after when I tried to use irb, the arrow keys and using keys like `ctrl + a` had stopped working.

After some googling and trying to upgrade ruby-build and readline things, I searched in the work slack and got to this stack overflow post - <https://stackoverflow.com/questions/54261455/library-not-loaded-usr-local-opt-readline-lib-libreadline-7-dylib>.

Tried this:

```bash
cd /usr/local/opt/readline/lib
ln -s libreadline.8.dylib libreadline.7.dylib
```

And now keys are working when in irb! Yay!
