-- creating department table

CREATE TABLE Department(
   d_id VARCHAR,
   d_name  VARCHAR,
   PRIMARY KEY(d_id)
);
-------------------------------------------------------------------------------------------------
-- creating employee table

CREATE TABLE Employee(
      e_id VARCHAR,
      e_name VARCHAR,
      e_email VARCHAR,
      designation VARCHAR,
      salary FLOAT,
      experience SMALLINT,
      d_id VARCHAR,
      PRIMARY KEY (e_id),
      FOREIGN key (d_id) REFERENCES department (d_id)
      
);
-------------------------------------------------------------------------------------------------
-- inserting values into department table
INSERT INTO department(d_id,d_name)
VALUES (4,'app');

-------------------------------------------------------------------------------------------------
-- inserting values into employee table

INSERT INTO employee (e_id, e_name, e_email,designation,salary,experience,d_id)
VALUES (6, 'Yashwanth', 'yash@gmail.com','intern',100000,1 ,2);

-------------------------------------------------------------------------------------------------
-- show all values from table

SELECT * from employee;
-------------------------------------------------------------------------------------------------
-- displaying employee id,name,email,department name

SELECT employee.e_id,employee.e_name,employee.e_email, department.d_name
FROM department
LEFT JOIN employee ON department.d_id = employee.d_id;
-------------------------------------------------------------------------------------------------
-- creating location table

CREATE TABLE Location(
loc_id VARCHAR,
loc_name VARCHAR,
loc_city VARCHAR,
loc_state VARCHAR,
loc_country VARCHAR,
PRIMARY KEY (loc_id)
);
-------------------------------------------------------------------------------------------------
-- altering department table to add  location_id as foreign key

ALTER TABLE department
    ADD CONSTRAINT fk_loc_id FOREIGN KEY (loc_id) REFERENCES LOCATION (loc_id);
-------------------------------------------------------------------------------------------------
-- inserting location id values to department table
update department set loc_id='l1' where d_id='1';
update department set loc_id='l2' where d_id='2';
update department set loc_id='l2' where d_id='3';
update department set loc_id='l3' where d_id='4';

-------------------------------------------------------------------------------------------------
-- query to display employee name,id,email,department name and location
select employee.e_id,employee.e_name,employee.e_email,department.d_name,concat(location.loc_city,'-',LOCATION.loc_state,'-',LOCATION.loc_country) as city_state_country
FROM employee
JOIN department ON employee.d_id = department.d_id
JOIN location ON LOCATION.loc_id = department.loc_id;
-------------------------------------------------------------------------------------------------
-- creating contact table 
CREATE TABLE contact(
    id  int GENERATED always as IDENTITY PRIMARY key,
    address varchar,
    number bigint unique,
    employee_id varchar,
    FOREIGN key(employee_id) REFERENCES employee(e_id)
);
-------------------------------------------------------------------------------------------------
-- inserting values into contact table

insert into contact(address,number,employee_id) values ('mysore',9654267882,2);
insert into contact(address,number,employee_id) values ('coorg',8654267882,1);
insert into contact(address,number,employee_id) values ('mysore',9554267889,2);
insert into contact(address,number,employee_id) values ('banglore',788267882,3);
insert into contact(address,number,employee_id) values ('manglore',798267882,4);
insert into contact(address,number,employee_id) values ('manglore',678867882,5);
insert into contact(address,number,employee_id) values ('shivmoga',888267882,6);

-------------------------------------------------------------------------------------------------


-- Get all contacts based on emp_name
select contact.number from contact
left join employee
on contact.employee_id=employee.e_id
where employee.e_name='Jeevan';

-------------------------------------------------------------------------------------------------


-- Given a contact number find who it is associated with
select employee.e_name
from employee
join contact
on employee.e_id=contact.employee_id
where contact.number=788267882;

-------------------------------------------------------------------------------------------------

