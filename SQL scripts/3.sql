SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION get_SPA(p_year VARCHAR2, p_term VARCHAR2, p_student_id VARCHAR2) RETURN NUMBER IS 
    v_credit VARCHAR2(50);
    v_sum_of_credits NUMBER := 0;
    mark_times_credit NUMBER := 0;
    TYPE marks IS TABLE OF NUMBER INDEX BY VARCHAR2(50);
    marks_table marks;
BEGIN
    marks_table('A') := 4;
    marks_table('A-') := 3.67;
    marks_table('B+') := 3.33;
    marks_table('B') := 3;
    marks_table('B-') := 2.67;
    marks_table('C+') := 2.33;
    marks_table('C') := 2;
    marks_table('C-') := 1.67;
    marks_table('D+') := 1.33;
    marks_table('D') := 1;
    marks_table('F') := 0;
    marks_table('FX') := 0;
    FOR i IN (SELECT * FROM course_selection WHERE YEAR = p_year AND student_id = p_student_id AND term = p_term) LOOP
        IF marks_table.EXISTS(i.char_mark) THEN
            v_sum_of_credits := v_sum_of_credits + 3;
            mark_times_credit := mark_times_credit + marks_table(i.char_mark)*3;
        END IF;
    END LOOP;
    RETURN ROUND(mark_times_credit/v_sum_of_credits,2);
END;
/
CREATE OR REPLACE FUNCTION get_GPA(p_student_id VARCHAR2) RETURN NUMBER IS 
    v_credit VARCHAR2(50);
    v_sum_of_credits NUMBER := 0;
    mark_times_credit NUMBER := 0;
    TYPE marks IS TABLE OF NUMBER INDEX BY VARCHAR2(50);
    marks_table marks;
BEGIN
    marks_table('A') := 4;
    marks_table('A-') := 3.67;
    marks_table('B+') := 3.33;
    marks_table('B') := 3;
    marks_table('B-') := 2.67;
    marks_table('C+') := 2.33;
    marks_table('C') := 2;
    marks_table('C-') := 1.67;
    marks_table('D+') := 1.33;
    marks_table('D') := 1;
    marks_table('F') := 0;
    marks_table('FX') := 0;
    FOR i IN (SELECT * FROM course_selection WHERE student_id = p_student_id) LOOP
        IF marks_table.EXISTS(i.char_mark) THEN
            v_sum_of_credits := v_sum_of_credits + 3;
            mark_times_credit := mark_times_credit + marks_table(i.char_mark)*3;
        END IF;
    END LOOP;
    RETURN ROUND(mark_times_credit/v_sum_of_credits,2);
END;
DECLARE
    i NUMBER;
BEGIN
    i := get_SPA('2019','1','C47FE5EC77452FF0E951E42BB609577BCAD62FBB');
    DBMS_OUTPUT.PUT_LINE(i);
    DBMS_OUTPUT.PUT_LINE(get_GPA('C47FE5EC77452FF0E951E42BB609577BCAD62FBB'));
END;    
SELECT DISTINCT total_mark,char_mark FROM course_selection;
SELECT * FROM course_schedule;
SELECT * FROM course_selection WHERE YEAR = '2019' AND student_id = 'C47FE5EC77452FF0E951E42BB609577BCAD62FBB' AND term = '1';
SELECT DISTINCT course_code, credits FROM course_section WHERE credits IS NOT NULL and course_code = 'CSS 215';