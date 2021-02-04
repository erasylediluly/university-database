CREATE OR REPLACE FUNCTION get_most_clever(p_emp_id VARCHAR2, p_course_code VARCHAR2) RETURN VARCHAR2 IS
    v_result VARCHAR2(50);
BEGIN
    SELECT year||' '||term INTO v_result FROM (SELECT a.course_code,a.year,a.term,AVG(a.total_mark) as mark,b.employee_id FROM course_selection a INNER JOIN course_section b ON a.course_code = b.course_code AND a.year = b.year AND a.term = b.term AND a.section = b.section 
    WHERE a.course_code = p_course_code AND b.employee_id = p_emp_id GROUP BY a.course_code,a.year,a.term,b.employee_id) a WHERE mark = (SELECT MAX(mark) FROM (SELECT a.course_code,a.year,a.term,AVG(a.total_mark) as mark,b.employee_id FROM course_selection a INNER JOIN course_section b ON a.course_code = b.course_code AND a.year = b.year AND a.term = b.term AND a.section = b.section 
    WHERE a.course_code = p_course_code AND b.employee_id = p_emp_id GROUP BY a.course_code,a.year,a.term,b.employee_id));
    RETURN v_result;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 'no data found';
END;
SET SERVEROUTPUT ON;
BEGIN DBMS_OUTPUT.PUT_LINE(get_most_clever('10106','CSS 104')); END;