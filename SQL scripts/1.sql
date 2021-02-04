SELECT course_code,MAX(reg_date) as first,MIN(reg_date) as last FROM course_selection WHERE reg_date IS NOT NULL AND year = '2019' AND term = '1' GROUP BY course_code;
SELECT course_code,COUNT(reg_date)/(nullif(MAX(cast(reg_date as date))-MIN(cast(reg_date as date)),0)) as speed FROM course_selection 
WHERE reg_date IS NOT NULL AND year = '2019' AND term = '2' GROUP BY course_code HAVING COUNT(reg_date)/(nullif(MAX(cast(reg_date as date))-MIN(cast(reg_date as date)),0)) IS NOT NULL
ORDER BY speed DESC;
/
SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE my_pkg1 IS
TYPE t_col IS RECORD(
i NUMBER,
n VARCHAR2(100));
TYPE col IS TABLE OF t_col;
FUNCTION task1(p_year VARCHAR2, p_term VARCHAR2) RETURN col PIPELINED;
END my_pkg1;
/
CREATE OR REPLACE PACKAGE BODY my_pkg1 IS
FUNCTION task1(p_year VARCHAR2, p_term VARCHAR2) RETURN col PIPELINED IS
    result col;
    CURSOR c1 IS SELECT course_code,COUNT(reg_date)/(nullif(MAX(cast(reg_date as date))-MIN(cast(reg_date as date)),0)) as speed FROM course_selection 
WHERE reg_date IS NOT NULL AND year = '2019' AND term = '2' GROUP BY course_code HAVING COUNT(reg_date)/(nullif(MAX(cast(reg_date as date))-MIN(cast(reg_date as date)),0)) IS NOT NULL
ORDER BY speed DESC;
    v_cur c1%ROWTYPE;
    v_cnt NUMBER := 0;
    r t_col;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_cur;
        r.i := v_cnt;
        r.n := v_cur.course_code;
        PIPE ROW(r);
        v_cnt := v_cnt + 1;
        EXIT WHEN v_cnt > 10;
    END LOOP;
    CLOSE c1;
    RETURN;
END;
END my_pkg1;
/
SELECT * FROM TABLE(my_pkg1.task1('2019','2'));
SELECT DISTINCT b.employee_id FROM course_selection a INNER JOIN course_section b ON a.course_code = b.course_code AND a.section = b.section AND a.year = b.year AND a.term = b.term WHERE a.course_code = 'LAW 616' AND a.year = '2019' AND a.term = '2';