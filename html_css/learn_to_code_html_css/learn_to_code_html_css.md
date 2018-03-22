# Learn to Code HTML & CSS
### Develop & Style Websites

https://learn.shayhowe.com/html-css/

## Using CSS Resets

[CSS Tools: Reset CSS](https://meyerweb.com/eric/tools/css/reset/)
[Normalize.css](http://necolas.github.io/normalize.css/)



## [Semantic code](https://learn.shayhowe.com/html-css/getting-to-know-html/#semantics-overview)

[Semantic code: What? Why? How?](http://boagworld.com/dev/semantic-code-what-why-how/)

>Semantic code describes the value of content on a page, regardless of the style or appearance of that content. There are several benefits to using semantic elements, including enabling computers, screen readers, search engines, and other devices to adequately read and understand the content on a web page. Additionally, semantic HTML is easier to manage and work with, as it shows clearly what each piece of content is about.

>Divisions, or <div>s, and <span>s are HTML elements that act as containers solely for styling purposes.
Are not semantic code - for styling only.

>Paragraphs are semantic in that content wrapped within a <p> element is known and understood as a paragraph. <div>s and <span>s do not hold any such meaning and are simply containers.


[Copy Paste Character](https://www.copypastecharacter.com/)


## [Specificity](https://learn.shayhowe.com/html-css/getting-to-know-css/#specificity)

>The type selector has the lowest specificity weight and holds a point value of 0-0-1.
>The class selector has a medium specificity weight and holds a point value of 0-1-0.>
Lastly, the ID selector has a high specificity weight and holds a point value of 1-0-0.
As we can see, specificity points are calculated using three columns. The first column counts ID selectors, the second column counts class selectors, and the third column counts type selectors.

>Every selector in CSS has a specificity weight. A selector’s specificity weight, along with its placement in the cascade, identifies how its styles will be rendered.
>What’s important to note here is that the ID selector has a higher specificity weight than the class selector, and the class selector has a higher specificity weight than the type selector.
>The higher the specificity weight of a selector, the more superiority the selector is given when a styling conflict occurs.
>The specificity weights of different types of selectors are incredibly important to remember. At times styles may not appear on elements as intended, and chances are the specificity weights of our selectors are breaking the cascade, therefore our styles are not appearing properly.
