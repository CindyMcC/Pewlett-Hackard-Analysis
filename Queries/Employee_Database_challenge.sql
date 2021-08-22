-- create table with all current and previous employees born between 1952 and 1955
SELECT e.emp_no, 
e.first_name, 
e.last_name, 
t.title, 
t.from_date, 
t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- create a table of titles by filtering the retirement_titles table
SELECT DISTINCT ON (rt.emp_no) 
rt.emp_no, 
rt.first_name, 
rt.last_name, 
rt.title 
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no, to_date DESC;

-- create a table to show the count of titles from the retirement_titles table
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
Group By title
ORDER BY COUNT DESC

-- create a table of potential mentors from current employees
SELECT DISTINCT ON(em.emp_no) 
em.emp_no, 
em.first_name, 
em.last_name, 
em.birth_date, 
de.from_date, 
de.to_date, 
tl.title
INTO mentorship_eligibilty
FROM employees AS em
LEFT OUTER JOIN dept_emp as de on em.emp_no = de.emp_no
LEFT OUTER JOIN titles as tl on em.emp_no = tl.emp_no and tl.to_date = '9999-01-01'
WHERE de.to_date = '9999-01-01'
AND em.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY em.emp_no
