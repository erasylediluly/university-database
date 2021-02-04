create or replace FUNCTION get_sum_credits(p_year IN VARCHAR2, p_term IN VARCHAR2, p_student_id IN VARCHAR2) RETURN NUMBER IS
    v_credits NUMBER;
    v_subjects_num1 NUMBER;
    v_subjects_num2 NUMBER;
BEGIN
    SELECT SUM(c.credits) INTO v_credits FROM (SELECT DISTINCT a.course_code, b.credits FROM course_selection a INNER JOIN course_section b ON a.course_code = b.course_code WHERE a.year = p_year AND a.term = p_term AND a.student_id = p_student_id AND b.credits IS NOT NULL AND b.credits != 0) c ;
    SELECT COUNT(c.course_code) INTO v_subjects_num1 FROM (SELECT DISTINCT a.course_code, b.credits FROM course_selection a INNER JOIN course_section b ON a.course_code = b.course_code WHERE a.year = p_year AND a.term = p_term AND a.student_id = p_student_id AND b.credits IS NOT NULL AND b.credits != 0) c ;
    SELECT COUNT(course_code) INTO v_subjects_num2 FROM course_selection WHERE year = p_year AND term = p_term AND student_id = p_student_id;
    v_credits := v_credits + (v_subjects_num2-v_subjects_num1)*3;
    RETURN v_credits;
END;
CREATE OR REPLACE FUNCTION get_num_courses(p_year IN VARCHAR2, p_term IN VARCHAR2, p_student_id IN VARCHAR2) RETURN NUMBER IS
    v_courses NUMBER;
BEGIN
    SELECT COUNT(course_code) INTO v_courses FROM course_selection WHERE year = p_year AND term = p_term AND student_id = p_student_id;
    RETURN v_courses;
END;

SET SERVEROUTPUT ON;
SELECT DISTINCT a.course_code, b.credits FROM course_selection a INNER JOIN course_section b ON a.course_code = b.course_code WHERE a.year = '2019' AND a.term = '1' AND a.student_id = 'C47FE5EC77452FF0E951E42BB609577BCAD62FBB' AND b.credits IS NOT NULL AND b.credits != 0
    BEGIN DBMS_OUTPUT.PUT_LINE(get_num_courses('2019','1','C47FE5EC77452FF0E951E42BB609577BCAD62FBB') || ' ' || get_sum_credits('2019','1','C47FE5EC77452FF0E951E42BB609577BCAD62FBB')) ;END;