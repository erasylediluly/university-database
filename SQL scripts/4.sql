SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE my_pkg IS
TYPE t_col IS RECORD(
i NUMBER,
n VARCHAR2(100));
TYPE col IS TABLE OF t_col;
FUNCTION task4 RETURN col PIPELINED;
END my_pkg;
CREATE OR REPLACE PACKAGE BODY my_pkg IS
FUNCTION task4 RETURN col PIPELINED IS
    result col;
    CURSOR c1 IS SELECT DISTINCT student_id, year, term FROM course_selection WHERE term != 3 ORDER BY student_id, year, term;
    v_prev c1%ROWTYPE;
    v_cur c1%ROWTYPE;
    v_cnt NUMBER := 0;
    r t_col;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_cur;
        IF((v_cur.student_id = v_prev.student_id AND v_cur.year != v_prev.year AND v_cur.term = v_prev.term)) THEN 
            r.i := v_cnt;
            r.n := v_cur.student_id;
            PIPE ROW(r);
            v_cnt := v_cnt + 1;
        END IF; 
        FETCH c1 INTO v_prev;
        EXIT WHEN c1%NOTFOUND;
    END LOOP;
    CLOSE c1;
    RETURN;
END;
END my_pkg;
SELECT * FROM TABLE(my_pkg.task4);
SELECT DISTINCT student_id, year, term FROM course_selection WHERE term != 3  AND student_id = '96846E26DCEE79A7E263CEC8B08A0217FCE9B1E4' ORDER BY year, term;
SELECT N FROM TABLE(my_pkg.task4) WHERE I = 1;