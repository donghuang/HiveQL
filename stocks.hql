--创建外部表
CREATE EXTERNAL TABLE IF NOT EXISTS test.stocks(
exchang STRING,
symbol STRING,
ymd STRING,
price_open FLOAT,
price_high FLOAT,
price_low FLOAT,
price_close FLOAT,
volume INT,
price_adj_close FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/test/stocks'
;

--删除外部表 只会删除元数据 不会删除hdfs上的目录和数据
DROP TABLE test.stocks
;

--复制表结构
CREATE EXTERNAL TABLE IF NOT EXISTS test.employees1
LIKE test.employees
LOCATION '/test/employee2'
;