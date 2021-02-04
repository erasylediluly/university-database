CREATE OR REPLACE FUNCTION get_schedule_t(p_employee_id VARCHAR2,p_year VARCHAR2, p_term VARCHAR2,p_day VARCHAR2, p_time VARCHAR2) RETURN VARCHAR2 IS
    v_result VARCHAR2(50);
BEGIN
    SELECT course_code || ' ' || section INTO v_result FROM (SELECT a.course_code, a.section, to_char(b.start_time ,'D') as day, to_char(b.start_time ,'hh24') as time FROM course_section a 
    INNER JOIN course_schedule b ON a.course_code = b.course_code AND a.section = b.section AND a.year = b.year AND a.term = b.term
    WHERE a.employee_id = p_employee_id AND a.year = p_year AND a.term = p_term) WHERE day = p_day AND time = p_time;
    RETURN v_result;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN '';
END;
SET SERVEROUTPUT ON;
BEGIN DBMS_OUTPUT.PUT_LINE(get_schedule_t('10560','2017','1','6','19')); END;
SELECT a.course_code, a.section, to_char(b.start_time ,'D') as day, to_char(b.start_time ,'hh24') as time FROM course_section a 
    INNER JOIN course_schedule b ON a.course_code = b.course_code AND a.section = b.section AND a.year = b.year AND a.term = b.term
    WHERE a.employee_id = '10560' AND a.year = '2017' AND a.term = '1';