USE employees;

-- Number of employees hired each year
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(*) AS hires
FROM employees
GROUP BY hire_year
ORDER BY hire_year;
