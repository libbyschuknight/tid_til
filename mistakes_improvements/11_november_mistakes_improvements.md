# November Mistakes & Improvements


### .find or .find_by

>Difference between find and find_by_id (continues........)
>Other than the differences that i mentioned in my last post , one more major difference is there....
>"find" fires an "Exception" if the record related to given ID is not fount. This leads to the "Crash" of the server.
while "find_by_id" doesn't fires an "Exception" , if the record related to given ID is not in Table it simply returns "nil" value, and doesn't halt the running "Server".

http://railssolutions.blogspot.co.nz/2012/02/difference-between-find-and-findbyid.html

DHH explains the difference:
https://stackoverflow.com/questions/4966430/rails-2-model-find1-gives-activerecord-error-when-id-1-does-not-exist/4966553#4966553


### safe navigation activerecord

Had this `last_guess && last_guess.correct`, can do as this `last_guess&.correct`

[The Safe Navigation Operator (&.) in Ruby](http://mitrev.net/ruby/2015/11/13/the-operator-in-ruby/)
