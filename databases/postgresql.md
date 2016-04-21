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
`kill -9 323`

Sometimes it isn't this simple.

```bash
FATAL:  data directory "/usr/local/var/postgres" has group or world access
DETAIL:  Permissions should be u=rwx (0700).
```
Googled this and got http://www.rubycoloredglasses.com/2014/06/sharing-administrative-rights-with-homebrew/.
Did this
`chmod 700 /usr/local/var/postgres`
but could cause other issues, which link addresses.
Might be worthwhile to search this again if comes up again.

## PSQL Command line
I was wanting to see the values were in an enum column.
From here http://www.postgresql.org/docs/8.3/static/tutorial-accessdb.html, I discovered:
```bash
\? for help with psql commands
```
This showed what is below.
And from that I found
```bash
\dT[S+] [PATTERN]      list data types
```
And this gave me this:

```bash
List of data types
Schema | Name | Internal name | Size |      Elements      | Owner | Access privileges | Description
--------+------+---------------+------+--------------------+-------+-------------------+-------------
public | role | role          | 4    | retailer          +| libby |                   |
			 |      |               |      | network_provider  +|       |                   |
			 |      |               |      | telemetry_provider+|       |                   |
			 |      |               |      | network            |       |                   |
```

*`\?`*

```bash
General
  \copyright             show PostgreSQL usage and distribution terms
  \g [FILE] or ;         execute query (and send results to file or |pipe)
  \gset [PREFIX]         execute query and store results in psql variables
  \q                     quit psql
  \watch [SEC]           execute query every SEC seconds

Help
  \? [commands]          show help on backslash commands
  \? options             show help on psql command-line options
  \? variables           show help on special variables
  \h [NAME]              help on syntax of SQL commands, * for all commands

Query Buffer
  \e [FILE] [LINE]       edit the query buffer (or file) with external editor
  \ef [FUNCNAME [LINE]]  edit function definition with external editor
  \p                     show the contents of the query buffer
  \r                     reset (clear) the query buffer
  \s [FILE]              display history or save it to file
  \w FILE                write query buffer to file

Input/Output
  \copy ...              perform SQL COPY with data stream to the client host
  \echo [STRING]         write string to standard output
  \i FILE                execute commands from file
  \ir FILE               as \i, but relative to location of current script
  \o [FILE]              send all query results to file or |pipe
  \qecho [STRING]        write string to query output stream (see \o)

Informational
  (options: S = show system objects, + = additional detail)
  \d[S+]                 list tables, views, and sequences
  \d[S+]  NAME           describe table, view, sequence, or index
  \da[S]  [PATTERN]      list aggregates
  \db[+]  [PATTERN]      list tablespaces
  \dc[S+] [PATTERN]      list conversions
  \dC[+]  [PATTERN]      list casts
  \dd[S]  [PATTERN]      show object descriptions not displayed elsewhere
  \ddp    [PATTERN]      list default privileges
  \dD[S+] [PATTERN]      list domains
  \det[+] [PATTERN]      list foreign tables
  \des[+] [PATTERN]      list foreign servers
  \deu[+] [PATTERN]      list user mappings
  \dew[+] [PATTERN]      list foreign-data wrappers
  \df[antw][S+] [PATRN]  list [only agg/normal/trigger/window] functions
  \dF[+]  [PATTERN]      list text search configurations
  \dFd[+] [PATTERN]      list text search dictionaries
  \dFp[+] [PATTERN]      list text search parsers
  \dFt[+] [PATTERN]      list text search templates
  \dg[+]  [PATTERN]      list roles
  \di[S+] [PATTERN]      list indexes
  \dl                    list large objects, same as \lo_list
  \dL[S+] [PATTERN]      list procedural languages
  \dm[S+] [PATTERN]      list materialized views
  \dn[S+] [PATTERN]      list schemas
  \do[S]  [PATTERN]      list operators
  \dO[S+] [PATTERN]      list collations
  \dp     [PATTERN]      list table, view, and sequence access privileges
  \drds [PATRN1 [PATRN2]] list per-database role settings
  \ds[S+] [PATTERN]      list sequences
  \dt[S+] [PATTERN]      list tables
  \dT[S+] [PATTERN]      list data types
  \du[+]  [PATTERN]      list roles
  \dv[S+] [PATTERN]      list views
  \dE[S+] [PATTERN]      list foreign tables
  \dx[+]  [PATTERN]      list extensions
  \dy     [PATTERN]      list event triggers
  \l[+]   [PATTERN]      list databases
  \sf[+] FUNCNAME        show a function's definition'
  \z      [PATTERN]      same as \dp

Formatting
  \a                     toggle between unaligned and aligned output mode
  \C [STRING]            set table title, or unset if none
  \f [STRING]            show or set field separator for unaligned query output
  \H                     toggle HTML output mode (currently off)
  \pset [NAME [VALUE]]   set table output option
                         (NAME := {format|border|expanded|fieldsep|fieldsep_zero|footer|null|
                         numericlocale|recordsep|recordsep_zero|tuples_only|title|tableattr|pager|
                         unicode_border_linestyle|unicode_column_linestyle|unicode_header_linestyle})
  \t [on|off]            show only rows (currently off)
  \T [STRING]            set HTML <table> tag attributes, or unset if none
  \x [on|off|auto]       toggle expanded output (currently off)

Connection
  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "network_discovery_development")
  \encoding [ENCODING]   show or set client encoding
  \password [USERNAME]   securely change the password for a user
  \conninfo              display information about current connection

Operating System
  \cd [DIR]              change the current working directory
  \setenv NAME [VALUE]   set or unset environment variable
  \timing [on|off]       toggle timing of commands (currently off)
  \! [COMMAND]           execute command in shell or start interactive shell

Variables
  \prompt [TEXT] NAME    prompt user to set internal variable
  \set [NAME [VALUE]]    set internal variable, or list all if no parameters
  \unset NAME            unset (delete) internal variable

Large Objects
  \lo_export LOBOID FILE
  \lo_import FILE [COMMENT]
  \lo_list
  \lo_unlink LOBOID      large object operations
```
