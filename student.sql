-- semester table creation
CREATE TABLE semester(
	number INT,
	PRIMARY KEY(number)
);

-- subject table creation
CREATE TABLE subject(
	id Serial,
	name varchar(100),
	PRIMARY KEY(id)
);

ALTER SEQUENCE subject_id_seq RESTART WITH 20;

-- Student table creation
CREATE TABLE student(
	id serial,
	usn VARCHAR(100) UNIQUE,
	name CHAR(100),
	PRIMARY KEY(id)
);

ALTER SEQUENCE student_id_seq RESTART WITH 101;

-- student table creation
 CREATE TABLE result(student_id int,sem_id int,marks REAL,sub_id int,FOREIGN KEY(student_id)REFERENCES student(id),FOREIGN KEY(sem_id)REFERENCES semester(number),FOREIGN KEY(sub_id)REFERENCES subject(id));

ALTER TABLE student
ADD COLUMN current_sem SMALLINT;

ALTER TABLE student
add CONSTRAINT fk_student FOREIGN KEY(current_sem) REFERENCES semester(number);

UPDATE  student set current_sem='1' WHERE id='109';

-- ASSIGNMENT queries
-- 1. List all students belong to sem 1
SELECT
	*
FROM
	student
WHERE
	current_sem = '1';

-- 2.get all marks of a student given usn of a particular subject
SELECT marks,student.usn,student.name FROM result JOIN student ON result.student_id=student.id JOIN subject ON result.sub_id=subject.id WHERE student.usn='CS103' AND subject.name='S2';

-- 3.get all marks of a student given usn of the current sem
SELECT student.usn,student.name,
       STRING_AGG(subject.name :: TEXT || ': ' || result.marks::TEXT, '  || ') AS Marks
FROM result
JOIN student ON result.student_id = student.id join subject on result.sub_id= subject.id
WHERE student.usn = 'CS105' 
  AND result.sem_id = current_sem
GROUP BY student.usn,student.name;


-- 4.list all semester the student has attended
SELECT student.name, array_to_string(array_agg(DISTINCT result.sem_id), ', ') AS Semesters
FROM result
JOIN student ON result.student_id = student.id
WHERE student.usn = 'CS101'
GROUP BY student.name;


-- 5.total % of a student in the particular sem 
SELECT
	result.sem_id,
	AVG(marks) AS Total_Percentage
FROM
	result
	JOIN student ON result.student_id = student.id
WHERE
	student.usn = 'CS103'
	AND result.sem_id = '5'
GROUP BY
	student.id,
	result.sem_id;
-- OR
SELECT s.usn,avg_result.sem_id,avg_result.total_percentage FROM student s LEFT JOIN(SELECT student.id,result.sem_id,AVG(marks)AS total_percentage FROM result JOIN student ON result.student_id=student.id WHERE student.usn='CS103' AND result.sem_id='5' GROUP BY student.id,result.sem_id)avg_result ON s.id=avg_result.id
WHERE s.usn = 'CS103'


-- 6.Get total % in each sem of a student
WITH SemesterWiseMarks AS (
    SELECT 
        student.name, 
        result.sem_id, 
        AVG(result.marks) AS avg_marks
    FROM result 
    JOIN student ON result.student_id = student.id 
    WHERE student.usn = 'CS101' 
    GROUP BY student.name, result.sem_id
)
SELECT 
    name, 
    STRING_AGG(sem_id::TEXT || ' :' || avg_marks::TEXT, '  || ') AS sem_wise_percentage
FROM SemesterWiseMarks
GROUP BY name;

-- OR
SELECT s.name,s.usn,avg_res.sem_id,avg_res.avg_marks from student s left join(
	SELECT 
		student.id,
        r.sem_id,
        AVG(r.marks) AS avg_marks
    FROM result r
    JOIN student ON r.student_id = student.id 
    WHERE student.usn = 'CS103' 
    GROUP BY r.sem_id, student.id
    )avg_res on  s.id=avg_res.id 
    where s.usn='CS103'; 

--  7.Total % of a student
SELECT
	student.name,
	AVG(marks) AS Total_Percentage
FROM
	result
	JOIN student ON result.student_id = student.id
WHERE
	student.usn = 'CS105'
GROUP BY
	student.name;
-- OR
SELECT student.name, avg_res.Total_Percentage from student  left join(
	SELECT
		student.id,
		AVG(marks) AS Total_Percentage
	FROM
		result
		JOIN student ON result.student_id = student.id 
		where student.usn = 'CS105'
		Group BY student.id
) avg_res on student.id = avg_res.id;