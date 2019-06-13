# Rails Security

### [Cross-Site Request Forgery (CSRF)](http://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf)
>This attack method works by including malicious code or a link in a page that accesses a web application that the user is believed to have authenticated. If the session for that web application has not timed out, an attacker may execute unauthorized commands.

[Cross-Site Request Forgery (CSRF)](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF))

[A Deep Dive into CSRF Protection in Rails](https://medium.com/rubyinside/a-deep-dive-into-csrf-protection-in-rails-19fa0a42c0ef)


### [Injection](http://guides.rubyonrails.org/security.html#injection)
>Injection is a class of attacks that introduce malicious code or parameters into a web application in order to run it within its security context. Prominent examples of injection are cross-site scripting (XSS) and SQL injection.

[Cross-Site Scripting (XSS)](http://guides.rubyonrails.org/security.html#cross-site-scripting-xss)
>The most widespread, and one of the most devastating security vulnerabilities in web applications is XSS. This malicious attack injects client-side executable code. Rails provides helper methods to fend these attacks off.

>XSS attacks work like this: An attacker injects some code, the web application saves it and displays it on a page, later presented to a victim. Most XSS examples simply display an alert box, but it is more powerful than that. XSS can steal the cookie, hijack the session, redirect the victim to a fake website, display advertisements for the benefit of the attacker, change elements on the web site to get confidential information or install malicious software through security holes in the web browser.

[Cross-site Scripting (XSS)](https://www.owasp.org/index.php/Cross-site_Scripting_(XSS))

[SQL Injection](http://guides.rubyonrails.org/security.html#sql-injection)
>SQL injection attacks aim at influencing database queries by manipulating web application parameters. A popular goal of SQL injection attacks is to bypass authorization. Another goal is to carry out data manipulation or reading arbitrary data.


[Rails SQL Injection](https://rails-sqli.org/)
>This page lists many query methods and options in ActiveRecord which do not sanitize raw SQL arguments and are not intended to be called with unsafe user input. Careless use of these methods can open up code to SQL Injection exploits.

[Fixing SQL Injection Vulnerabilities in Ruby/Rails](http://gavinmiller.io/2015/fixing-sql-injection-vulnerabilities/)
