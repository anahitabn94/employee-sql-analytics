USE employees;

-- Turnover analysis: tenure, active vs left employees by dept and gender
WITH emp_tenure AS (
    SELECT
        e.emp_no,
        d.dept_name,
        e.gender,
        de.from_date AS start_date,
        de.to_date AS end_date,
        CASE
            WHEN de.to_date = '9999-01-01' THEN DATEDIFF(CURDATE(), de.from_date)
            ELSE DATEDIFF(de.to_date, de.from_date)
        END AS tenure_days,
        CASE
            WHEN de.to_date = '9999-01-01' THEN 'Active'
            ELSE 'Left'
        END AS status
    FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d ON de.dept_no = d.dept_no
)

SELECT
    dept_name,
	status,
    gender,
    COUNT(*) AS employee_count,
    ROUND(AVG(tenure_days) / 365, 0) AS avg_tenure_years
FROM emp_tenure
GROUP BY dept_name, status, gender
ORDER BY dept_name, status, gender;
