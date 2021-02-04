        # self.GPA_btn.configure(command=lambda:task32(self.stu_id62_en.get(),self.gpa6_en))
        # self.SPA_btn.configure(command=lambda:task31(self.year6_en.get(),self.term6_en.get(),self.stu_id61_en.get(),self.spa6_en))
        # self.Button1.configure(command=lambda:task6(self.year_en.get(),self.term_en.get(),self.emp_id_en.get(),self.hours_en))
        # self.Enter9_btn.configure(command=lambda:task9(self.stu_id9_en.get(),self.year9_en.get(),self.term9_en.get(),self.courses9_en,self.credits9_en))
        # self.ok_btn.configure(command = lambda:task8(self))
        # self.ok7_btn.configure(command = lambda:task7(self))
        # self.ok5_semester_btn.configure(command = lambda: task51(self))
        # self.ok5_btn.configure(command = lambda: task52(self))
        # self.ok4_en.configure(command = lambda: task4(self))
        # self.ok1_btn.configure(command = lambda: task1(self))
        # self.ok2_btn.configure(command = lambda: task2(self))
        # self.ok12_btn.configure(command = lambda: task2(self))
        # self.ok11_btn.configure(command = lambda: task1(self))
import cx_Oracle

def get_connection():
    con = cx_Oracle.connect("myUser/myPassword@localhost:1521/ORCLDATABASE")
    return con
def task1(root):
    connection = get_connection()
    cursor = connection.cursor()
    count = 0
    for i in range(10):
        cursor.execute('SELECT N FROM TABLE(my_pkg1.task1({},{})) WHERE I ={}'.format(root.year1_en.get(),root.term1_en.get(),i))
        r = cursor.fetchall()
        course = r[0][0]
        root.Scrolledlistbox1.insert(count,course)
        count+=1
        cursor.execute('''SELECT DISTINCT b.employee_id FROM course_selection a INNER JOIN course_section b ON a.course_code = b.course_code AND a.section = b.section AND a.year = b.year AND a.term = b.term WHERE a.course_code = \'{}\' AND a.year = {} AND a.term = {}'''.format(course,root.year1_en.get(),root.term1_en.get()))
        a = cursor.fetchall()
        for j in a:
            root.Scrolledlistbox1.insert(count,j[0])
            count+=1
    connection.commit()
    cursor.close()
def task2(root):
    connection = get_connection()
    cursor = connection.cursor()
    cursor.execute('SELECT COUNT(*) FROM TABLE(my_pkg2.task2(\'{}\',\'{}\',\'{}\'))'.format(root.year2_en.get(),root.term2_en.get(),root.course_code2_en.get()))
    r = cursor.fetchall()
    for i in range(r[0][0]):
        cursor.execute('SELECT N FROM TABLE(my_pkg2.task2(\'{}\',\'{}\',\'{}\')) WHERE I ={}'.format(root.year2_en.get(),root.term2_en.get(),root.course_code2_en.get(),i))
        r = cursor.fetchall()
        root.Scrolledlistbox2.insert(i,r[0][0])
    connection.commit()
    cursor.close()
def task31(year, term, stu_id,spa6_en):
    connection = get_connection()
    cursor = connection.cursor() 
    n = cursor.callfunc(name="get_SPA",returnType=str,parameters =[year, term, stu_id])
    spa6_en.delete(0,"end")
    spa6_en.insert(0,n)
    connection.commit()
    cursor.close()
def task32(stu_id,gpa6_en):
    connection = get_connection()
    cursor = connection.cursor() 
    n = cursor.callfunc(name="get_GPA",returnType=str,parameters =[stu_id])
    gpa6_en.delete(0,"end")
    gpa6_en.insert(0,n)
    connection.commit()
    cursor.close()
def task4(root):
    connection = get_connection()
    cursor = connection.cursor()
    cursor.execute('SELECT COUNT(*) FROM TABLE(my_pkg.task4)')
    n = cursor.fetchall()
    for i in range(n[0][0]):
        cursor.execute('SELECT N FROM TABLE(my_pkg.task4) WHERE I ={}'.format(i))
        r = cursor.fetchall()
        root.Scrolledlistbox4.insert(i,r)
    connection.commit()
    cursor.close()
def task51(root):
    connection = get_connection()
    cursor = connection.cursor()
    n1 = cursor.callfunc(name="get_retake_year",returnType=str,parameters =[root.stu_id51_en.get(),root.year5_en.get(),root.term5_en.get()])
    root.result51_en.delete(0,"end")
    root.result51_en.insert(0,n1)
    connection.commit()
    cursor.close()
def task52(root):
    connection = get_connection()
    cursor = connection.cursor()
    n1 = cursor.callfunc(name="get_retake",returnType=str,parameters =[root.stu_id52_en.get()])
    root.result52_en.delete(0,"end")
    root.result52_en.insert(0,n1)
    connection.commit()
    cursor.close()
