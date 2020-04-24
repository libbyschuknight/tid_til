# Vue JS

[Vue JS Guide](https://vuejs.org/v2/guide/)

[Awesome Vue.js](https://github.com/vuejs/awesome-vue)

## [Vue I18n](https://kazupon.github.io/vue-i18n/introduction.html)

## [Vuex](https://vuex.vuejs.org/)

>Vuex is a state management pattern + library for Vue.js applications. It serves as a centralized store for all the components in an application, with rules ensuring that the state can only be mutated in a predictable fashion.

<https://vuex.vuejs.org/guide/getters.html#the-mapgetters-helper>

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
