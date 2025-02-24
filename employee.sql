CREATE TABLE Location (
    loc_id VARCHAR PRIMARY KEY, 
    loc_name VARCHAR(20),
    loc_state VARCHAR,
    
    loc_city  VARCHAR,
    loc_country VARCHAR
);

CREATE TABLE Department (
    dept_id VARCHAR(5) PRIMARY KEY, 
    dept_name VARCHAR(20),
    loc_id VARCHAR REFERENCES Location (loc_id)
);


CREATE TABLE Employees (
    eid VARCHAR(10) PRIMARY KEY,
    ename VARCHAR(25), 
    email VARCHAR(30), 
    designation VARCHAR(20), 
    salary NUMERIC, 
    experience SMALLINT, 
--     dept_id VARCHAR(5) FOREIGN KEY REFERENCES Department(dept_id) 
    dept_id VARCHAR REFERENCES Department (dept_id)
--     CONSTRAINT fk_name FOREIGN KEY (foreign_key_column)
--     REFERENCES Department (dept_id)
);


INSERT INTO Location (loc_id, loc_name, loc_state, loc_city,loc_country) VALUES 
    ('L001', 'vasanth-office', 'karnataka','banglore', 'india'),
    ('L002', 'ramnage-office', 'karnataka','mys', 'india'),
    ('L003', 'abc-office', 'karnataka','hassan', 'india');





INSERT INTO Department (dept_id, dept_name,loc_id) VALUES 
    ('D001', 'DEV','L001'),
    ('D002', 'DEVOPS','L001'),
    ('D003', 'TRAINING','L001'),
    ('D004', 'RECURIT','L001'),
    ('D005', 'HR','L001');
	 

INSERT INTO Employees (eid, ename, email, designation,salary,experience,dept_id) VALUES 
    ('E001', 'jeevan', 'jeevan@vvce.com','student','0000',2,'D001'),
    ('E002', 'yash', 'yasheevan@vvce.com','student','0000',4,'D002')
; 




SELECT e.eid , e.ename ,d.dept_name FROM Employees e , Department d ;

SELECT e.eid , e.ename ,d.dept_name ,CONCAT_WS('-', l.loc_name ,l.loc_city)  FROM Employees e , Department d , LOCATION l;


