# Postgresql

## Common Errors
> I have experienced

#### Server Connection

**Problem:**

```bash
could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
```
Happened after running `rake db:create`.

or
```bash
PG::ConnectionBad - could not connect to server: Connection refused
	Is the server running on host "localhost" (127.0.0.1) and accepting
	TCP/IP connections on port 5432?
```
Happened when trying to load localhost for Rails app.

**Solution:**

Find `postgres` dir, `/usr/local/var/postgres/`.
Look at the `server.log` file, go to last line, probably see something like this:

```bash
FATAL:  lock file "postmaster.pid" already exists
HINT:  Is another postmaster (PID 347) running in data directory "/usr/local/var/postgres"?
```
In terminal search for the PID number:
```bash
ps aux | grep 347
```
Will see something like this:

```bash
Libby           2955   0.1  0.0  2423356    196 s001  R+    8:49am   0:00.00 grep 323
Libby            323   0.0  0.1   697608   4648   ??  S     7:42am   0:00.26 /Library/Application Support/Flip Video/FlipShareAutoRun.app/Contents/MacOS/FlipShareAutoRun
```
The numbers after `Libby` are the PID numbers. This shows that `Flip Video` was using this process, so I killed it:
`kill -9 323`.

ALSO - rather then killing the process you can delete the `postmaster.pid` file. Some stuff I googled said not to, some suggested it. This post [Postgres on OSX with homebrew not running after OSX crash](https://coderwall.com/p/zf-fww/postgres-on-osx-with-homebrew-not-running-after-osx-crash) I found useful.

Sometimes it isn't this simple.''

```bash
FATAL:  data directory "/usr/local/var/postgres" has group or world access
DETAIL:  Permissions should be u=rwx (0700).
```
Googled this and got http://www.rubycoloredglasses.com/2014/06/sharing-administrative-rights-with-homebrew/.
Did this
`chmod 700 /usr/local/var/postgres`
but could cause other issues, which link addresses.
Might be worthwhile to search this again if comes up again.


## Dropping a column in PSQL

```
alter table accounts drop column nickname;
```
