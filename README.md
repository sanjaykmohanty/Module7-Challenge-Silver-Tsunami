# Module7 Challenge - Silver Tsunami

## Overview
A large number of employees will be retiring from Pewlett Hackard in next few years. The managers need to prepare for the **siver tsunami**. The purpose of this technical analysis is to determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program offered by Pewlett Hackard.

The technical analysis report primarily answers the following questions:
1. The Number of Retiring Employees by Title
2. The Employees Eligible for the Mentorship Program

In addition, the report covers the following: 
- The roles need to be filled as the "silver tsunami" begins
- The number of qualified, retirement-ready employees in each department to mentor the next generation of Pewlett Hackard employees

## Results
The technical analysis involved four major steps. The resullts from each step is shown below.

### Step 1: Create Retirement_Title Table
In this step, employee information was pulled from 2 different tables based on their birth dates. The details such as **Employee Number, First Name, Last Name, Title, and From and To Date** of the employee holding the Title were pulled after joining the **Employee** and **Title** tables. The result was filtered on **Birth Date** to retrieve only the employees who were born between 1952 and 1955.

The query used to retieve data from the Employees and Title tables is shown below:
    
    SELECT E.emp_no, E.first_name, E.last_name, T.title, T.from_date, T.to_date   
    INTO retirement_titles  
    FROM employees  
    JOIN titles T    
    ON E.emp_no = T.emp_no    
    AND E.birth_date BETWEEN '1952-01-01' AND '1955-12-31'    
    ORDER BY E.emp_no;  

**Result Stored in Retirement_Titles Table**

![image](https://user-images.githubusercontent.com/31812730/194619030-11c9e507-0209-488d-887c-386d066b93b0.png)

### Step 2: Create Unique Titles Table
The data extracted in the previous step has a lot of duplicate entries for some employees because they have switched titles over the years. In this step, using the **DISTINCT ON** statement, all the duplicates extracted from the **Retirement Titles** table were removed and only the most recent title of each employee is stored in the **Unique Title** table. The result was filtered to retrieve only the employees who are currently employed.   

The SQL query used to retieve data from the **Retirement Titles** table is shown below:

    SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
    INTO unique_titles
    FROM retirement_titles
    WHERE to_date = '9999-01-01'
    ORDER BY emp_no, to_date DESC;

**Result Stored in Unique Titles Table**

![image](https://user-images.githubusercontent.com/31812730/194647915-d81ec7a8-f946-4a86-ae10-3eda5c4d6866.png)

### Step 3: Create Retiring Titles Table
In this step, **Unique Titles** table was queried to count the number of employees by their most recent job title who are about to retire. The employee count was retrieved by groupng the table by title and sorting the count in descending order.

The SQL query used to retieve data from the **Unique Titles** table is shown below:

    SELECT COUNT(title), title
    INTO retiring_titles
    FROM unique_titles
    GROUP BY title
    ORDER BY COUNT DESC
    
**Result Stored in Unique Titles Table**
![image](https://user-images.githubusercontent.com/31812730/194464970-14a3c62b-e2f1-450f-acec-c33885b0578b.png)

### Step 4: Create Mentorship Eligibility Table
In this step, data extracted from 3 different tables to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
###############??????????????#######???????????? - add stuff here


The SQL query used to retieve data from the **Unique Titles** table is shown below:

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

**Result Stored in Mentorship Eligibilty  Table**

![image](https://user-images.githubusercontent.com/31812730/194465157-605ad31e-3a35-4898-95ed-ee334ec054a8.png)

## Summary
