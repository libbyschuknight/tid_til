# Vue JS

[Vue JS Guide](https://vuejs.org/v2/guide/)

[Awesome Vue.js](https://github.com/vuejs/awesome-vue)

## [Vue I18n](https://kazupon.github.io/vue-i18n/introduction.html)

## [Vuex](https://vuex.vuejs.org/)

>Vuex is a state management pattern + library for Vue.js applications. It serves as a centralized store for all the components in an application, with rules ensuring that the state can only be mutated in a predictable fashion.

<https://vuex.vuejs.org/guide/getters.html#the-mapgetters-helper>

## Testing

<https://vuejs.org/v2/guide/testing.html>

### Pluralization

[Pluralization](https://kazupon.github.io/vue-i18n/guide/pluralization.html)

Example of dding Pluralization in a Rails app that has API endpoints that uses Vue in the frontend.

```js
// in index.vue file
{{
  $tc('translations.responses', communityPost.commentsCount, {
    count: communityPost.commentsCount
  })
}}
```

```yaml
# in the en.yml file
community_post_card:
  responses: "No responses | {count} response | {count} responses"
```

## Chat with Colleague about some stuff in Vue (in a Rails app)

- `slots` are like `yields`
- `computed` functions will have "cached" data
- `methods` - don't cache, evaluated each time they are called
- `data` - is like the local state
- `props` - given by the parent component
  - > Props are custom attributes you can register on a component.
  - <https://vuejs.org/v2/guide/components.html#Passing-Data-to-Child-Components-with-Props>

## Computed vs Methods

[The difference between COMPUTED and METHODS in Vue.js](https://medium.com/notonlycss/the-difference-between-computed-and-methods-in-vue-js-9cb05c59ed98#:~:text=methods%20don't%20know%20if,everytime%20to%20check%2C%20only%20once!)

>- methods don’t know if the values used in the function changed so they need to run everytime to check.
>
>- computed properties know if the values used in the function changed so they don’t need to run everytime to check, only once!

[The Difference Between Computed Properties, Methods and Watchers in Vue](https://www.sitepoint.com/the-difference-between-computed-properties-methods-and-watchers-in-vue/)

## Slots

<https://vuejs.org/v2/guide/components-slots.html>

Code review comment from colleague:

>if you don't include a name it's called the "default" slot and it will use the contents of the element. In this case, >anything that goes
>
>```js
><Layout>
>  ... here ...
></Layout>
>```
>
>will be in that default slot. The named ones need to have their own template elements, so in this case with the sidebar as >well it would look like:
>
>```js
><Layout>
>   ... main slot stuff ...
>
>  <template v-slot:sidebar>
>    ... sidebar slot stuff ...
>  </template>
></Layout>
>```
>
>Which is really just a shorthand way of writing this, I think:
>
>```js
><Layout>
>  <template v-slot:default>
>    ... main slot stuff ...
>  </template>
>
>  <template v-slot:sidebar>
>    ... sidebar slot stuff ...
>  </template>
></Layout>
>```

## CSS Styles etc in Vue

[Scoped CSS](https://vue-loader.vuejs.org/guide/scoped-css.html#scoped-css)

[Deep Selectors](https://vue-loader.vuejs.org/guide/scoped-css.html#child-component-root-elements)

What does `>>>` do?

>If you want a selector in scoped styles to be "deep", i.e. affecting child components, you can use the `>>>`  combinator:

## Directives

[v-text](https://vuejs.org/v2/api/#v-text)

>Updates the element’s `textContent`. If you need to update the part of `textContent`, you should use `{{ Mustache }}` interpolations.
>
>Example
>
>```html
><span v-text="msg"></span>
><!-- same as -->
><span>{{msg}}</span>
>```

Note if have:

```html
<span>
  {{msg}}
</span>
```

Get extra space on the page, even when using `white-space: pre-line`.

## Packages

[Vue Swatches](https://saintplay.github.io/vue-swatches/)
