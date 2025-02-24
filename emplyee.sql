CREATE table employee(
	id varchar,
	name varchar,
	desgnitation varchar,
	salary int,
	primary key(id)
);

create table contacts(
	id varchar,
	name varchar,
	adress VARCHAR,
	emp_id varchar,
	primary key(id),
	foreign key(emp_id) REFERENCES employee(id)
);

drop table contacts


--- to print the name and contact if employee have the contact

select e.name,c.name from employee e
inner join contacts c
on e.id=c.emp_id


-- to print nme if the contact name is given

select e.name,c.name from employee e
inner join contacts c
on e.id=c.emp_id
where c.name='name4'


--to print all contacts that a employee has


select e.name,c.name from employee e
inner join contacts c
on e.id=c.emp_id
where e.name='emp_name_4'

--to count the total no. of contact of employee


select e.name,count(c.name)from employee e
inner join contacts c
on e.id=c.emp_id
group by e.name

