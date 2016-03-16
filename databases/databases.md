# Databases - general stuff

#### Migrations

In regard to taking out a column from db, remove all reference to the column FIRST in your code. Once you have done that, then removed the column via a migration. In particular if you are doing this on a live production site.
