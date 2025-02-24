-- department table CREATE
CREATE TABLE department(       
	d_id VARCHAR(100),
	d_name CHAR(100),
	PRIMARY KEY(d_id)
);

-- employee table CREATEED
CREATE TABLE emplyee(
	e_id VARCHAR(100),
	e_name CHAR(100),
	email VARCHAR(100),
	designation CHAR(100),
	salary REAL,
	expn SMALLINT,
	d_id VARCHAR(100),
	PRIMARY KEY(e_id),
	FOREIGN KEY(d_id) REFERENCES department(d_id)
);

-- Location table Creation
CREATE TABLE location(l_id VARCHAR(100), lname CHAR(100), lcity CHAR(100), lstate CHAR(100), lcountry CHAR(100), PRIMARY KEY(l_id));

-- Class Assignment-1
SELECT emplyee.e_id, emplyee.e_name, department.d_name FROM emplyee JOIN department ON emplyee.d_id = department.d_id


-- class Assignment - 2
ALTER TABLE department 
ADD l_id VARCHAR(100); FOREIGN Key(l_id) REFERENCES location(l_id);


UPDATE department SET l_id= 'L2' WHERE d_id='D2';
UPDATE department SET l_id= 'L10' WHERE d_id='D3';
UPDATE department SET l_id= 'L8' WHERE d_id='D4';
UPDATE department SET l_id= 'L5' WHERE d_id='D5';
UPDATE department SET l_id= 'L6' WHERE d_id='D6';
UPDATE department SET l_id= 'L6' WHERE d_id='D7';
UPDATE department SET l_id= 'L4' WHERE d_id='D8';
UPDATE department SET l_id= 'L3' WHERE d_id='D9';
UPDATE department SET l_id= 'L1' WHERE d_id='D10';

-- Query 
SELECT
	emplyee.e_id,
	emplyee.e_name,
	department.d_name,
	concat(location.lcity, '_',location.lstate, '_',location.lcountry) AS Address
FROM
	emplyee
	JOIN department ON emplyee.d_id = department.d_id
	JOIN location ON department.l_id = LOCATION.l_id;



-- Home Assignment 
-- Category Table 
CREATE TABLE category(
	cat_id varchar(100),
	cat_name CHAR(100),
	par_cat_id VARCHAR(100),
	PRIMARY KEY(cat_id)
);

-- Brand Table
CREATE TABLE brand(
	br_id VARCHAR(100),
	br_name CHAR(100),
	PRIMARY KEY(br_id)
);





-- Assignment-21/02/25
-- contactdetails table creation

CREATE TABLE contact_detail(
	id Serial ,
	number INT UNIQUE,
	address char(100),
	e_id VARCHAR(100),
	PRIMARY KEY(id),
	FOREIGN KEY(e_id) REFERENCES emplyee(e_id)
);

INSERT INTO contact_detail(number, address,e_id) VALUES(9876543212,"Mysuru",'E1');

-- Get all contacts related to employee based on employee name
SELECT * FROM contact_detail JOIN emplyee ON contact_detail.e_id = emplyee.e_id WHERE emplyee.e_name='Shyam';

-- given a number find the employee
SELECT e_name, contact_detail.number, contact_detail.address from emplyee JOIN contact_detail ON contact_detail.e_id = emplyee.e_id where contact_detail.number='9086142788';

