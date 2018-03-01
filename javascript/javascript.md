# JAVASCRIPT

## Links

[YOU MIGHT NOT NEED JQUERY](http://youmightnotneedjquery.com/)

[(Now More Than Ever) You Might Not Need jQuery](https://css-tricks.com/now-ever-might-not-need-jquery/)

[Creating an Accordion with HTML, CSS & jQuery](http://inspirationalpixels.com/tutorials/creating-an-accordion-with-html-css-jquery)


## Notes

#### IIFE (Immediately Invoked Function Expression)
IIFE (Immediately Invoked Function Expression) is a JavaScript function that runs as soon as it is defined.
https://developer.mozilla.org/en-US/docs/Glossary/IIFE


## Node
Set time in node console to UTC
`process.env.TZ = utc`


## jQuery
https://css-tricks.com/snippets/jquery/

[Smooth Scrolling](https://css-tricks.com/snippets/jquery/smooth-scrolling/)

#### Learn jQuery
(have not tried this)
http://try.jquery.com/
https://code.tutsplus.com/courses/30-days-to-learn-jquery
https://www.codeschool.com/courses/try-jquery
https://css-tricks.com/lodge/learn-jquery/
http://jqfundamentals.com/
https://teamtreehouse.com/library/jquery-basics




## JS code in Rails

### JS adding in a click and dismiss

```html
<%= link_to(customer_utility_notice_dismissals_path(:customer_id => add_utility_notice.customer_id), :class => "dismiss-button") do %>
   <div class="icon"></div>
 <% end %>
```

```js
jQuery(function($) {
  $(".add-utility-notice .dismiss-button").click(function(event) {
    event.preventDefault();
    postAjax($(this).attr("href"));

    $(".add-utility-notice").hide();
  });
});
```
So this sends post to controller which creates something and it also hides a notice/banner on the click as well!
