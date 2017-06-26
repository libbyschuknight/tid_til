# Notes


### [nginx](https://www.nginx.com/)
https://www.nginx.com/resources/wiki/
Web-server, sits between internet and app.
Issue happening where app was down, when down would route requests to bug page, but this returned a 200 status code, this affected mobile app and meant things in mobile app wouldn't reload pages properly.


## Using database locks
In a distributed system, the lock was dealing with ~20K records/transactions in one worker. This was causing issues. Initial fix was to move work on a record into another worker and have the lock in there so is locking on one record instead of ~20K.

## Queues and Auth
Auth with queues, can pass on a "header", the reasoning is that should treat queues as public and author each message.
Use auth headers on messages / queues. Auth is sent with the message
