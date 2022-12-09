
### Drop one column in exist table.
```mysql
mysql>  select * from state;
-----------------------------
|name   | id  | phone       |
-----------------------------
|apple  | 1   | xxxx        |
-----------------------------

mysql> alter table state drop column id;

mysql>  select * from state;
-----------------------
|name   | phone       |
-----------------------
|apple  | xxxx        |
-----------------------

```

### Select value output use into another table select
> WHERE id in (3,4)
```mysql

SELECT * 
from TableB 
WHERE AccountId in 
   ( SELECT id 
     from TableA where email 
     in ('user1@example.com', 'user2@example.com')
);

-----------------------
|id     | phone       |
-----------------------
|apple  | xxxx        |
|banana | xxxx        |
-----------------------

```
