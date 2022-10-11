# Module7 Challenge - Silver Tsunami

## Overview
Many employees will be retiring from Pewlett Hackard in next few years. The managers need to prepare for the **silver tsunami**. The purpose of this technical analysis is to determine the number of retiring employees per title and identify employees who are eligible to participate in a mentorship program offered by Pewlett Hackard.

The technical analysis report primarily answers the following questions:
1. The Number of Retiring Employees by Title
2. The Employees Eligible for the Mentorship Program

In addition, the report covers the following: 
- The roles need to be filled as the "silver tsunami" begins
- The number of qualified, retirement-ready employees in each department to mentor the next generation of Pewlett Hackard employees

## Results
The technical analysis involved four major steps. The result from each step is shown below.

### Step 1: Create Retirement Title Table
In this step, employee information was pulled from 2 different tables based on their birth dates. The details such as **Employee Number, First Name, Last Name, Title, and From and To Date** of the employee holding the Title were pulled after joining the **Employee** and **Title** tables. The result was filtered on **Birth Date** to retrieve only the employees who were born between 1952 and 1955.

The query used to retrieve data from the Employees and Title tables is shown below:
    
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

The SQL query used to retrieve data from the **Retirement Titles** table is shown below:

    SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
    INTO unique_titles
    FROM retirement_titles
    WHERE to_date = '9999-01-01'
    ORDER BY emp_no, to_date DESC;

**Result Stored in Unique Titles Table**

![image](https://user-images.githubusercontent.com/31812730/194647915-d81ec7a8-f946-4a86-ae10-3eda5c4d6866.png)

### Step 3: Create Retiring Titles Table
In this step, **Unique Titles** table was queried to count the number of employees by their most recent job title who are about to retire. The employee count was retrieved by grouping the table by title and sorting the count in descending order.

The SQL query used to retrieve data from the **Unique Titles** table is shown below:

    SELECT COUNT(title), title
    INTO retiring_titles
    FROM unique_titles
    GROUP BY title
    ORDER BY COUNT DESC
    
**Result Stored in Unique Titles Table**
![image](https://user-images.githubusercontent.com/31812730/194464970-14a3c62b-e2f1-450f-acec-c33885b0578b.png)

### Step 4: Create Mentorship Eligibility Table
In this step, data was extracted from 3 different tables to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program. Employees, Department Employee and Titles tables were joined to extract **Employee Number, First Name, Last Name, Birth Date, and From and To Date** of the employee holding the Title details. **DISTINCT ON** statement was used to retrieve the details of first occurrence of the employee number for each set.

The SQL query used to retrieve data from the **Mentorship Eligibility** table is shown below:

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

**Result Stored in Mentorship Eligibility Table**

![image](https://user-images.githubusercontent.com/31812730/194465157-605ad31e-3a35-4898-95ed-ee334ec054a8.png)

## Summary
As How many roles will need to be filled as the "silver tsunami" begins to make an impact?

The data suggests that "sliver tsunami" will have a major impact on the organization as quite a few people will begin to retire. The organization has set couple of criterions to determine which employees will be retiring. 

**Roles to be Filled**

Based on those criterions, an employee will begin to retire if following conditions are satisfied:
1. Anyone born between 1952 and 1955. 
2. They are currently employed with the organization.

There are 90,398 employees born between 1952 and 1955. Out of these employees, **72,458** employees are currently employed and will begin to retire. The employee count by role is shown in step 3 under results. 

Further, **Retirement Titles, Departments, and Department Employee** tables were joined to create a new table **Roles to Fill** to store the department information for each retiring employee. 

![image](https://user-images.githubusercontent.com/31812730/194779824-37396739-b4fb-4f61-a5a2-e0a767785af7.png)

From the new table, retiring role name and count of retiring roles for each department was extracted and stored in another new table **Roles to Fill Summary**.

Extract from **Roles to Fill Summary** is shown below:

![image](https://user-images.githubusercontent.com/31812730/194779224-47d4386e-be79-4c94-88a8-e9230bc53364.png)

This retiring role information by department will help the managers of each department to plan ahead and be prepared to execute the plan as the **silver tsunami** begins to make an impact.   

**Mentor the Next Generation**

The employee count by role shown in step 3 under results, shows that there are enough qualified employees who are retirement-ready, and organization can use them as mentors. For instance, there are 25,916 senior engineers, 24,926 senior staffs, 3.603 technical leaders and 2 managers who are retirement ready. These people are experienced and can be used as mentors.

A new table was created retrieving data from the **Roles to Fill** table showing count of qualified mentors by department. 

![image](https://user-images.githubusercontent.com/31812730/194795415-136c9ad1-720c-481e-b3fd-613debabd65d.png)
 
A closure look at the table shown above confirms that there are enough qualified, retirement-ready employees in the departments to mentor the next generation of employees. 






 
