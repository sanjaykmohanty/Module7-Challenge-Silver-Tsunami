-- Create retirement_titles table extracting data from employees and titles tables
SELECT E.emp_no, E.first_name, E.last_name, T.title, T.from_date, T.to_date
INTO retirement_titles
FROM employees E
JOIN titles T
ON E.emp_no = T.emp_no
AND E.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY E.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Retrieve number of employees by most recent job title from unique_titles 
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC

-- Create Mentorship Eligibility table holds employees eligible for mentorship program
SELECT DISTINCT ON(E.emp_no) E.emp_no, E.first_name, E.last_name, E.birth_date,
				   DE.from_date, DE.to_date, T.title
INTO mentorship_eligibilty
FROM employees E
JOIN dept_emp DE
ON E.emp_no = DE.emp_no
JOIN titles T
ON E.emp_no = T.emp_no
AND DE.to_date = '9999-01-01'
AND E.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER By E.emp_no;

-- Create Roles to Fill table to store department information for each employee 
SELECT DISTINCT ON (RT.emp_no) RT.emp_no, RT.first_name, RT.last_name, RT.title, D.dept_name
INTO roles_to_fill
FROM retirement_titles AS RT 
JOIN dept_emp DE
ON (DE.emp_no = RT.emp_no)
JOIN departments D
ON (D.dept_no = DE.dept_no)
WHERE RT.to_date = '9999-01-01'
ORDER BY RT.emp_no, title, dept_name;

-- Create Roles to Fill Summary table to store retiring roles and count of retiring roles for each department 
SELECT RF.dept_name, RF.title, COUNT(RF.title) AS title_count 
INTO roles_to_fill_summary
FROM (SELECT title, dept_name from roles_to_fill) as RF
GROUP BY RF.dept_name, RF.title
ORDER BY RF.dept_name, RF.title, title_count;

-- Create Mentor by Department table to store potential mentor count by department 
SELECT RF.dept_name, RF.title, COUNT(RF.title) 
INTO mentor_by_dept
FROM (SELECT title, dept_name from roles_to_fill) as RF
WHERE RF.title IN ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager')
GROUP BY RF.dept_name, RF.title
ORDER BY RF.dept_name, RF.title, count;
