create table semester(
    id varchar PRIMARY key,
    sem_number SMALLINT UNIQUE
);

--------------------------------------------------------------

create table student(
    id BIGINT PRIMARY key,
    usn varchar unique,
    Sname varchar,
    cur_sem SMALLINT REFERENCES semester(sem_number)
);
--------------------------------------------------------------
create table subject(
    id BIGINT PRIMARY KEY,
    Subject_name varchar
);
--------------------------------------------------------------
create table result(
    student_id BIGINT,
    subject_id BIGINT,
    marks FLOAT,
    sem_number SMALLINT REFERENCES semester(sem_number),

    foreign key(student_id) REFERENCES student(id),
    foreign key(subject_id) REFERENCES subject(id)
);

--------------------------------------------------------------

INSERT INTO semester (id, sem_number) VALUES
('SEM1', 1),
('SEM2', 2),
('SEM3', 3),
('SEM4', 4),
('SEM5', 5),
('SEM6', 6),
('SEM7', 7),
('SEM8', 8);
--------------------------------------------------------------
INSERT INTO student (id, usn, Sname, cur_sem) VALUES
(101, 'USN001', 'Jeevan', 7), 
(102, 'USN002', 'Yashwanth', 5),
(103, 'USN003', 'Ullas', 8),
(104, 'USN004', 'Varsha', 2),
(105, 'USN005', 'Preetham', 6), 
(106, 'USN006', 'Chandrashekar', 3);
--------------------------------------------------------------
INSERT INTO subject (id, Subject_name) VALUES
(201, 'Mathematics'),
(202, 'Physics'),
(203, 'Chemistry'),
(204, 'Computer Science'),
(205, 'Electronics'),
(206, 'Data Structures'),
(207, 'Operating Systems'),
(208, 'Machine Learning'),
(209, 'Artificial Intelligence'),
(210, 'Database Management');

--------------------------------------------------------------
INSERT INTO result (student_id, subject_id, marks, sem_number) VALUES
(101, 201, 85, 1), (101, 202, 78, 1),
(101, 203, 88, 2), (101, 204, 90, 2),
(101, 205, 76, 3), (101, 206, 84, 3),
(101, 207, 92, 4), (101, 208, 85, 4),
(101, 209, 88, 5), (101, 210, 89, 5),
(101, 201, 91, 6), (101, 202, 87, 6),
(101, 203, 94, 7), (101, 204, 90, 7),
(102, 201, 70, 1), (102, 202, 75, 1),
(102, 203, 80, 2), (102, 204, 85, 2),
(102, 205, 78, 3), (102, 206, 82, 3),
(102, 207, 76, 4), (102, 208, 80, 4),
(102, 209, 88, 5), (102, 210, 90, 5),
(103, 201, 85, 1), (103, 202, 78, 1),
(103, 203, 88, 2), (103, 204, 90, 2),
(103, 205, 76, 3), (103, 206, 84, 3),
(103, 207, 92, 4), (103, 208, 85, 4),
(103, 209, 88, 5), (103, 210, 89, 5),
(103, 201, 91, 6), (103, 202, 87, 6),
(103, 203, 94, 7), (103, 204, 90, 7),
(103, 205, 95, 8), (103, 206, 93, 8),
(104, 201, 60, 2), (104, 202, 62, 2),
(105, 201, 75, 1), (105, 202, 80, 1),
(105, 203, 85, 2), (105, 204, 88, 2),
(105, 205, 80, 3), (105, 206, 83, 3),
(105, 207, 79, 4), (105, 208, 81, 4),
(105, 209, 84, 5), (105, 210, 85, 5),
(105, 201, 88, 6), (105, 202, 90, 6),
(106, 201, 67, 1), (106, 202, 69, 1),
(106, 203, 70, 2), (106, 204, 72, 2),
(106, 205, 73, 3), (106, 206, 75, 3);
--------------------------------------------------------------

--Queries

--1) List all students belonging to Sem7
select * from student where cur_sem=7;
--------------------------------------------------------------

--2) Get all marks of a student given USN for a particular subject
SELECT s.usn, r.marks From result r 
JOIN student s on r.student_id = s.id
JOIN subject sub ON r.subject_id=sub.id
where s.usn='USN001' and sub.Subject_name='Mathematics';

-- select s.usn, STRING_AGG(r.marks::TEXT, ', ') From result r 
-- JOIN student s on r.student_id = s.id
-- JOIN subject sub ON r.subject_id=sub.id
-- where s.usn='USN001' and sub.Subject_name='Mathematics'
-- GROUP BY s.usn;

--------------------------------------------------------------
--3) Get all marks of a student given USN for the current semester
SELECT r.marks, sub.Subject_name, r.sem_number
FROM result r
JOIN student s ON r.student_id = s.id
JOIN subject sub ON r.subject_id = sub.id
WHERE s.usn = 'USN001' AND r.sem_number = s.cur_sem;
--------------------------------------------------------------

--4) What all semesters has the student attended
 
SELECT DISTINCT r.sem_number 
FROM result r
JOIN student s ON r.student_id = s.id
WHERE s.usn = 'USN001';

--------------------------------------------------------------
--5) Get the total percentage of marks for a student in a semester

SELECT s.usn, r.sem_number, 
       (SUM(r.marks) / (COUNT(r.subject_id) * 100)) * 100 AS percentage 
FROM result r
JOIN student s ON r.student_id = s.id
WHERE s.usn = 'USN001' AND r.sem_number =1
GROUP BY s.usn, r.sem_number;

--------------------------------------------------------------

--6) Get the total percentage in each semester
SELECT r.sem_number, 
       (SUM(r.marks) / (COUNT(r.subject_id) * 100)) * 100 AS percentage 
FROM result r
JOIN student s ON r.student_id = s.id
WHERE s.usn = 'USN001'
GROUP BY r.sem_number
ORDER BY r.sem_number;

--------------------------------------------------------------

--7) Get total percentage of marks for a student

SELECT s.usn, 
       (SUM(r.marks) / (COUNT(r.subject_id) * 100)) * 100 AS total_percentage 
FROM result r
JOIN student s ON r.student_id = s.id
WHERE s.usn = 'USN001'
GROUP BY s.usn;
--------------------------------------------------------------


--8) Get the total percentage of marks for each student in a semester

SELECT s.usn,
       (SUM(r.marks) / (COUNT(r.subject_id) * 100)) * 100 AS percentage 
FROM result r
JOIN student s ON r.student_id = s.id
WHERE r.sem_number =1
GROUP BY s.usn;

