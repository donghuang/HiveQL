--创建|删除 管理表 hive或多或少会控制着数据的生命周期
drop table if exists test.part_employees;
create table if not exists test.part_employees(
name STRING comment 'employee name',
salary FLOAT comment 'employee salary',
subordinates ARRAY<STRING> comment 'employee subordinates',
deductions MAP<STRING,FLOAT> comment 'employee deductions',
address STRUCT<street:STRING,city:STRING,state:STRING,zip:INT> comment 'employee address'
)
COMMENT 'table of employee'
PARTITIONED BY (country string ,state string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
COLLECTION ITEMS TERMINATED BY ','
MAP KEYS TERMINATED BY ':'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
TBLPROPERTIES('creator'='Dong Huang','date'='2015-03-20')
;
--查看分区
SHOW PARTITIONS test.part_employees
;

--装载数据
LOAD DATA LOCAL INPATH 'employees.dat'
INTO TABLE test.part_employees
PARTITION (country='CHINA',state='Shang Hai')
;

--修改表分区
ALTER TABLE test.part_employees PARTITOIN(country='CHINA',state='Shang Hai')
set location '/test/part_employees/'
;