# Learn to Code HTML & CSS
### Develop & Style Websites

https://learn.shayhowe.com/html-css/

Useful links at the bottom of each lesson.

## Lesson 1 [Building Your First Web Page](https://learn.shayhowe.com/html-css/building-your-first-web-page/)

http://www.scriptingmaster.com/html/HTML-terms-glossary.asp
https://www.impressivewebs.com/css-terms-definitions/
http://necolas.github.io/normalize.css/

## Using CSS Resets
[CSS Tools: Reset CSS](https://meyerweb.com/eric/tools/css/reset/)
[Normalize.css](http://necolas.github.io/normalize.css/)

## Lesson 2 [Getting to Know HTML](https://learn.shayhowe.com/html-css/getting-to-know-html/)

### [Semantic code](https://learn.shayhowe.com/html-css/getting-to-know-html/#semantics-overview)

[Semantic code: What? Why? How?](http://boagworld.com/dev/semantic-code-what-why-how/)

>Semantic code describes the value of content on a page, regardless of the style or appearance of that content. There are several benefits to using semantic elements, including enabling computers, screen readers, search engines, and other devices to adequately read and understand the content on a web page. Additionally, semantic HTML is easier to manage and work with, as it shows clearly what each piece of content is about.

>Divisions, or <div>s, and <span>s are HTML elements that act as containers solely for styling purposes.
Are not semantic code - for styling only.

>Paragraphs are semantic in that content wrapped within a <p> element is known and understood as a paragraph. <div>s and <span>s do not hold any such meaning and are simply containers.

[Copy Paste Character](https://www.copypastecharacter.com/)

## Lesson 3 [Getting to Know CSS](https://learn.shayhowe.com/html-css/getting-to-know-css/)

### [The Cascade](https://learn.shayhowe.com/html-css/getting-to-know-css/#cascade)
>Within CSS, all styles cascade from the top of a style sheet to the bottom, allowing different styles to be added or overwritten as the style sheet progresses.


### [Specificity](https://learn.shayhowe.com/html-css/getting-to-know-css/#specificity)

>The type selector has the lowest specificity weight and holds a point value of 0-0-1.
>The class selector has a medium specificity weight and holds a point value of 0-1-0.>
Lastly, the ID selector has a high specificity weight and holds a point value of 1-0-0.
As we can see, specificity points are calculated using three columns. The first column counts ID selectors, the second column counts class selectors, and the third column counts type selectors.

>Every selector in CSS has a specificity weight. A selector’s specificity weight, along with its placement in the cascade, identifies how its styles will be rendered.
>What’s important to note here is that the ID selector has a higher specificity weight than the class selector, and the class selector has a higher specificity weight than the type selector.
>The higher the specificity weight of a selector, the more superiority the selector is given when a styling conflict occurs.
>The specificity weights of different types of selectors are incredibly important to remember. At times styles may not appear on elements as intended, and chances are the specificity weights of our selectors are breaking the cascade, therefore our styles are not appearing properly.

https://color.adobe.com/create/color-wheel/

## Lesson 4 [Opening the Box Model](https://learn.shayhowe.com/html-css/opening-the-box-model/)

### Display

>Exactly how elements are displayed—as block-level elements, inline elements, or something else—is determined by the display property. Every element has a default display property value; however, as with all other property values, that value may be overwritten. There are quite a few values for the display property, but the most common are block, inline, inline-block, and none.

### [What Is the Box Model?](https://learn.shayhowe.com/html-css/opening-the-box-model/#what-is-the-box-model)

>According to the box model concept, every element on a page is a rectangular box and may have width, height, padding, borders, and margins.
>That’s worth repeating: **Every element on a page is a rectangular box.**

[The CSS Box Model](https://css-tricks.com/the-css-box-model/)

```css
* {
   border: 1px solid red !important;
}
```

## [HTML Borders](https://www.quackit.com/html/codes/html_borders.cfm)


## Universal Selector
>The Universal Selector
>In the first step of this exercise we were introduced to the universal selector. In CSS the asterisk, &#42;, is the universal selector, which selects every element. Rather than listing every single element imaginable, we can use the asterisk as a catch-all to select all elements for us.
>The :before and :after pseudo-elements also mentioned in this step are elements that can be dynamically generated with CSS. We’re not going to be using these elements within our project; however, when using the universal selector it’s a good practice to also include these pseudo-elements in case they should ever appear.

## Lesson 5 [Positioning Content](https://learn.shayhowe.com/html-css/positioning-content/)

### [Floats](https://learn.shayhowe.com/html-css/positioning-content/#floats)

>Floats May Change an Element’s Display Value
>When floating an element, it is also important to recognize that an element is removed from the normal flow of a page, and that may change an element’s default display value. The float property relies on an element having a display value of block, and may alter an element’s default display value if it is not already displayed as a block-level element.
>For example, an element with a display value of inline, such as the <span> inline-level element, ignores any height or width property values. However, should that inline-level element be floated, its display value will be changed to block, and it may then accept height or width property values.
>As we float elements we must keep an eye on how their display property values are affected.

[CSS Positioning 101](http://alistapart.com/article/css-positioning-101)

[CSS Float Theory: Things You Should Know](https://www.smashingmagazine.com/2007/05/css-float-theory-things-you-should-know/)
