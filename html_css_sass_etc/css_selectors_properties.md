# CSS selectors & properties

[CSS Almanac: A reference guide to the many features of CSS.](https://css-tricks.com/almanac/)

<https://developer.mozilla.org/en-US/docs/Web/CSS/Reference#Selectors>

<https://css-tricks.com/almanac/selectors/>

## Selectors

### `child >` selector

<https://developer.mozilla.org/en-US/docs/Web/CSS/Child_combinator>

<https://css-tricks.com/almanac/selectors/c/child/>

> A child combinator in CSS is the "greater than" symbol, it looks like this:
>
> ```css
> ol > li {
>   color: red;
> }
> ```
>
> It means "select elements that are direct descendants only". In this case: "select list items that are direct descendants of an ordered list".

## Combinators

[Descendant combinator](https://developer.mozilla.org/en-US/docs/Web/CSS/Descendant_combinator)

### General `sibling ~` combinator

<https://developer.mozilla.org/en-US/docs/Web/CSS/General_sibling_combinator>

<https://css-tricks.com/almanac/selectors/g/general-sibling/>

```css
img ~ p {
  background-color: #fef0b6;
  padding: 5px;
}
```

Paragraphs after an image will be selected.

## Properties

### width

<https://developer.mozilla.org/en-US/docs/Web/CSS/width>

  >fit-content(<length-percentage>)
  >
  >Uses the fit-content formula with the available space replaced by the specified argument, i.e. min(max-content, max(min-content, )).

<https://css-tricks.com/almanac/properties/w/width/>

>#### fit-content
>
>The fit-content value is roughly equivalent to margin-left: auto and margin-right: auto in behaviour, except it works for unknown widths.

e.g.

```css
&-- {
  // sp-u-width--fit-content
  &fit-content { width: fit-content; }
  // sp-u-width--xxxxs
  &xxxxs { width: 10px; }
  // sp-u-width--xxxs
  &xxxs { width: 20px; }
  // sp-u-width--xxs
  &xxs { width: 40px; }
  // sp-u-width--vw
  &vw { width: 100vw; }
  // sp-u-width--100
  &100 { width: 100%; }
```
