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
```

Operator	   Example/Output	   Notes
%l           ( 1..12)          Hour of day, 12-hour clock, blank-padded
%M           (00..59)          Minute of the hour
%P           am, pm            Meridian indicator, lowercase
%d           (01..31)          Day of month, zero-padded
%b           Jan               Abbreviated month name, same as %h
%y           (00.99),          09 in 2009	Year % 100, last two digits of year
-            %-d, %-l          Don't pad numerical output
```
