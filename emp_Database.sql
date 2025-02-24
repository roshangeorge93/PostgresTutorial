employee, Department  and Location

Department:
    d_id:varchar
    d_name:varchar
    l_id:int (Fk)
Employee:
    eid:varchar
    e_name:varchar
    email:varchar
    designation:varchar
    salary:real
    experience:small int
    d_id:int (FK)

location:
    l_id:int
    l_name :varchar
    l_city: varchar
    l_state :varchar
    l_country :varchar


---------creating table

create table Location(
l_id  SERIAL PRIMARY KEY,
l_name varchar,
l_city varchar,
l_state varchar,
l_country varchar

);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100),
    l_id int,
     CONSTRAINT fk_location FOREIGN KEY (l_id) 
    REFERENCES LOCATION(l_id)
);


CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    email varchar,
    designation varchar,
    salary real,
    department_id INT,
    experience smallint,
      
    CONSTRAINT fk_department FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);


CREATE TABLE CONTACT_DETAILS(
number int UNIQUE,
address varchar,
emp_id int,
FOREIGN KEY (emp_id) REFERENCES employees(employee_id)

);
-- list all the employess with contatc number
select employees.employee_name,contact_details.number 
from employees left join contact_details 
on contact_details.emp_id=employees.employee_id ;

-- list all the contact number of particular employeee 
SELECT employees.employee_name,contact_details.number from employees inner join contact_details on 
contact_details.emp_id=employees.employee_id and employees.employee_name='e1'

--list all emp given a contact number

select  employees.employee_name,contact_details.number from employees inner join contact_details on 
contact_details.emp_id=employees.employee_id and contact_details.number=789

SELECT employees.employee_id,employees.employee_name,employees.email,employees.designation,employees.salary,employees.department_id,employees.experience , departments.department_name 
FROM employees  INNER JOIN departments 
on departments.department_id=employees.department_id


SELECT 
employees.employee_id,employees.employee_name,employees.email,departments.department_name ,location.l_city || '_' || location.l_state|| '_'||location.l_country AS city_state_country 
FROM employees INNER JOIN departments on departments.department_id=employees.department_id 
INNER JOIN location on location.l_id=departments.l_id
