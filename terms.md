# Terms

DNS -Domain Name System
> DNS stands for Domain Name System. DNS is how domain names are translated into IP addresses, and DNS also controls email delivery. DNS is what allows you to use your web browser to find web sites as well as send and receive email.
http://support.e-zekiel.com/templates/System/details.asp?id=31606&fetch=26154

[How DNS Works](https://howdns.works/ep1/)

CDN - Content Delivery Network
    > A content delivery network (CDN) is a system of distributed servers (network) that deliver webpages and other Web content to a user based on the geographic locations of the user, the origin of the webpage and a content delivery server. This service is effective in speeding the delivery of content of websites with high traffic and websites that have global reach. The closer the CDN server is to the user geographically, the faster the content will be delivered to the user. CDNs also provide protection from large surges in traffic.
    > [CDN - Content Delivery Network](http://www.webopedia.com/TERM/C/CDN.html)


- asset CDN -

Latency
>is the amount of time it takes for the host server to receive and process a request for a page object. The amount of latency depends largely on how far away the user is from the server.
http://www.webperformancetoday.com/2012/04/02/latency-101-what-is-latency-and-why-is-it-such-a-big-deal/

>In web speak it is the round trip time between you requesting a http request and the returning answer. The longer the request takes to get an answer… the longer the latency.
https://responsivedesign.is/articles/testing-for-latency/

RDS - Relational Database Service
[Amazon Relational Database Service (Amazon RDS)](https://aws.amazon.com/rds/)
[Amazon RDS for PostgreSQL](https://aws.amazon.com/rds/postgresql/)

SASS -    (e.g. Storypark)

BDD -

TDD -

HTTP - Hypertext Transfer Protocol - [Version 2 (HTTP/2)](http://httpwg.org/specs/rfc7540.html)

ROAR -

REST -
[Ruby On REST: Introducing the Representer Pattern](http://nicksda.apotomo.de/2011/12/ruby-on-rest-introducing-the-representer-pattern/)

[Understanding REST And RPC For HTTP APIs](https://www.smashingmagazine.com/2016/09/understanding-rest-and-rpc-for-http-apis/)


pragma (or "directive")
> a directive pragma (from "pragmatic") is a language construct that specifies how a compiler (or assembler or interpreter) should process its input.

- https://en.wikipedia.org/wiki/Directive_(programming)


TLS - Transport Layer Security
>  is a protocol that ensures privacy between communicating applications and their users on the Internet. When a server and client communicate, TLS ensures that no third party may eavesdrop or tamper with any message. TLS is the successor to the Secure Sockets Layer (SSL). http://searchsecurity.techtarget.com/definition/Transport-Layer-Security-TLS

[OAuth](http://oauth.net/) -
> An open protocol to allow secure authorization in a simple and standard method from web, mobile and desktop applications.

[OAuth 2.0](http://oauth.net/2/)

MITM - man-in-the-middle (MITM) attack

[cURL](https://curl.haxx.se/)
> curl is an open source command line tool and library for transferring data with URL syntax, supporting DICT, FILE, FTP, FTPS, Gopher, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMB, SMTP, SMTPS, Telnet and TFTP. curl supports SSL certificates, HTTP POST, HTTP PUT, FTP uploading, HTTP form based upload, proxies, HTTP/2, cookies, user+password authentication (Basic, Plain, Digest, CRAM-MD5, NTLM, Negotiate and Kerberos), file transfer resume, proxy tunneling and more.

DRY

BRITTLE
“Too DRY is BRITTLE (Badly Refactored Into Tiny Things Lacking Expressiveness)” - @keystonelemur

[What is A/B Testing?](https://vwo.com/ab-testing/)
> A/B testing (sometimes called split testing) is comparing two versions of a web page to see which one performs better. You compare two web pages by showing the two variants (let's call them A and B) to similar visitors at the same time. The one that gives a better conversion rate, wins!

Encapsulation

https://samurails.com/interview/ruby-inheritance-encapsulation-polymorphism/
> Encapsulation is the packing of data and functions into a single component. Encapsulation means that the internal representation of an object is hidden from the outside. Only the object can interact with its internal data. Public methods can be created to open a defined way to access the logic inside an object.

https://launchschool.com/books/oo_ruby/read/the_object_model
>Encapsulation is hiding pieces of functionality and making it unavailable to the rest of the code base. It is a form of data protection, so that data cannot be manipulated or changed without obvious intention. It is what defines the boundaries in your application and allows your code to achieve new levels of complexity. Ruby, like many other OO languages, accomplishes this task by creating objects, and exposing interfaces (i.e., methods) to interact with those objects.


Race Condition

http://searchstorage.techtarget.com/definition/race-condition
> A race condition is an undesirable situation that occurs when a device or system attempts to perform two or more operations at the same time, but because of the nature of the device or system, the operations must be done in the proper sequence to be done correctly.


Semaphore

concurrency

Monkey patching

Caching

http://whatis.techtarget.com/definition/caching
>Caching (pronounced “cashing”) is the process of storing data in a cache.
>A cache is a temporary storage area. For example, the files you automatically request by looking at a Web page are stored on your hard disk in a cache subdirectory under the directory for your browser. When you return to a page you've recently looked at, the browser can get those files from the cache rather than the original server, saving you time and saving the network the burden of additional traffic.

[Web cache](https://en.wikipedia.org/wiki/Web_cache)
>A web cache (or HTTP cache) is an information technology for the temporary storage (caching) of web documents, such as HTML pages and images, to reduce bandwidth usage, server load, and perceived lag. A web cache system stores copies of documents passing through it; subsequent requests may be satisfied from the cache if certain conditions are met.[1] A web cache system can refer either to an appliance, or to a computer program.



Theory of Constraints
http://www.leanproduction.com/theory-of-constraints.html

[Singleton](http://whatis.techtarget.com/definition/singleton)
>In object-oriented programming , a singleton class is a class that can have only one object (an instance of the class) at a time. For example, using Visual C++ , the "Application" class is an example of a singleton class. You can only create only one object of an Application class.

[Ruby Singleton Pattern](https://dalibornasevic.com/posts/9-ruby-singleton-pattern)



[Exponential backoff](https://en.wikipedia.org/wiki/Exponential_backoff)

HAML - HTML Abstraction Markup Language

[BEM](https://en.bem.info/)
Block Element Modifier is a methodology, that helps you to achieve reusable components and code sharing in the front-end
- [get bem](http://getbem.com/)




#### CAP

[CAP Theorem: Its importance in distributed systems](http://blog.flux7.com/blogs/nosql/cap-theorem-why-does-it-matter)

Consistency (C) requires that all reads initiated after a successful write return the same and latest value at any given logical time.

Availability (A) requires that every node (not in failed state) always execute queries. Let’s say we have “n” servers serving our application. To ensure better availability we would add an additional “x” servers.

Partition Tolerance (P) requires that a system be able to re-route a communication when there are temporary breaks or failures in the network. The goal is to maintain synchronization among the involved nodes.


Transaction - database? local?

ACID

Distributed transactions

Fault tolerance

Idempotent
>Idempotence (UK: /ˌɪdɛmˈpoʊtns/;[1] US: /ˌaɪdᵻmˈpoʊtəns/ eye-dəm-poh-təns)[2] is the property of certain operations in mathematics and computer science, that can be applied multiple times without changing the result beyond the initial application.
https://en.wikipedia.org/wiki/Idempotence



Headless
> "Headless" in this context simply means without a graphical display. (i.e.: Console based.)


## Web Stuff

Evergreen Browser
https://www.techopedia.com/definition/31094/evergreen-browser

>The term "evergreen browser" refers to browsers that are automatically upgraded to future versions, rather than being updated by distribution of new versions from the manufacturer, as was the case with older browsers. The term is a reflection on how the design and delivery of browsers have changed quickly over the last few years, as technology advances in general and various new players threaten Microsoft's dominance as in the early days of MS Internet Explorer.
