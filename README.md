## Start Redash

Disconnect from all VPN

```
cd redash
./setup.sh
```

This will also start a pg db that will act as your source of data. See service called `pg` in compose file.

## Create connection

Connect to `http://localhost:5000`

- create your admin user
- create your Data source. Use `host.docker.internal` as hostname

## Test

```
cd data
./create.sh
```

Go into redash and create a query with `select * from products`.

Should see data from `pg`

```
 id |   name
----+----------
  1 | mouse
  2 | keyboard
```
