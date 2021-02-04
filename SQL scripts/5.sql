SELECT * FROM course_selection WHERE student_id = 'CD84276596B9FF061DE668C6752CF37B1146B687'; --retakes
SELECT course_code FROM (SELECT course_code 
FROM course_selection WHERE student_id = 'CD84276596B9FF061DE668C6752CF37B1146B687' 
GROUP BY course_code HAVING count(student_id) > 1);

CREATE OR REPLACE FUNCTION get_retake_year(p_student_id VARCHAR2, p_year VARCHAR2,p_term VARCHAR2) RETURN NUMBER IS
    v_result NUMBER;
BEGIN
    SELECT 75000*COUNT(course_code) INTO v_result FROM course_selection 
    WHERE course_code IN (SELECT course_code FROM (SELECT count(student_id), course_code 
    FROM course_selection WHERE student_id = p_student_id
    GROUP BY course_code HAVING count(student_id) > 1)) AND student_id = p_student_id AND year = p_year AND term = p_term AND total_mark >= 50;
    RETURN v_result;
END;
CREATE OR REPLACE FUNCTION get_retake(p_student_id VARCHAR2) RETURN NUMBER IS
    TYPE t_students IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    v_studtab t_students;
    v_result NUMBER := 0;
    v_num NUMBER;
BEGIN
    SELECT course_code BULK COLLECT INTO v_studtab
    FROM course_selection WHERE student_id = p_student_id
    GROUP BY course_code HAVING count(student_id) > 1;
    IF(v_studtab.COUNT = 0) THEN RETURN 0;
    END IF;
    FOR i IN v_studtab.FIRST .. v_studtab.LAST LOOP
        SELECT 75000*COUNT(course_code) INTO v_num FROM course_selection 
        WHERE course_code = v_studtab(i) AND student_id = p_student_id AND total_mark >= 50;
        v_result := v_result + v_num;
    END LOOP;
    RETURN v_result;
END;
SET SERVEROUTPUT ON;
BEGIN DBMS_OUTPUT.PUT_LINE(get_retake_year('CD84276596B9FF061DE668C6752CF37B1146B687','2017','1')); END;
BEGIN DBMS_OUTPUT.PUT_LINE(get_retake('CD84276596B9FF061DE668C6752CF37B1146B687')); END;
SELECT * FROM course_selection
WHERE course_code IN (SELECT course_code FROM (SELECT count(student_id), course_code 
FROM course_selection WHERE student_id = 'CD84276596B9FF061DE668C6752CF37B1146B687' 
GROUP BY course_code HAVING count(student_id) > 1)) AND student_id = 'CD84276596B9FF061DE668C6752CF37B1146B687'  AND total_mark >= 50;
