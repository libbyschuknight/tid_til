# Heroku

Copy prod / deployed db to local:

```
heroku pg:pull postgresql-angular-26758 libs-karate-site_development --app libs-karate-site
# heroku pg:pull <heroku psql name> <local-db-name> --app <app name>
```
