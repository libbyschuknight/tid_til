# API Stuff

[What is an API? In English, please.](https://medium.freecodecamp.org/what-is-an-api-in-english-please-b880a3214a82)

## Semantic Versioning

- [Semantic Versioning](http://semver.org/)

>You are not fixing a bug, so not the last position.
>
>You are not breaking an existing API, so not first position.
>
>You are adding a new feature, so middle position.
>
>For APIs also if it is not a new API endpoint I try to think if it will break any existing apps using the endpoint. If you are adding attributes that should be safe (and be a minor bump as well) but if you are removing or changing any attributes then it is a breaking change and it is a major change.
>
>And if you are changing any URLs if it doesn’t redirect to an endpoint that returns the same thing an app would have got before it is also a breaking change.

Thanks @ootoovak

- [Semantic Versioning: Why You Should Be Using it](http://www.sitepoint.com/semantic-versioning-why-you-should-using/)

### HTTP Verbs

|HTTP Verb  |CRUD   |Entire Collection (e.g. /customers)   |Specific Item (e.g. /customers/{id})   |
|---|---|---|---|
|POST   | Create  |201 (Created), 'Location' header with link to /customers/{id} containing new ID.   |404 (Not Found), 409 (Conflict) if resource already exists..   |
|GET   |Read   |200 (OK), list of customers. Use pagination, sorting and filtering to navigate big lists.  |200 (OK), single customer. 404 (Not Found), if ID not found or invalid.   |
|PUT   |Update/Replace   |405 (Method Not Allowed), unless you want to update/replace every resource in the entire collection.   |200 (OK) or 204 (No Content). 404 (Not Found), if ID not found or invalid.   |
|PATCH   |Update/Modify   |405 (Method Not Allowed), unless you want to modify the collection itself   |200 (OK) or 204 (No Content). 404 (Not Found), if ID not found or invalid.   |
|DELETE   |Delete   |405 (Method Not Allowed), unless you want to delete the whole collection—not often desirable.   |200 (OK). 404 (Not Found), if ID not found or invalid.   |

From [Using HTTP Methods for RESTful Services](http://www.restapitutorial.com/lessons/httpmethods.html)

### HTTP Codes

[HTTP response status codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

[Cat HTTP status codes](https://iridakos.com/el/cats/2016/09/26/cat-http-status-codes)
