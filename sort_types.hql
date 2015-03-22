--order by 全局排序：所以数据会经过一个reducer进行排序处理
select * from weblog order by dt desc limit 100;

--sort by  局部排序：只会在每个reducer中对数据进行排序
--当reducer个数大于1时，二者排序结果不一样
select * from weblog sort by  dt desc;

--含有sort by 的distribute by
--distribute by 控制map的输出在reducer中是如何划分的
SELECT a.*
from weblog a
distribute by a.user_id
sort by a.user_id,a.dt


--cluster by 等价于 含有sort by 的distribute by，列完全相同，且升序排序
SELECT a.*
from weblog a
cluster by  a.user_id
;