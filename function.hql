--hive���� ��׼���� �ۺϺ���UDAF �����ɺ���UDTF
--����������UDTF��array() ����list�� explode()����list�����ض���
SELECT array('1',2,3) AS XX FROM SRC;

SELECT explode(array(1,2,3)) from src;

select explode(subordinates) from test.employees;

--explode ��� lateral view�����ظ����ֶ�
select a.*,sub
from test.employees a
lateral view explode(subordinates) subview as sub
;