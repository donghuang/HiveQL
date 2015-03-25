--hive 结合Zookeeper 实现锁机制
--1 共享锁：某个表被读取的时候使用，可防止表被删除等
--2 独占锁：修改表的时候使用，会冻结其他表修改操作，也会阻止其他进程的查询操作。
--当分区表的某个分区获取独占锁时，需要对该表获取共享锁。

SHOW LOCKS TABLE  [ EXTENDED | PARTITION () EXTENDED ];

LOCK TABLE TABLE EXCLUSIVE ;--会阻止查询操作
UNLOCK TABLE TABLE;