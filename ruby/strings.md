# Doing things with Strings

Taking out extra `, ` (common space) - ie the blank bit

`"91 Panorama Drive, , Paraparaumu".split(",").reject(&:blank?).join(",")`

`"91 Panorama Drive, , Paraparaumu".gsub(/,[,\s]*,/, ',')`

To return: "91 Panorama Drive, Paraparaumu"

Needed to also work with:

"32 Edinburgh Terrace, Foxton Beach, Foxton, 4815" to return it as is.

Both options about work!

## [Learn Strftime](http://learnstrftime.com/)

Really useful site, can paste in a "Strftime" and it will tell you what the different components are.
E.g.
This  `%l:%M%P %-d %b %y` displays as `8:51am 6 Oct 16`.

If you paste into Learn Strftime, get this:

```markdown

Operator	   Example/Output	   Notes
%l           ( 1..12)          Hour of day, 12-hour clock, blank-padded
%M           (00..59)          Minute of the hour
%P           am, pm            Meridian indicator, lowercase
%d           (01..31)          Day of month, zero-padded
%b           Jan               Abbreviated month name, same as %h
%y           (00.99),          09 in 2009	Year % 100, last two digits of year
-            %-d, %-l          Don't pad numerical output
```

## Ruby Methods

Get the number of characters in a string use `size` or `length`, both return length of the string.

```ruby
s = "test" # "test"
s.size # 4
```

There is a `count` method for `String` but it is used like this:

```ruby
a = "hello world"
a.count "lo"  #=> 5
```

## Multi line strings

[Ruby: Multiline strings – Heredoc or quotes](https://cbabhusal.wordpress.com/2015/10/06/ruby-multiline-string-definition/)
[A Cheatsheet for Multi-line Strings in Ruby](https://commandercoriander.net/blog/2014/11/09/a-multiline-string-cheatsheet-for-ruby/)

Example

```ruby
%Q(
  The cheapest thing is:
  #{presenter.savings(someone).first[:label]}
  Save an estimated #{signed_number_to_currency(presenter.other_savings(someone))} a year.
)
```

## tr method

<https://ruby-doc.org/core-2.3.0/String.html#method-i-tr>

<https://stackoverflow.com/questions/26749065/what-is-the-difference-between-tr-and-gsub/26750460#26750460>

Use case at SP, changing all the double quotes to single quotes.

```ruby
img_tag = block.placeholder_img.to_s.tr('"', "'")
```

Marielle from work:

> I've got a cool use case of tr to show you!

```bash
irb(main):010:0> alphabet = ('a'..'z').to_a.join
=> "abcdefghijklmnopqrstuvwxyz"
irb(main):011:0> cipher = "qwertyuiopasdfghjklzxcvbnm"
=> "qwertyuiopasdfghjklzxcvbnm"
irb(main):012:0> "return the books".tr(alphabet, cipher)
=> "ktzxkf zit wggal"
```

In a hangman context it's even cooler, this was how he used it:

```bash
word = "knowledge"
=> "knowledge"

alphabet = ('a'..'z').to_a
=> ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

guesses = "kniwea".chars
=> ["k", "n", "i", "w", "e", "a"]

letters_left = alphabet - guesses
=> ["b", "c", "d", "f", "g", "h", "j", "l", "m", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z"]

word.tr(letters_left.join, "_")
=> "kn_w_e__e"
```
