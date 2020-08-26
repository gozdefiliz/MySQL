select * from dept_manager_dup order by dept_no;

select * from departments_dup order by dept_no;

select m.dept_no, m.emp_no, d.dept_name 
from dept_manager_dup m
inner join departments_dup d
on m.dept_no = d.dept_no
order by m.dept_no;

#Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 

select dm.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
from dept_manager dm
inner join employees e
on dm.emp_no = e.emp_no
order by dm.emp_no;

insert into dept_manager_dup
values ("110228", "d003", "1992-03-21", "9999-01-01");

insert into departments_dup
values ("d009", "Customer Service");

select * from dept_manager_dup
 order by dept_no ASC;
 
 select * from departments_dup
 order by dept_no ASC;
 
 #when 2 tables have duplicate records it changes the inner join
 select m.dept_no, m.emp_no, d.dept_name 
from dept_manager_dup m
inner join departments_dup d
on m.dept_no = d.dept_no
order by m.dept_no;

#to eliminate duplicate values use group by
select m.dept_no, m.emp_no, d.dept_name 
from dept_manager_dup m
join departments_dup d on m.dept_no = d.dept_no
group by m.dept_no, m.emp_no, d.dept_name
order by dept_no;

delete from dept_manager_dup where emp_no = "110228";

delete from departments_dup where dept_no = "d009";

insert into dept_manager_dup
values ("110228", "d003", "1992-03-21", "9999-01-01");

insert into departments_dup
values ("d009", "Customer Service");

#left join
select m.dept_no, m.emp_no, d.dept_name 
from dept_manager_dup m
	left join departments_dup d on m.dept_no = d.dept_no
order by dept_no;

select d.dept_no, m.emp_no, d.dept_name 
from departments_dup d
	left join dept_manager_dup m on m.dept_no = d.dept_no
order by dept_no;

#to have the difference use where with left join
select m.dept_no, m.emp_no, d.dept_name 
from dept_manager_dup m
	left join departments_dup d on m.dept_no = d.dept_no
    where d.dept_name is null
order by dept_no;

#Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch.
select e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
from employees e 
left join dept_manager d on e.emp_no = d.emp_no
where last_name = 'Markovitch'
order by d.dept_no, e.emp_no desc;

#See if the output contains a manager with that name.  
select e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
from employees e 
left join dept_manager d on e.emp_no = d.emp_no
where e.last_name = 'Markovitch' and d.dept_no is not null
order by d.dept_no, e.emp_no desc;

#right join
select m.dept_no, m.emp_no, d.dept_name 
from departments_dup d
	right join dept_manager_dup m on m.dept_no = d.dept_no
order by dept_no;

select d.dept_no, m.emp_no, d.dept_name 
from dept_manager_dup m
	right join departments_dup d on m.dept_no = d.dept_no
order by dept_no;

#Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. Use the old type of join syntax to obtain the result.

select d.emp_no, d.dept_no, e.first_name, e.last_name, e.hire_date
from dept_manager d, employees e
where d.emp_no = e.emp_no;

#same result with join
select d.emp_no, d.dept_no, e.first_name, e.last_name, e.hire_date
from dept_manager d
join employees e on d.emp_no = e.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

#Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.

select e.first_name, e.last_name, e.hire_date, t.title
from employees e
join titles t on e.emp_no = t.emp_no
where e.first_name = "Margareta" and e.last_name = "Markovitch"
order by e.last_name;

#Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.

select dm.*, d.*
from dept_manager dm cross join departments d
where d.dept_no = "d009"
order by d.dept_name;

#Return a list with the first 10 employees with all the departments they can be assigned to.

select e.*, d.*
from employees e cross join departments d
where e.emp_no < "10011"
order by e.emp_no, d.dept_no;

#Select all managers’ first and last name, hire date, job title, start date, and department name.

select e.first_name, e.last_name, t.title, t.from_date, d.dept_no

from employees e join titles t on e.emp_no = t.emp_no

join dept_manager dm on t.emp_no = dm.emp_no

