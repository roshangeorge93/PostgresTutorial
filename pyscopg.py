import psycopg2

DB_NAME = "postgres"
DB_USER = "postgres"
DB_PASS = "password"
DB_HOST = "localhost"
DB_PORT = "5432"

conn = psycopg2.connect(database=DB_NAME,
						user=DB_USER,
						password=DB_PASS,
						host=DB_HOST,
						port=DB_PORT)
print("Database connected successfully")

cur = conn.cursor()
cur.execute("SELECT employees.employee_name,contact_details.number from employees inner join contact_details on contact_details.emp_id=employees.employee_id and employees.employee_name='e1'")
rows = cur.fetchall()
print(rows)
for data in rows:
	print("Name :" + str(data[0]))
	print("number :" + str(data[1]))
	

print('Data fetched successfully')
conn.close()
