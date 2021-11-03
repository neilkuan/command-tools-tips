
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
