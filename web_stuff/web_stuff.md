# Web Stuff

[An overview of how the Web works](https://marksheet.io/introduction.html)

[MDN web docs: Resources for developers, by developers.](https://developer.mozilla.org/en-US/)

- <https://developer.mozilla.org/en-US/docs/Web/HTML>
- <https://developer.mozilla.org/en-US/docs/Web/CSS>
- <https://developer.mozilla.org/en-US/docs/Web/JavaScript>

[100+ unicode symbols that you can use](https://tutorialzine.com/2014/12/you-dont-need-icons-here-are-100-unicode-symbols-that-you-can-use)

[Unicode® character table](https://unicode-table.com/en/#control-character)

- [Arrows](https://unicode-table.com/en/sets/arrows-symbols/)

[Convert Images to Base64](https://www.browserling.com/tools/image-to-base64)

[The Promise of a Burger Party](https://kosamari.com/notes/the-promise-of-a-burger-party)

[HTTPS](https://en.wikipedia.org/wiki/HTTPS)

[HTTPS explained with carrier pigeons](https://medium.freecodecamp.org/https-explained-with-carrier-pigeons-7029d2193351)

[How HTTPS works ...in a comic!](https://howhttps.works/)

[Reboot, Resets, and Reasoning](https://css-tricks.com/reboot-resets-reasoning/)

[The Web I Want](https://dev.to/quii/the-web-i-want-43o)

[CLIENT-SIDE VS. SERVER-SIDE](https://skillcrush.com/blog/client-side-vs-server-side/)

>Client-side means that the action takes place on the user’s (the client’s) computer. Server-side means that the >action takes place on a web server.
>...
>The difference between client-side vs. server-side, and frontend vs. backend programming is really a difference >in semantics. Client-side vs. server-side describes where the action takes place (literally on your computer vs. >a server). Frontend vs. backend refers to what kind of action is taking place (the kind the user sees vs. the >kind a user does not).

## HTTP Verbs

|HTTP Verb  |CRUD   |Entire Collection (e.g. /customers)   |Specific Item (e.g. /customers/{id})   |
|---|---|---|---|
|POST   | Create  |201 (Created), 'Location' header with link to /customers/{id} containing new ID.   |404 (Not Found), 409 (Conflict) if resource already exists..   |
|GET   |Read   |200 (OK), list of customers. Use pagination, sorting and filtering to navigate big lists.  |200 (OK), single customer. 404 (Not Found), if ID not found or invalid.   |
|PUT   |Update/Replace   |405 (Method Not Allowed), unless you want to update/replace every resource in the entire collection.   |200 (OK) or 204 (No Content). 404 (Not Found), if ID not found or invalid.   |
|PATCH   |Update/Modify   |405 (Method Not Allowed), unless you want to modify the collection itself   |200 (OK) or 204 (No Content). 404 (Not Found), if ID not found or invalid.   |
|DELETE   |Delete   |405 (Method Not Allowed), unless you want to delete the whole collection—not often desirable.   |200 (OK). 404 (Not Found), if ID not found or invalid.   |

From [Using HTTP Methods for RESTful Services](https://www.restapitutorial.com/lessons/httpmethods.html)

[Edge Rails: PATCH is the new primary HTTP method for updates](https://weblog.rubyonrails.org/2012/2/26/edge-rails-patch-is-the-new-primary-http-method-for-updates/)


## JSON

[JSON Schema](https://json-schema.org/)

[JSONJSONLint - The JSON Validator](https://jsonlint.com/)

## CSS / design stuff??

[Periodic Table of the Elements](http://smm.zoomquiet.top/data/20110511083224/index.html)

[How white space killed an enterprise app (and why data density matters)](https://uxdesign.cc/how-white-space-killed-an-enterprise-app-and-why-data-density-matters-b3afad6a5f2a)

[The Process of Implementing A UI Design From Scratch](https://ishadeed.com/article/building-ui-design-scratch/)

## The Browser

### window.location

<https://developer.mozilla.org/en-US/docs/Web/API/Window/location>

[window.location Cheatsheet](https://dev.to/samanthaming/window-location-cheatsheet-4edl)

### Chrome Dev Tools

[Cool Chrome DevTools tips and tricks you wish you knew already](https://medium.freecodecamp.org/cool-chrome-devtools-tips-and-tricks-you-wish-you-knew-already-f54f65df88d2)

[16 DevTools tips and tricks every CSS developer needs to know](https://www.heartinternet.uk/blog/16-devtools-tips-and-tricks-every-css-developer-need-to-know/)

[15 DevTool Secrets for JavaScript Developers](https://blog.asayer.io/15-devtool-secrets-for-javascript-developers) ✅

## Progressive Web Apps

[Progressive Web Apps](https://developers.google.com/web/progressive-web-apps/)

[Build a PWA Using Only Vanilla JavaScript](https://levelup.gitconnected.com/build-a-pwa-using-only-vanilla-javascript-bdf1eee6f37a)

## Learning CSS

<https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/CSS3_taxonomy_and_status-v2.png/1201px-CSS3_taxonomy_and_status-v2.png>

Start in the centre and work way outwards, in a methodical manner

[HTML Tutorials. And Stuff.](http://htmldog.com/)

[Learn CSS Layout](http://learnlayout.com/)

[Learn to Code HTML & CSS](https://learn.shayhowe.com/html-css/)

[Learn CSS](https://web.dev/learn/css/)

## Security

[What is the difference between authentication and authorization?](https://serverfault.com/questions/57077/what-is-the-difference-between-authentication-and-authorization)

> - Authentication is the process of verifying who you are. When you log on to a PC with a user name and password you are authenticating.
> - Authorization is the process of verifying that you have access to something. Gaining access to a resource (e.g. directory on a hard disk) because the permissions configured on it allow you access is authorization.

[How to fix target=”\_blank” links: a security and performance issue in web pages](https://medium.com/@ali.dev/how-to-fix-target-blank-a-security-and-performance-issue-in-web-pages-2118eba1ce2f)

[Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)

>Content Security Policy (CSP) is an added layer of security that helps to detect and mitigate certain types of attacks, including Cross Site Scripting (XSS) and data injection attacks. These attacks are used for everything from data theft to site defacement to distribution of malware.

## Browsers

[Emulate and Test Other Browsers](https://developers.google.com/web/tools/chrome-devtools/device-mode/testing-other-browsers)

## Pattern Libraries

[How to create a pattern library and why you should bother](https://boagworld.com/`/pattern-library/)

[Pattern Library Examples](http://styleguides.io/examples.html)

[Taking The Pattern Library To The Next Level](https://www.smashingmagazine.com/taking-pattern-libraries-next-level/)

## Design Patterns / Systems

[Adele: The repository of publicly available design systems and pattern libraries](https://adele.uxpin.com/)

[Atomic Design](http://atomicdesign.bradfrost.com/table-of-contents/)

[Create atomic design systems with Pattern Lab](https://patternlab.io/)

[CARBON DESIGN SYSTEM](https://www.carbondesignsystem.com/)

[Lonely Planet Design System](https://rizzo.lonelyplanet.com/styleguide/design-elements/colours)

[Lightning Design System](https://www.lightningdesignsystem.com/)

[Primer CSS](https://primer-css.now.sh/css)

[Luna - Sainsbury](https://luna.sainsburys.co.uk/guidelines)

[Design, develop, and deliver (Atlassian’s Design System)](https://atlassian.design/)

[A RARE LOOK INTO SAINSBURY’S DIGITAL EXPERIENCE PLAYBOOK](http://whatusersdo.com/blog/sainsburys-digital-experience/)

[Design patterns](http://ui-patterns.com/patterns)

[A frequently updated collection of Design System examples, articles, tools and talks.](https://designsystemsrepo.com/)

[The key lessons I learned creating a popular Design System](https://medium.com/asana-design/the-key-lessons-i-learned-creating-a-popular-design-system-d078c817b4dd)

[What is a Design System?](https://medium.muz.li/what-is-a-design-system-1e43d19e7696)

[Building Design Systems](https://medium.muz.li/building-design-systems-9bda90d8ec25)

[Everything you need to know about Design Systems](https://uxdesign.cc/everything-you-need-to-know-about-design-systems-54b109851969)

> A Design System is the single source of truth which groups all the elements that will allow the teams to design, realize and develop a product.

Follow on article
[Atomic design: how to design systems of components](https://uxdesign.cc/atomic-design-how-to-design-systems-of-components-ab41f24f260e)

[Design Systems Gallery](https://designsystemsrepo.com/design-systems/)

[awesome-design-systems](https://github.com/alexpate/awesome-design-systems)

[MATERIAL DESIGN](https://material.io/)

[Solar Design System (Bulb)](https://design.bulb.co.uk/#/patterns/styles/colors/README.md)

[Versioning Design Systems: Communicating Change Clearly to People Using Systems](https://medium.com/eightshapes-llc/versioning-design-systems-48cceb5ace4d)

[A comprehensive guide to design systems](https://www.invisionapp.com/inside-design/guide-to-design-systems/)

[The myth that design systems solve easy problems](https://amyhupe.co.uk/articles/the-myth-that-design-systems-solve-easy-problems/)

[Everything I Know About Style Guides, Design Systems, and Component Libraries](https://leerob.io/blog/style-guides-component-libraries-design-systems/)

[Component-Driven Development](https://blog.hichroma.com/component-driven-development-ce1109d56c8e)

[Typography in Design Systems: Choose Fonts, Set a Hierarchy, and Integrate with Components](https://medium.com/eightshapes-llc/typography-in-design-systems-6ed771432f1e)

[Space in Design Systems: From Basics to Expanded Concepts to Apply Space with Intent](https://medium.com/eightshapes-llc/space-in-design-systems-188bcbae0d62)

[Visual Regression Testing in Design Systems](https://seesparkbox.com/foundry/design_system_visual_regression_testing)

## Documentation Tools

[MDX - Markdown for the component era](https://mdxjs.com)

[Storybook Docs sneak peek](https://medium.com/storybookjs/storybook-docs-sneak-peak-5be78445094a)

[Storybook DocsPage Beautiful documentation, instantly](https://medium.com/storybookjs/storybook-docspage-e185bc3622bf)

## Images / Videos

[Lazy Loading Images and Video](https://developers.google.com/web/fundamentals/performance/lazy-loading-guidance/images-and-video)
