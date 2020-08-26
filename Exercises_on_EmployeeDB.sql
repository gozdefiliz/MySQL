
SELECT 
    first_name, last_name
FROM
    employees;
    
    SELECT 
    *
FROM
    employees;
    
    /*Select the information from the “dept_no” column of the “departments” table.*/
    
    SELECT 
    dept_no
FROM
    departments;
    
    /*Select all data from the “departments” table.*/
    SELECT 
    *
FROM
    departments;
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
    #Select all people from the “employees” table whose first name is “Elvis”.
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';
    
    #Retrieve a list with all female employees whose first name is Kellie. 
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis'
        OR first_name = 'Denis';
        
#Retrieve a list with all employees whose first name is either Kellie or Aruna.
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna';
        
#Retrieve a list with all female employees whose first name is either Kellie or Aruna.

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');
        
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Cathie'
        OR first_name = 'Mark'
        OR first_name = 'Nathan';
#in is quicker
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'Nathan', 'Mark');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie' , 'Nathan', 'Mark');
    
#Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”.

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Elvis' , 'Denis');
    
#Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
    
select * from employees where first_name like ("Mar%");

select * from employees where first_name like ("ar%");

select * from employees where first_name like ("%ar");

select * from employees where first_name like ("%ar%");

select * from employees where first_name like ("Mar_");

select * from employees where first_name not like ("%Mar%");

#select the data about all individuals, whose first name starts with “Mark”;

select * from employees where first_name like ("mark%");

#Retrieve a list with all employees who have been hired in the year 2000.

select * from employees where hire_date like ("%2000%");

#Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. 

select * from employees where emp_no like ("_____") and emp_no like ("1000%");

select * from employees where emp_no like ("1000_");

#Extract all individuals from the ‘employees’ table whose first name contains “Jack”.

select * from employees where first_name like ("%jack%");

#extract another list containing the names of employees that do not contain “Jack”.

select * from employees where first_name not like ("%jack%");

select * from employees where hire_date between "1990-01-01" and "2000-01-01";

select * from employees where hire_date not between "1990-01-01" and "2000-01-01";

#Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.

select * from salaries where salary between "66000" and "70000";

#Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.

select * from employees where emp_no not between "10004" and "10012";

#Select the names of all departments with numbers between ‘d003’ and ‘d006’.

select * from departments where dept_no between "d003" and "d006";

select * from employees where first_name is not null;

select * from employees where first_name is null;

#Select the names of all departments whose department number value is not null.
select * from departments where dept_no is not null;

select * from employees where first_name != "Mark";

select * from employees where hire_date > "2000-01-01";

select * from employees where hire_date >= "2000-01-01";

select * from employees where hire_date < "1985-02-01";

select * from employees where hire_date <= "1985-02-01";

#Retrieve a list with data about all female employees who were hired in the year 2000 or after.

select * from employees where gender = "F" and hire_date >= "2000-01-01";

#Extract a list with all employees’ salaries higher than $150,000 per annum.

select * from salaries where salary > "150000";

select gender from employees;

select distinct gender from employees;

#Obtain a list with all different “hire dates” from the “employees” table.
select distinct hire_date from employees;

#how many employees are registered in the db (emp_no is PK)
select count(emp_no) from employees;

#another way to check null values
select count(first_name) from employees;

#how many different names can be found in the employees table 

select count(distinct first_name) from employees;

#How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?

select count(salary) from salaries where salary >= "100000";

select count(*) from salaries where salary >= "100000";

#How many managers do we have in the “employees” database? 

select count(emp_no) from dept_manager;

select count(*) from dept_manager;

select * from employees order by first_name;

select * from employees order by first_name DESC;

select * from employees order by emp_no DESC;

select * from employees order by first_name, last_name;

#Select all data from the “employees” table, ordering it by “hire date” in descending order.

select * from employees order by hire_date DESC;

select first_name from employees;

select first_name from employees group by first_name;

select distinct first_name from employees;

select count(first_name) from employees group by first_name;

select first_name, count(first_name) from employees group by first_name order by first_name;

select first_name, count(first_name) as names_count from employees group by first_name order by first_name;

#Write a query that obtains an output whose first column must contain annual salaries higher than 80,000 dollars. The second column, renamed to “emps_with_same_salary”, must show the number of employee contracts signed with this salary.

select salary, count(salary) as emps_with_same_salary from salaries where salary > "80000" group by salary order by salary;

select salary, count(emp_no) as emps_with_same_salary from salaries where salary > "80000" group by salary order by salary;

select * from employees having hire_date >= "2000-01-01";

select first_name, count(first_name) as names_count from employees where count(first_name) > 250 group by first_name order by first_name;

select first_name, count(first_name) as names_count from employees group by first_name having count(first_name) > 250 order by first_name;

#Select all employees whose average salary is higher than $120,000 per annum.
SELECT

    emp_no, AVG(salary)

FROM

    salaries

GROUP BY emp_no

HAVING AVG(salary) > 120000

ORDER BY emp_no;

#extract a list of all names that are encountered less than 200 times. let the data refer to people hired after 1999-01-01

select first_name, count(first_name) as names_count from employees where hire_date > "1999-01-01" group by first_name having count(first_name) < 200 order by first_name;

#Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.

select emp_no, count(from_date) as number_of_contracts from dept_emp where from_date > "2000-01-01" group by emp_no having count(from_date) > 1 order by emp_no;

#employee numbers of the 10 highest paid employees in the database

select * from salaries order by salary desc limit 10;

#Select the first 100 rows from the ‘dept_emp’ table. 

select * from dept_emp limit 100;

#How many departments are there in the “employees” database?

select count(dept_no) from departments;

select count(distinct dept_no) from dept_emp;

#What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?

select sum(salary) from salaries where from_date > "1997-01-01";

#Which is the lowest employee number in the database?

select min(emp_no) from employees;

#Which is the highest employee number in the database?

select max(emp_no) from employees;

#What is the average annual salary paid to employees who started after the 1st of January 1997?

select avg(salary) from salaries where from_date > "1997-01-01";

#Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents.

select round(avg(salary),2) from salaries where from_date > "1997-01-01";

select round(avg(salary)) from salaries where from_date > "1997-01-01";






    



    
    