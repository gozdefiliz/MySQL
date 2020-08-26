
use employees;

drop procedure if exists select_employees;

DELIMITER $$
create procedure select_employees()
	begin 
		select * from employees
        limit 1000;
    end $$
    
DELIMITER ;

call employees.select_employees();

#we already said it to use employees
call select_employees();

#Create a procedure that will provide the average salary of all employees.

use employees;
drop procedure if exists average_salary;

delimiter $$

create procedure average_salary()
	begin
    select avg(salary) from salaries;
    end $$

delimiter ;

call employees.average_salary();

use employees;
drop procedure if exists emp_salary;

delimiter $$
create procedure emp_salary(in p_emp_no integer)
	begin
		select e.first_name, e.last_name, s.salary, s.from_date, s.to_date
        from employees e
        join salaries s on e.emp_no = s.emp_no
        where e.emp_no = p_emp_no
    ;
    end $$
delimiter ;

call employees.emp_salary(11300);


use employees;
drop procedure if exists emp_avg_salary;

delimiter $$
create procedure emp_avg_salary(in p_emp_no integer)
	begin
		select e.first_name, e.last_name, avg(s.salary) as average_salary
        from employees e
        join salaries s on e.emp_no = s.emp_no
        where e.emp_no = p_emp_no
    ;
    end $$
delimiter ;

call employees.emp_avg_salary(11300);

use employees;
drop procedure if exists emp_avg_salary_out;

delimiter $$
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
	begin
		select avg(s.salary)
        into p_avg_salary
        from employees e
        join salaries s on e.emp_no = s.emp_no
        where e.emp_no = p_emp_no
    ;
    end $$
delimiter ;


#Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.
use employees;
drop procedure if exists emp_info;

delimiter $$
create procedure emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
	begin
		select emp_no
        into p_emp_no
        from employees e
        where e.first_name = p_first_name and e.last_name = p_last_name
    ;
    end $$
delimiter ;


set @v_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;

#Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.
set @v_emp_no = 0;
call employees.emp_info("Aruna", "Journel", @v_emp_no);
select @v_emp_no;

use employees;
drop function if exists f_emp_avg_salary;

delimiter $$
create function f_emp_avg_salary (p_emp_no integer) returns decimal(10,2)
deterministic
begin
declare v_avg_salary decimal(10,2);
select avg(salary) into v_avg_salary
	from employees e
    join salaries s on e.emp_no = s.emp_no
    where e.emp_no = p_emp_no;
    return v_avg_salary;
end $$
delimiter ;

select f_emp_avg_salary(11300);

#Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee.

use employees;
drop function if exists emp_info;


DELIMITER $$

CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
deterministic
BEGIN

                DECLARE v_max_from_date date;

    DECLARE v_salary decimal(10,2);

                SELECT

    MAX(from_date)

INTO v_max_from_date FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name;

                SELECT

    s.salary

INTO v_salary FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name

        AND s.from_date = v_max_from_date;

           

                RETURN v_salary;

END$$

DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');


