CREATE TABLE Department(
   d_id VARCHAR,
   d_name  VARCHAR,
   PRIMARY KEY(d_id),
   loc_id VARCHAR,
   FOREIGN KEY(loc_id) REFERENCES location(loc_id)
);

---------------------------------------------------------------
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
---------------------------------------------------------------
CREATE TABLE Location(
loc_id VARCHAR,
loc_name VARCHAR,
loc_city VARCHAR,
loc_state VARCHAR,
loc_country VARCHAR,
PRIMARY KEY (loc_id)
);
--------------------------------------------------------------
-- altering department table to add  location_id foreign key
 
-- ALTER TABLE department
--     ADD CONSTRAINT Location_ID FOREIGN KEY (loc_id) REFERENCES LOCATION (loc_id);
--------------------------------------------------------------

CREATE table ContactDetails(
contact_id VARCHAR PRIMARY KEY,
contact_number BIGINT,
address VARCHAR,
e_id VARCHAR,
FOREIGN KEY (e_id) REFERENCES employee(e_id)
);

--------------------------------------------------------------

INSERT INTO Location (loc_id, loc_name, loc_city, loc_state, loc_country) VALUES
('L001', 'Head Office', 'New York', 'NY', 'USA'),
('L002', 'Branch Office', 'Los Angeles', 'CA', 'USA'),
('L003', 'Tech Hub', 'San Francisco', 'CA', 'USA');

--------------------------------------------------------------
INSERT INTO Department (d_id, d_name, loc_id) VALUES
('D001', 'HR', 'L001'),
('D002', 'IT', 'L003'),
('D003', 'Finance', 'L002');
--------------------------------------------------------------
INSERT INTO Employee (e_id, e_name, e_email, designation, salary, experience, d_id) VALUES
('E001', 'Jeevan', 'jeevan@gmail.com', 'HR Manager', 75000, 10, 'D001'),
('E002', 'yashwanth', 'yashwanth@gmail.com', 'Software Engineer', 85000, 5, 'D002'),
('E003', 'ullas', 'ullas@gmail.com', 'Accountant', 60000, 7, 'D003'),
('E004', 'preetham', 'preetham@gmail.com', 'IT Manager', 95000, 12, 'D002');

--------------------------------------------------------------

INSERT INTO ContactDetails (contact_id, contact_number, address, e_id) VALUES
('C001', 9886468304, 'Mysore', 'E001'),
('C002', 7338234250, 'Nanjangud', 'E002'),
('C003', 9535192639, 'Mandya', 'E003'),
('C004', 8217365187, 'jharkhand', 'E004'),
('C005', 7353037193, 'coorg', 'E002'),
('C006', 9972200497, 'hassan', 'E003');

--------------------------------------------------------------
--To get list of contact numbers given eid

SELECT c.e_id, c.contact_number from contactdetails c
JOIN employee e 
ON c.e_id = e.e_id
where c.e_id='E003';
--------------------------------------------------------------

--To get employee details based on the contact number

SELECT e.e_id, e.e_name,e.e_email,e.designation, e.salary, e.experience 
FROM employee e
JOIN contactdetails c
ON e.e_id = c.e_id
WHERE c.contact_number=9886468304;

