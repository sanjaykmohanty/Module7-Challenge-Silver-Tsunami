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