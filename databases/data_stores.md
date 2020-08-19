# Data Stores and stuff

[Redis](https://redis.io/)

>Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker. It supports data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs, geospatial indexes with radius queries and streams. Redis has built-in replication, Lua scripting, LRU eviction, transactions and different levels of on-disk persistence, and provides high availability via Redis Sentinel and automatic partitioning with Redis Cluster. Learn more →

## Redis command line

`redis-cli` - <https://redis.io/topics/rediscli>

```bash
> keys *
(list of all keys)

> get child_planning_cycles_permissions
(error) WRONGTYPE Operation against a key holding the wrong kind of value
# because "child_planning_cycles_permissions" isn't a string, it is a hash, so need to do:
# https://stackoverflow.com/questions/37953019/wrongtype-operation-against-a-key-holding-the-wrong-kind-of-value-php

> type child_planning_cycles_permissions
 hash

> HGETALL child_planning_cycles_permissions
1) "boolean"
2) "true"

```

>Mat
>Ohhh I know this one! Redis has the concept of numerical "databases" which you can change between by selecting them e.g. SELECT 1 - we store different types of things in different databases because there was a "bad time" (tm) years ago when we didn't and ran out of redis memory so had to flush everything at once.
>Now we have a cache database so could flush that in isolation and not drop our session storage or job queues.
>TL;DR we have multiple redis databases for different data, the caching can be switched into on redis-cli by typing SELECT 2 once in the cli console

```bash
> select 2

# wasn't showing up as a key
# flush the db
> flushdb

# run the api again, then
> keys *
1) "cache:child_permissions/3/children/3-20200809204436426047"
2) "cache:child_permissions/3/children/18-20200811071119653140"
3) "cache:child_permissions/3/children/4-20200702233535242478"
4) "cache:child_permissions/3/children/19-20200705223331844730"
5) "cache:child_permissions/3/children/22-20200705223331919105"

# show the value of the key
>get cache:child_permissions/3/children/22-20200705223331919105
"\x04\bo: ActiveSupport::Cache::Entry\t:\x0b@value{\b:\teditT:\x13daily_routines{\x06:\x0eavailableT:\x14planning_cycles{\x06;\tF:\r@version0:\x10@created_atf\x161597792747.832482:\x10@expires_inf\n1.2e2"

# see how many seconds are left to run of the cache
> ttl cache:child_permissions/3/children/22-20200705223331919105
(integer) 48
