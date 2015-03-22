--hive中有 标准函数 聚合函数UDAF 表生成函数UDTF
--表生产函数UDTF：array() 返回list和 explode()接收list，返回多行
SELECT array('1',2,3) AS XX FROM SRC;

SELECT explode(array(1,2,3)) from src;

select explode(subordinates) from test.employees;

--explode 配合 lateral view，返回更多字段
select a.*,sub
from test.employees a
lateral view explode(subordinates) subview as sub
;