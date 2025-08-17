USE employees;

-- Average salary by department and title
SELECT
    d.dept_name,
    t.title,
    ROUND(AVG(s.salary), 0) AS avg_salary
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
JOIN titles t ON e.emp_no = t.emp_no
WHERE s.to_date = '9999-01-01'
  AND t.to_date = '9999-01-01'
GROUP BY d.dept_name, t.title
ORDER BY d.dept_name, avg_salary DESC;

