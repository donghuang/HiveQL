--删除数据库 cascade：先删除库表 后删除库
drop database if exists test cascade;

--创建数据库  
create database if not exists test 
comment "donghuang test" 
location '/user/hive/warehouse/test.db' 
with dbproperties('creator'='Dong Huang','date'='2015-03-20')
;
--显示数据库信息
-- DESCRIBE DATABASE EXTENDED test;
--启用数据库
use test
;
--创建|删除 管理表 hive或多或少会控制着数据的生命周期
drop table if exists test.employees;
create table if not exists test.employees(
	name STRING comment 'employee name',
	salary FLOAT comment 'employee salary',
	subordinates ARRAY<STRING> comment 'employee subordinates',
	deductions MAP<STRING,FLOAT> comment 'employee deductions',
	address STRUCT<street:STRING,city:STRING,state:STRING,zip:INT> comment 'employee address'
)
COMMENT 'table of employee'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
COLLECTION ITEMS TERMINATED BY ','
MAP KEYS TERMINATED BY ':'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/test.db/employees'
TBLPROPERTIES('creator'='Dong Huang','date'='2015-03-20')
;
--show [tblproperties] employees;
--describe extended|format employees;

--加载数据
--LOAD DATA [LOCAL] INPATH 'filepath' [OVERWRITE] INTO TABLE tablename [PARTITION (partcol1=val1, partcol2=val2 ...)]
LOAD DATA LOCAL INPATH 'employees.dat' OVERWRITE INTO TABLE  employees
;
