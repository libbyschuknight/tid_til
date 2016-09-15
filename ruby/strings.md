# Doing things with Strings

Taking out extra `, ` (common space) - ie the blank bit

`"91 Panorama Drive, , Paraparaumu".split(",").reject(&:blank?).join(",")`

`"91 Panorama Drive, , Paraparaumu".gsub(/,[,\s]*,/, ',')`

To return: "91 Panorama Drive, Paraparaumu"

Needed to also work with:

"32 Edinburgh Terrace, Foxton Beach, Foxton, 4815" to return it as is.

Both options about work!
