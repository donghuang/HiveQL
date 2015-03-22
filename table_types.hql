--创建管理表
CREATE TABLE weblog(
 user_id string
,url string
,source_ip string
,dt string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
;
load data local inpath 'scripts/hiveQL/weblog.dat' into table weblog;

--分区表隔优点离数据和优化查询，缺点分区不合理会产生更多的小文件
CREATE TABLE raw_logs(
 user_id string
,url string
,source_ip string)
partitioned by (dt string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;
--动态分区
--需要设置set hive.exec.dynamic.partition.mode=nonstrict，否则要求至少一列分区字段是静态才能insert
insert overwrite table raw_logs
partition(dt)
select  user_id,url ,source_ip,a.dt
from weblog a
;
--对于分区表的缺点，可以使用分桶
--分桶的优点：桶个数一定，没有数据波动。适合抽样。有利于执行高效的map side join
CREATE TABLE part_clu_weblog(
 user_id string
,url string
,source_ip string)
partitioned by (dt string)
clustered by (user_id) into 4 buckets
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;
--插入分区分桶表
--设置 set hive.enforce.bucketing=true;强制hive为分桶初始化设置一个正确的reducer个数.
--否则需要手动设置同桶个数相同的reducer个数
from raw_logs
insert overwrite table part_clu_weblog
partition(dt='2015-01-01')
select user_id,url ,source_ip
where dt='2015-01-01'
;

--分桶表的抽样
select *
from part_clu_weblog
tablesample(bucket 3 out of 4 on rand())
where dt='2015-01-01';

--列存储适用：1重复数据(性别，年龄) 2很多字段的表，但查询只使很少字段