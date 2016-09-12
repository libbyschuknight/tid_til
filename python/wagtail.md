# Starting out with Wagtail

https://wagtail.io/


http://wagtail.readthedocs.io/en/latest/getting_started/index.html

## Getting Started - hiccups!

#### Python
```bash
python -V
=> Python 2.7.10
```
I like to use the most up to date stuff so went about installing Python 3:
http://wagtail.readthedocs.io/en/latest/getting_started/index.html
Python 3.5.2

I was then like, how do I run, as whenever I typed `python`in terminal it would run `2.7.10`

If I had bothered to dig further into the Python docs, I would have found this:
https://docs.python.org/3/tutorial/interpreter.html, saying to type in `python3.5`.
I actually did a quick google before looking back at the docs and found that you can do `python3`. Might make an alias for it soon!

#### Pip
And I did the same thing with pip, for Python3 it is `pip3`!
I was trying to upgrade `pip` as the Wagtail docs say that it comes with Python3 but you will need to upgrade.
The upgrade dos just have `pip install -U pip`, nooo, it is `pip3 install -U pip`

What even is `pip`?
>pip is a package management system used to install and manage software packages written in Python.
https://en.wikipedia.org/wiki/Pip_(package_manager)


#### Virtualenv
This confused me a lot. The Wagtail docs assume you know about this.

I had used it for the [DjangoGirls tutorial](http://tutorial.djangogirls.org/en/) so I went back to look at that.

Under [Django installation](http://tutorial.djangogirls.org/en/django_installation/) it goes over the virtual environment. What the did was this:

```bash
mkdir test
cd test
python3 -m venv myvenv
```
which will make a myvenv folder with stuff in it:

```bash
bin        include    lib        pyvenv.cfg
```
Then:
```bash
source myvenv/bin/activate
```
Which starts the virtual env. My termianl command line now looks like this:
```bash
(myvenv) ~/code/python/play/test

# instead of
 ~/code/python/play/test
```

To stop the env:
```
deactivate
```

#### Important note
>Important
>Before installing Wagtail, it is necessary to install the libjpeg and zlib libraries, which provide support for working with JPEG, PNG and GIF images (via the Python Pillow library). The way to do this varies by platform - see Pillow’s platform-specific installation instructions.
http://pillow.readthedocs.io/en/latest/installation.html#external-libraries

Did this:
```bash
# Install Pillow with pip:
pip install Pillow
```
Wasn't sure if worked, went down to "Building on OS X" http://pillow.readthedocs.io/en/latest/installation.html#building-on-os-x

Did this:
```bash
brew install libtiff libjpeg webp little-cms2
```

When I do `brew list`, get:
```bash
ack         freetype          icu4c           libtool         minicom         postgresql     unixodbc
autoconf    gdbm              imagemagick     libxml2node     python3         watchman
automake    gettext           jpeg            libyaml         openssl         rbenv          webp
brew-cask   git               libgpg-error    little-cms2     pcre            readline       wxmac
elixir      heroku            libksba         mariadbphp55    ruby-build      xz
erlang      heroku-toolbelt   libpng          mcrypt          php55-mcrypt    sqlite zsh
exercism    hunspell          libtiff         mhash           pkg-config      tree
```

And I think `jpeg` is `libjpeg`, as when I try to do `brew install libjpeg` I get `Warning: jpeg-8d already installed`


I now think I am in the right place to get Wagtail started.

# Really getting started

```bash
mkdir one-wgt
cd one-wgt
python3 -m venv env
source env/bin/activate
```
Now in the virtual environment and starting at the beginning - http://wagtail.readthedocs.io/en/latest/getting_started/index.html

So, have been doing the commands and can just do `pip` when inside the virtual env. Handy!

mysite - admin/wagtail




Up to
http://wagtail.readthedocs.io/en/latest/getting_started/tutorial.html#wagtail-template-tags


https://wagtail.io/blog/getting-started-wagtail-newcomers-perspective/
