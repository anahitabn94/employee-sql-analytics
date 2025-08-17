USE employees;

-- View: Employee count by department and gender
CREATE OR REPLACE VIEW view_gender_dept AS
SELECT
    d.dept_name,
    e.gender,
    COUNT(*) AS employee_count
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name, e.gender;

-- View: Average salary by department and title
CREATE OR REPLACE VIEW view_avg_salary_dept_title AS
SELECT
    d.dept_name,
    t.title,
    ROUND(AVG(s.salary), 0) AS avg_salary
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
JOIN titles t ON e.emp_no = t.emp_no
-- Filter latest salary and title for each employee
WHERE s.to_date = '9999-01-01'
  AND t.to_date = '9999-01-01'
GROUP BY d.dept_name, t.title;

-- View: Turnover summary by department and gender
CREATE OR REPLACE VIEW view_turnover_summary AS
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
GROUP BY dept_name, status, gender;
