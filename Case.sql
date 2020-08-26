select emp_no, first_name, last_name,
case 
	when gender = "M" then "MALE"
    else "FEMALE"
    end as gender
from employees;

select emp_no, first_name, last_name,
case gender
	when "M" then "MALE"
    else "FEMALE"
    end as gender
from employees;

select emp_no, first_name, last_name,
	if(gender = "M", "Male", "Female") as gender
from employees;

select e.emp_no, e.first_name, e.last_name,
case 
	when dm.emp_no is not null then "Manager"
    else "Employee"
    end as is_manager
from employees e
	left join dept_manager dm on dm.emp_no = e.emp_no
where e.emp_no > "109990";

#obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. Create a fourth column in the query, indicating whether this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee. 

select e.emp_no, e.first_name, e.last_name,
case 
	when dm.emp_no is not null then "Manager"
    else "Employee"
    end as is_manager
from employees e
	left join dept_manager dm on dm.emp_no = e.emp_no
where e.emp_no > "109990";

#Extract a dataset containing the following information about the managers: employee number, first name, and last name. Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, and another one saying whether this salary raise was higher than $30,000 or NOT.

select dm.emp_no, e.first_name, e.last_name, max(s.salary) - min(s.salary) as difference_min_max,
if(max(s.salary) - min(s.salary) > 30000, "Raise was higher than 30.000", "not") as salary_raise
from dept_manager dm 
	join employees e on dm.emp_no = e.emp_no
		join salaries s on dm.emp_no = s.emp_no
group by s.emp_no;

select dm.emp_no, e.first_name, e.last_name, max(s.salary) - min(s.salary) as difference_min_max,
	case 
		when max(s.salary) - min(s.salary) > 30000 then "Raise was higher than 30.000"
        else "not"
	end as salary_raise	
from dept_manager dm 
	join employees e on dm.emp_no = e.emp_no
		join salaries s on dm.emp_no = s.emp_no
group by s.emp_no;

#Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, called “current_employee” saying “Is still employed” if the employee is still working in the company, or “Not an employee anymore” if they aren’t.

select e.emp_no, e.first_name, e.last_name,
	if(MAX(d.to_date) > SYSDATE(), "is still employed", "not an employee anymore") as current_employee
from employees e join dept_emp d on e.emp_no = d.emp_no
GROUP BY d.emp_no
limit 100;

select e.emp_no, e.first_name, e.last_name,
CASE
WHEN MAX(d.to_date) > SYSDATE() THEN 'Is still employed'
ELSE 'Not an employee anymore'
END AS current_employee
from employees e join dept_emp d on e.emp_no = d.emp_no
GROUP BY d.emp_no
limit 100;



