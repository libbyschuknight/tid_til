# jeyk;;

Jekyll
Using Jekyll to make this repo into a static site using GitHub pages.

I was thinking about using Jeykll to make this repo into a static site. I made a clone of this site and tried it out.

Decided that I actually want to keep all this stuff as is.

The site I followed to get myself started was [Make a Static Website with Jekyll](https://www.taniarascia.com/make-a-static-website-with-jekyll/). Here is [my cloned TID site](http://libbyschuknight.github.io/tid-copy/) that I got some pages up on.

It seemed pretty easy to get started. I pretty much follow this:

- `gem install jekyll`
- If you wish to install jekyll into an existing directory, you can do so by running `jekyll new .`` from within the directory instead of creating a new one. If the existing directory isn’t empty, you’ll also have to pass the `--force` option like so `jekyll new . --force`.
jekyll new . --force
This adds a bunch of folders and files in the root dir.

I already had a css dir in here and with the above command it has added main.scss to this folder. This is not good, so have changed my css folder to css_stuff.

At this point you can look to see what your site looks like locally.

`jekyll serve`

Change `_config.yml` site settings:

```yaml
# Site settings
title: Today I Did / Today I Learnt
email:
description: >
 A collation of what I have done each day at work (and sometimes outside) and what I have learnt while coding.
baseurl: "" # the subpath of your site, e.g. /blog
url: "http://localhost:4000" # the base hostname & protocol for your site
twitter_username: schuknight
github_username:  libbyschuknight
```

To see changes need to restart server.

Create a gemfile and add this:

``
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
``

Run `bundle install`

Create a `_pages` dir and move all my folders with content into this.

Add front matter to the top of each page you want showing:

```yaml
---
layout: page
title: Directory
permalink: /tid_til/
---
```

Change build settings:

```yaml
# Build settings
include: ['_pages']
kramdown:
 input: GFM
 syntax_highlighter: rouge
permalink: /:title/
```

To see changes need to restart server.

In the default Jekyll setup you should be seeing these pages being added the to nav bar. To add them as a simple list on the main page, add below to the index.html page in root dir. Replace <ul class="post-list">.

```html
<ul>
 {% for page in site.pages %} {% if page.title %}
   <li><a href="{{ page.url | prepend: site.baseurl }}">{{ page.title }}</a></li>
 {% endif %} {% endfor %}
</ul>
``
And then you should get a bulleted list of pages.
