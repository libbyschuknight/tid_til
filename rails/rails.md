# Rails

To run rails server not on default port

```bash
be rails s -p 4000
```

#### Assest Pipeline, scss
Been working on my Seido Karate Guide and added some styling to the `stances.scss`file. When loading page this wasn't coming through. Looking at a previous  project, I was missing:

```css
*= require_tree .
*= require_self
```
from the `application.scss` file. Added this back in and it worked fine.
