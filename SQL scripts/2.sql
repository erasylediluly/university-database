SELECT course_code,MAX(reg_date) as first,MIN(reg_date) as last FROM course_selection WHERE reg_date IS NOT NULL AND year = '2019' AND term = '1' GROUP BY course_code;
SELECT course_code,COUNT(reg_date)/(nullif(MAX(cast(reg_date as date))-MIN(cast(reg_date as date)),0)) as speed FROM course_selection 
WHERE reg_date IS NOT NULL AND year = '2019' AND term = '2' GROUP BY course_code HAVING COUNT(reg_date)/(nullif(MAX(cast(reg_date as date))-MIN(cast(reg_date as date)),0)) IS NOT NULL
ORDER BY speed DESC;
/
SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE my_pkg2 IS
TYPE t_col IS RECORD(
i NUMBER,
n VARCHAR2(100));
TYPE col IS TABLE OF t_col;
FUNCTION task2(p_year VARCHAR2, p_term VARCHAR2,p_course_code VARCHAR2) RETURN col PIPELINED;
END my_pkg2;
/
CREATE OR REPLACE PACKAGE BODY my_pkg2 IS
FUNCTION task2(p_year VARCHAR2, p_term VARCHAR2,p_course_code VARCHAR2) RETURN col PIPELINED IS
    result col;
    CURSOR c1 IS SELECT b.employee_id,COUNT(a.reg_date)/(nullif(MAX(cast(a.reg_date as date))-MIN(cast(a.reg_date as date)),0)) as speed FROM course_selection a
    INNER JOIN course_section b ON a.course_code = b.course_code AND a.section = b.section AND a.year = b.year AND a.term = b.term
WHERE a.reg_date IS NOT NULL AND a.year = p_year AND a.term = p_term AND a.course_code = p_course_code GROUP BY b.employee_id HAVING COUNT(a.reg_date)/(nullif(MAX(cast(a.reg_date as date))-MIN(cast(a.reg_date as date)),0)) IS NOT NULL
ORDER BY speed DESC;
    v_cur c1%ROWTYPE;
    v_cnt NUMBER := 0;
    r t_col;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_cur;
        EXIT WHEN c1%NOTFOUND;
        r.i := v_cnt;
        r.n := v_cur.employee_id;
        PIPE ROW(r);
        v_cnt := v_cnt + 1;
    END LOOP;
    CLOSE c1;
    RETURN;
END;
END my_pkg2;
/
SELECT COUNT(*) FROM TABLE(my_pkg2.task2('2019','2','CSS 305')); 
SELECT b.employee_id,COUNT(a.reg_date)/(nullif(MAX(a.reg_date)-MIN(a.reg_date),0)) as speed FROM course_selection a
    INNER JOIN course_section b ON a.course_code = b.course_code AND a.section = b.section AND a.year = b.year AND a.term = b.term
WHERE a.reg_date IS NOT NULL AND a.year = '2019' AND a.term = '2' AND a.course_code = 'CSS 305' GROUP BY b.employee_id HAVING COUNT(a.reg_date)/(nullif(MAX(a.reg_date)-MIN(a.reg_date),0)) IS NOT NULL
ORDER BY speed DESC;