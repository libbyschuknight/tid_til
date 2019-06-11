# CSS selectors & properties

[CSS Almanac: A reference guide to the many features of CSS.](https://css-tricks.com/almanac/)

https://developer.mozilla.org/en-US/docs/Web/CSS/Reference#Selectors

https://css-tricks.com/almanac/selectors/

## Selectors

### `child >` selector

https://developer.mozilla.org/en-US/docs/Web/CSS/Child_combinator


https://css-tricks.com/almanac/selectors/c/child/

>A child combinator in CSS is the "greater than" symbol, it looks like this:

>```css
>ol > li {
>  color: red;
>}
>```

>It means "select elements that are direct descendants only". In this case: "select list items that are direct descendants of an ordered list".

### General `sibling ~` combinator

https://developer.mozilla.org/en-US/docs/Web/CSS/General_sibling_combinator

https://css-tricks.com/almanac/selectors/g/general-sibling/

```css
img ~ p {
  background-color: #FEF0B6;
  padding: 5px;
}
```

Paragraphs after an image will be selected.

## Properties
