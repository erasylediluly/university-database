SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION teacher_loading(p_year IN VARCHAR2, p_term IN VARCHAR2, p_employee_id IN VARCHAR2) RETURN NUMBER IS
    v_hours NUMBER;
BEGIN
    SELECT SUM(hour_num,'99999999D99999', 'nls_numeric_characters=''.,''') INTO v_hours FROM course_section WHERE year = TO_CHAR(p_year) AND term = TO_CHAR(p_term) AND employee_id = TO_CHAR(p_employee_id);
    RETURN v_hours;
END;

DECLARE
    v_hours NUMBER;
BEGIN
    v_hours := teacher_loading('2016','1','10127');
    DBMS_OUTPUT.PUT_LINE(v_hours);
END;

SELECT * FROM course_selection;
SELECT * FROM course_schedule;
SELECT * FROM course_section;