# Terminal Stuff

Can do 'more <file_name>` and will show more information that is in file.
E.g.
`more .env.local`

```bash
DATABASE_DSN="postgresql://localhost/$(echo $SERVICE_NAME)_$(echo $RACK_ENV)"
ERRORS_TOKEN="XXXXXXXXXX"
ENVIRONMENT="test"
USERNAME=""
PASSWORD=""
```
`cat .env.local` will do the same thing.

A quick search of what `cat` is and found this link - [10 Terminal Commands That Will Boost Your Productivity](http://code.tutsplus.com/articles/10-terminal-commands-that-will-boost-your-productivity--net-14105).
