---STREAMING 三种函数: MAP() REDUCER() TRANSFORM()
--SELECT TRANSFORM(COL1.COL2) USING '命令|脚本' AS(C1,..) FROM table_name;
--建议结合distribute by、sort by 、cluster by 使用
SELECT TRANSFORM(NAME,SALARY) 
USING 'cat' as (newname string,newsalary float)
from employees
;

SELECT TRANSFORM(NAME,SALARY) 
USING 'cat' as (newname string,newsalary INT)
from employees
;

SELECT TRANSFORM(NAME,SALARY) 
USING 'sed s/0/1/g' as (newname string,newsalary int)
from employees
;