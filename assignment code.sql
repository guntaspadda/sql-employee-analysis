------------ Data Engineering-------------
--Create tables
CREATE TABLE departments(
    dept_no varchar NOT NULL PRIMARY KEY,
    dept_name varchar);
    
CREATE TABLE employees(
    emp_no varchar NOT NULL PRIMARY KEY,
    emp_title_id varchar,
    birth_date date,
    first_name varchar,
    last_name varchar,
    sex char(1),
    hire_date date);
    
CREATE TABLE dept_emp(
    emp_no varchar NOT NULL,
    dept_no varchar,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    PRIMARY KEY (emp_no, dept_no));
    
CREATE TABLE dept_manager(
    dept_no varchar NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    emp_no varchar,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    PRIMARY KEY (dept_no, emp_no));
    
CREATE TABLE salaries(
    emp_no varchar NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    salary int,
    PRIMARY KEY (emp_no, salary));
    
CREATE TABLE titles(
    title_id varchar NOT NULL PRIMARY KEY,
    title varchar);
    
-- Import CSV files into corresponding tables   
-- Verify successful imports

SELECT * FROM departments

SELECT * FROM dept_emp

SELECT * FROM dept_manager

SELECT * FROM employees

SELECT * FROM salaries

SELECT * FROM titles
    

------------ Data Analysis-------------
-- List the employee number, last name, first name, sex, and salary of each employee
SELECT employees.emp_no,
employees.last_name,
employees.first_name,
employees.sex,
salaries.salary
FROM employees
INNER JOIN salaries ON 
salaries.emp_no = employees.emp_no

-- List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '19860101' AND '19861231'

-- List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT dept_manager.dept_no,
departments.dept_name,
employees.emp_no,
employees.first_name,
employees.last_name
FROM employees
INNER JOIN dept_manager ON
dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_manager.dept_no

-- List the department number for each employee along with that employee's employee number, last name, first name, and department name
SELECT employees.emp_no,
employees.first_name,
employees.last_name,
dept_emp.dept_no,
departments.dept_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%'

-- List each employee in the sales department, including their employee number, last name, and first name
SELECT employees.emp_no,
employees.first_name,
employees.last_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no = 'd007'

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT employees.emp_no,
employees.first_name,
employees.last_name,
departments.dept_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
WHERE dept_emp.dept_no = 'd007'
OR dept_emp.dept_no = 'd005'

-- List the frequency counts, in descending order, of all the employee last names
SELECT last_name, COUNT (last_name) AS count
FROM employees
GROUP BY last_name
ORDER BY count DESC



































