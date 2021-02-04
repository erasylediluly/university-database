CREATE OR REPLACE FUNCTION get_profit RETURN NUMBER IS
    TYPE t_students IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    v_studtab t_students;
    v_result NUMBER := 0;
BEGIN
    SELECT DISTINCT student_id BULK COLLECT INTO v_studtab FROM course_selection;
    FOR i IN v_studtab.FIRST..v_studtab.LAST LOOP
        v_result:=v_result + get_retake(v_studtab(i));
    END LOOP;
    RETURN v_result;
END;
SET SERVEROUTPUT ON;
BEGIN DBMS_OUTPUT.PUT_LINE(get_profit());END;