join departments d on dm.dept_no = d.dept_no
WHERE t.title = 'Manager';

#How many male and how many female managers do we have in the ‘employees’ database?
select e.gender, count(dm.emp_no) as nb_of_emp
from employees e
join dept_manager dm on e.emp_no = dm.emp_no
group by gender;

SELECT *
FROM
    (SELECT e.emp_no, e.first_name, e.last_name, NULL AS dept_no, NULL AS from_date
    FROM employees e
    WHERE last_name = 'Denis' UNION SELECT
	NULL AS emp_no,NULL AS first_name, NULL AS last_name, dm.dept_no, dm.from_date
	FROM dept_manager dm) as a
ORDER BY -a.emp_no DESC;

SELECT e.emp_no, e.first_name, e.last_name, NULL AS dept_no, NULL AS from_date
    FROM employees e
    WHERE last_name = 'Denis' UNION SELECT
	NULL AS emp_no,NULL AS first_name, NULL AS last_name, dm.dept_no, dm.from_date
	FROM dept_manager dm;
    
    SELECT *
FROM
    (SELECT e.emp_no, e.first_name, e.last_name, NULL AS dept_no, NULL AS from_date
    FROM employees e
    WHERE last_name = 'Denis' UNION SELECT
	NULL AS emp_no,NULL AS first_name, NULL AS last_name, dm.dept_no, dm.from_date
	FROM dept_manager dm) as a;
    
    #Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
    select * from dept_manager d
    where d.emp_no in 
    (select e.emp_no from employees e 
    where e.hire_date < "1995-01-01" and e.hire_date > "1990-01-01");	
    
    #Select the entire information for all employees whose job title is “Assistant Engineer”. 
    
    select * from employees 
    where emp_no in 
    (select emp_no from titles where title = "Assistant Engineer");
    
    select * from employees e
    where exists
    (select * from titles t where t.emp_no = e.emp_no and title = "Assistant Engineer");
    


    

    
#assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A)
select A.* 
from 
	(select e.emp_no as employee_ID, min(de.dept_no),(select emp_no from employees where emp_no = "110022") as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no <= "10020"
    group by e.emp_no
    order by e.emp_no) as A;
    
#employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).
 select B.* 
from 
	(select e.emp_no as employee_ID, min(de.dept_no),(select emp_no from employees where emp_no = "110039") as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no >= "10021" and e.emp_no <= "10040"
    group by e.emp_no
    order by e.emp_no) as B;   

#Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.
select C.* 
from 
	(select e.emp_no as employee_ID, min(de.dept_no),(select emp_no from employees where emp_no = "110039") as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no = "110022"
    group by e.emp_no
    order by e.emp_no) as C;

#create subset D. Here you must do the opposite - assign employee 110022 as a manager to employee 110039.

select D.* 
from 
	(select e.emp_no as employee_ID, min(de.dept_no),(select emp_no from employees where emp_no = "110022") as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no = "110039"
    group by e.emp_no
    order by e.emp_no) as D;
    
select U.*
from 
	(select A.* 
	from 
	(select e.emp_no as employee_ID, min(de.dept_no),(select emp_no from dept_manager where emp_no = "110022") as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no <= "10020"
    group by e.emp_no
    order by e.emp_no) as A
    
    union select B.* 
	from 
	(select e.emp_no as employee_ID, min(de.dept_no),(select emp_no from dept_manager where emp_no = "110039") as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no >= "10021" and e.emp_no <= "10040"
    group by e.emp_no
    order by e.emp_no) as B
    
    union select C.* 
	from 
	(select e.emp_no as employee_ID, min(de.dept_no),(select emp_no from dept_manager where emp_no = "110039") as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no = "110022"
    group by e.emp_no
    order by e.emp_no) as C
    
    union select D.* 
	from 
	(select e.emp_no as employee_ID, min(de.dept_no),(select emp_no from dept_manager where emp_no = "110022") as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no = "110039"
    group by e.emp_no
    order by e.emp_no) as D) as U;

 
 