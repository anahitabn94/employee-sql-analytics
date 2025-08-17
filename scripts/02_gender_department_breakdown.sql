USE employees;

-- Count employees by department and gender
SELECT
    d.dept_name,
    e.gender,
    COUNT(*) AS employee_count
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name, e.gender
ORDER BY d.dept_name, e.gender;
