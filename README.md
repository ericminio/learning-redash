## Start Redash

Disconnect from all VPN

```
cd redash
./setup.sh
```

## Test

```
cd data
./create.sh
```

Go into redash and create a query with `select * from products`.

Should see

```
 id |   name
----+----------
  1 | mouse
  2 | keyboard
```
