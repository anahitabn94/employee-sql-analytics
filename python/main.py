import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

# Connect to MySQL
conn = mysql.connector.connect(
    host="",
    user="",
    password="",
    database="employees"
)

# Query
query = "SELECT YEAR(hire_date) AS year, COUNT(*) AS hires FROM employees GROUP BY year ORDER BY year;"
df = pd.read_sql(query, conn)

df.to_csv('../exports/employee_hire_over_time.csv', index=False)

# Plot
plt.figure(figsize=(10,6))
plt.plot(df['year'], df['hires'], marker='o')
plt.title('Employee Hires Over Time')
plt.xlabel('Year')
plt.ylabel('Number of Hires')
plt.grid(True)
plt.savefig("../visuals/employee_hire_over_time.pdf")

conn.close()
