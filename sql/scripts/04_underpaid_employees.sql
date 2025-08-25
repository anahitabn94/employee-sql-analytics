USE employees;

WITH salary_data AS (
    SELECT
        e.emp_no,
        CONCAT(e.first_name, ' ', e.last_name) AS full_name,
        d.dept_name,
        t.title,
        s.salary,
        ROW_NUMBER() OVER (ORDER BY s.salary) AS rn_asc,
        COUNT(*) OVER () AS total_count
    FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d ON de.dept_no = d.dept_no
    JOIN titles t ON e.emp_no = t.emp_no
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE s.to_date = '9999-01-01'
      AND t.to_date = '9999-01-01'
),
median_salary_cte AS (
    SELECT
        AVG(salary) AS median_salary
    FROM salary_data
    WHERE
        rn_asc = FLOOR((total_count + 1) / 2)
        OR rn_asc = CEIL((total_count + 1) / 2)
)

SELECT
    sd.full_name,
    sd.dept_name,
    sd.title,
    sd.salary,
    ms.median_salary
FROM salary_data sd
CROSS JOIN median_salary_cte ms
WHERE sd.salary < ms.median_salary
ORDER BY sd.dept_name, sd.title, sd.salary;