def task6(year, term, emp_id,hours_en):
    connection = get_connection()
    cursor = connection.cursor() 
    n = cursor.callfunc(name="teacher_loading",returnType=str,parameters =[year, term, emp_id])
    hours_en.delete(0,"end")
    hours_en.insert(0,n)
    connection.commit()
    cursor.close()
def task7(root):
    connection = get_connection()
    cursor = connection.cursor()
    l = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
    tk.Label(root.Frame2,activebackground="#f9f9f9",activeforeground="black",
        background="#d9d9d9",disabledforeground="#a3a3a3",foreground="#000000",highlightbackground="#d9d9d9",
        highlightcolor="black",text = '',width = 11).grid(row = 0, column = 0)
    for i in range(0,6):
        tk.Label(root.Frame2,activebackground="#f9f9f9",activeforeground="black",
        background="#d9d9d9",disabledforeground="#a3a3a3",foreground="#000000",highlightbackground="#d9d9d9",
        highlightcolor="black",text = l[i],width = 11).grid(row = 0, column = i+1)
    for i in range(0,14):
        tk.Label(root.Frame2,activebackground="#f9f9f9",activeforeground="black",
        background="#d9d9d9",disabledforeground="#a3a3a3",foreground="#000000",highlightbackground="#d9d9d9",
        highlightcolor="black",text = str(i+9)+'-'+str(i+10),width = 11).grid(row = i+1, column = 0)
    for i in range(0,6):
        for j in range(0,14):
            tk.Label(root.Frame2,activebackground="#f9f9f9",activeforeground="black",
        background="#d9d9d9",disabledforeground="#a3a3a3",foreground="#000000",highlightbackground="#d9d9d9",
        highlightcolor="black",text = cursor.callfunc(name="get_schedule_t",returnType=str,parameters =[root.emp_id7_en.get(), root.year7_en.get(), root.term7_en.get(),str(i+2),'{:02d}'.format(j+9)]),width = 10).grid(row = j+1, column = i+1)
    connection.commit()
    cursor.close()

def task8(root):
    connection = get_connection()
    cursor = connection.cursor()
    l = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
    tk.Label(root.Frame1,activebackground="#f9f9f9",activeforeground="black",
        background="#d9d9d9",disabledforeground="#a3a3a3",foreground="#000000",highlightbackground="#d9d9d9",
        highlightcolor="black",text = '',width = 11).grid(row = 0, column = 0)
    for i in range(0,6):
        tk.Label(root.Frame1,activebackground="#f9f9f9",activeforeground="black",
        background="#d9d9d9",disabledforeground="#a3a3a3",foreground="#000000",highlightbackground="#d9d9d9",
        highlightcolor="black",text = l[i],width = 11).grid(row = 0, column = i+1)
    for i in range(0,14):
        tk.Label(root.Frame1,activebackground="#f9f9f9",activeforeground="black",
        background="#d9d9d9",disabledforeground="#a3a3a3",foreground="#000000",highlightbackground="#d9d9d9",
        highlightcolor="black",text = str(i+9)+'-'+str(i+10),width = 11).grid(row = i+1, column = 0)
    for i in range(0,6):
        for j in range(0,14):
            tk.Label(root.Frame1,activebackground="#f9f9f9",activeforeground="black",
        background="#d9d9d9",disabledforeground="#a3a3a3",foreground="#000000",highlightbackground="#d9d9d9",
        highlightcolor="black",text = cursor.callfunc(name="get_schedule",returnType=str,parameters =[root.stu_id8_en.get(), root.year8_en.get(), root.term8_en.get(),str(i+2),'{:02d}'.format(j+9)]),width = 10).grid(row = j+1, column = i+1)
    connection.commit()
    cursor.close()
def task9(stu_id, year, term, courses9_en,credits9_en):
    connection = get_connection()
    cursor = connection.cursor() 
    n1 = cursor.callfunc(name="get_sum_credits",returnType=str,parameters =[year, term, stu_id])
    n2 = cursor.callfunc(name="get_num_courses",returnType=str,parameters =[year, term, stu_id])
    credits9_en.delete(0,"end")
    credits9_en.insert(0,n1)
    courses9_en.delete(0,"end")
    courses9_en.insert(0,n2)
    connection.commit()
    cursor.close()
def task10(root):
    connection = get_connection()
    cursor = connection.cursor()
    n = cursor.callfunc(name='get_most_clever',returnType = str, parameters = [root.emp_id10_en.get(),root.course_code10_en.get()])
    root.result10_en.delete(0,"end")
    root.result10_en.insert(0,n)
    connection.commit()
    cursor.close()