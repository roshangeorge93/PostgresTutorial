-- creating table sem
create table sem(
id int GENERATED ALWAYS as IDENTITY PRIMARY key,
semester_number smallint
);
-------------------------------------------------------------------------------------------------
-- inserting values into sem table
insert into sem(semester_number) values (1);
insert into sem(semester_number) values (2);
insert into sem(semester_number) values (3);
insert into sem(semester_number) values (4);
insert into sem(semester_number) values (5);
insert into sem(semester_number) values (6);
insert into sem(semester_number) values (7);
insert into sem(semester_number) values (8);
-------------------------------------------------------------------------------------------------
-- creating table student
create table student(
id BIGINT GENERATED ALWAYS as IDENTITY PRIMARY key,
usn VARCHAR UNIQUE,
name varchar,
current_sem smallint
);
-------------------------------------------------------------------------------------------------
-- inserting values to student table
insert into student(usn,name,current_sem) values ('vv001','student1',6);
insert into student(usn,name,current_sem) values ('vv012','student2',4);
insert into student(usn,name,current_sem) values ('vv010','student3',4);
insert into student(usn,name,current_sem) values ('vv011','student4',6);
insert into student(usn,name,current_sem) values ('vv100','student5',8);
insert into student(usn,name,current_sem) values ('vv202','student6',2);
insert into student(usn,name,current_sem) values ('vv203','student7',1);
insert into student(usn,name,current_sem) values ('vv005','student8',1);
-------------------------------------------------------------------------------------------------
-- creating subject table

create table subject(
id BIGINT GENERATED ALWAYS as IDENTITY PRIMARY KEY,
name VARCHAR
);
-------------------------------------------------------------------------------------------------
-- inserting values onto subject table
insert into subject(name) values ('kannada');
insert into subject(name) values ('English');
insert into subject(name) values ('Maths');
insert into subject(name) values ('Java');
insert into subject(name) values ('Devops');
insert into subject(name) values ('DBMS');
insert into subject(name) values ('NLP');
-------------------------------------------------------------------------------------------------
-- creating result table
create table result(
student_id BIGINT,
subject_id BIGINT,
marks FLOAT,
sem_id int,
FOREIGN key(student_id) REFERENCES student(id),
FOREIGN key (subject_id) REFERENCES subject(id),
FOREIGN key (sem_id) REFERENCES sem(id) 
);
-------------------------------------------------------------------------------------------------
-- inserting values into result table
insert into result(student_id,subject_id,marks,sem_id) values (1,1,67,2);
insert into result(student_id,subject_id,marks,sem_id) values (1,2,77,2);
insert into result(student_id,subject_id,marks,sem_id) values (1,3,97,3);
insert into result(student_id,subject_id,marks,sem_id) values (2,3,100,3);
insert into result(student_id,subject_id,marks,sem_id) values (2,1,50,2);
insert into result(student_id,subject_id,marks,sem_id) values (2,5,80,1);
insert into result(student_id,subject_id,marks,sem_id) values (3,4,80,2);
insert into result(student_id,subject_id,marks,sem_id) values (4,7,67,2);
insert into result(student_id,subject_id,marks,sem_id) values (5,6,67,8);
insert into result(student_id,subject_id,marks,sem_id) values (6,1,77,2);
insert into result(student_id,subject_id,marks,sem_id) values (7,5,90,1);
insert into result(student_id,subject_id,marks,sem_id) values (8,5,60,1);
insert into result(student_id,subject_id,marks,sem_id) values (5,1,65,2);
insert into result(student_id,subject_id,marks,sem_id) values (3,5,60,1);
-------------------------------------------------------------------------------------------------

-- List all students belonging to sem1
select * from student 
where current_sem='1';
-------------------------------------------------------------------------------------------------
-- Get all marks of a student (given usn) for a particular subject
SELECT
	result.marks
FROM
	result,
	student,
	subject
WHERE
	result.student_id = student.id
	AND result.subject_id = subject.id
	AND student.usn = 'vv010'
	AND subject.name = 'Java';
-------------------------------------------------------------------------------------------------
-- Get all marks of a student given usn for the latest semester 
-- Get all marks of a student given usn for the latest semester 
SELECT
	result.marks
FROM
	result,
	student
WHERE
	result.student_id = student.id
	AND student.usn = 'vv100' AND
	RESULT.sem_id=student.current_sem;
	
-- OR

SELECT
	result.marks
FROM
	result,
	student
WHERE
	result.student_id = student.id
	AND student.usn = 'vv100' AND
RESULT.sem_id=(select max(sem_id) from RESULT where RESULT.student_id=student.id) ;
-------------------------------------------------------------------------------------------------
-- What all semester has the student attended
SELECT
	CASE
		WHEN student.current_sem = 1 THEN '1'
		WHEN student.current_sem = 2 THEN '1,2'
		WHEN student.current_sem = 3 THEN '1,2,3'
		WHEN student.current_sem = 4 THEN '1,2,3,4'
		WHEN student.current_sem = 5 THEN '1,2,3,4,5'
		WHEN student.current_sem = 6 THEN '1,2,3,4,5,6'
		WHEN student.current_sem = 7 THEN '1,2,3,4,5,6,7'
		WHEN student.current_sem = 8 THEN '1,2,3,4,5,6,7,8'
	END
FROM
	student
WHERE
	student.name = 'student5';

-- OR


SELECT string_agg(sem::TEXT,',') as total_sems_attended
FROM generate_series(1,(select current_sem from student WHERE student.name='student5')) AS sem;
-- for all students
SELECT student.id, string_agg(sem::TEXT,',') as total_sems_attended
FROM student
join 
generate_series(1,(select student.current_sem)) AS sem on true GROUP BY student.id;

-------------------------------------------------------------------------------------------------

-- Get the total percentage of marks for a student in a sem
select roud((sum(result.marks)::NUMERIC / count(result.subject_id)),2) as percentage from result,student  where result.student_id=student.id AND result.sem_id=2 AND student.usn='vv001';

-------------------------------------------------------------------------------------------------
-- Get the total percentage of marks for a student in each semester
SELECT
	RESULT.sem_id,
	round((sum(result.marks)::NUMERIC / count(result.subject_id)), 2) AS percentage
FROM
	result,
	student
WHERE
	result.student_id = student.id
	AND student.usn = 'vv001'
GROUP BY
	RESULT.sem_id;

-------------------------------------------------------------------------------------------------
-- Get total percentage of marks for a student
SELECT
	 round  (sum(result.marks)::NUMERIC / count(result.subject_id), 2) AS total_percentage
FROM
	result,
	student
WHERE
	result.student_id = student.id
	AND student.usn = 'vv001';
-------------------------------------------------------------------------------------------------