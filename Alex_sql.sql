CREATE DATABASE `Parks_and_Recreation`;
USE `Parks_and_Recreation`;

CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id));

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT);

CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id));

INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');
# employee_demographics , employee_salary ,  parks_departments
select * 
from employee_salary
where first_name = 'Leslie' ;
select * 
from employee_salary
where salary >= 70000 
or dept_id= 1;
select * 
from employee_salary
where salary >= 70000 
or dept_id= 1;
select * 
from employee_demographics
where (birth_date > '1988-12-01' and gender='male') or last_name = 'Dwyer' ;
select * 
from employee_demographics
where last_name like 'm_____' ;
select gender,avg(age),max(age),min(age)
from employee_demographics
group by gender;
select dept_id, avg(salary)
from employee_salary
group by dept_id;
select  *
from employee_salary
order by salary desc;
select  *
from employee_demographics
order by gender,age ;
select dept_id, avg(salary)
from employee_salary
group by dept_id
having avg(salary)>55000;
select gender, count(gender) as count
from employee_demographics
group by gender 
having count(gender)<10
order by gender;
select occupation, avg(salary)
from employee_salary
where occupation like '%manager'
group by occupation
having avg(salary)>=5000 ;
select dept_id, avg(salary)
from employee_salary
group by dept_id
having avg(salary)>=5000
order by avg(salary) desc
limit 2,1 ;
select dem.employee_id, dem.first_name,dem.last_name, occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id ; 
select *
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id = sal.employee_id ; 
select dem1.first_name as santa, dem1.last_name as santa , dem1.employee_id as santasid,
dem2.first_name as other, dem2.last_name as other , dem2.employee_id as otherid
from employee_salary as dem1
join employee_salary as dem2
	on dem1.employee_id +1 = dem2.employee_id 
        ;
select dem1.first_name as santa, dem1.last_name as santa , dem1.employee_id as santasid,
dem2.first_name as other, dem2.last_name as other , dem2.employee_id as otherid
from employee_salary as dem1
join employee_salary as dem2
	on dem2.employee_id = 
    (case 
		when dem1.employee_id= (select max(employee_id) from employee_salary )
        then (select min(employee_id) from employee_salary)
        else 
        dem1.employee_id +1
        end)
order by dem1.employee_id
        ;
select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id 
inner join parks_departments pd 
	on sal.dept_id=pd.department_id;
select first_name
from employee_demographics
union all 
select first_name
from  employee_salary;
select first_name, last_name,'old' as reason
from employee_demographics
where (age > 50 and gender ='Male') or (age > 40 and gender ='Female')
union all 
select first_name, last_name,'highly paid' as reason
from  employee_salary
where salary > 70000
order by first_name
;
SELECT 
    first_name, 
    last_name,
   group_concat(reason SEPARATOR ', ') AS reasons
FROM (
select first_name, last_name,'old' as reason
from employee_demographics
where (age > 50 and gender ='Male') or (age > 40 and gender ='Female')
union all 
select first_name, last_name,'highly paid' as reason
from  employee_salary
where salary > 70000
) AS combined
group by first_name , last_name
order by first_name
;
select first_name , length(first_name)
from employee_demographics
order by 2;
select first_name , upper(first_name)
from employee_demographics;
select trim('occupation   ');
select first_name, left(first_name,4), right(first_name,4),substring(first_name,3,2),
substring(birth_date, 6,2) as birth_month
from employee_demographics;
select first_name, replace(first_name, 'a','z') 
from employee_demographics;
select locate('x','Alexender');
select first_name, locate('An',first_name) 
from employee_demographics;
select first_name,last_name, concat(first_name,'  ', last_name) as Full_name
from employee_demographics;
select first_name , last_name , age, 
case 
	when age<35 then 'young'
    when age between 35 and 50 then 'old'
    when age >=50 then 'so old'
end as age_state
from employee_demographics;
select  min(age),max(age)
from employee_demographics;
select  first_name, salary, department_name,
case 
	when (salary <50000)  then salary*1.05
    when (salary >50000 ) then salary*1.07
End as new_salary,
case 
	when department_name = 'Finance' then salary*0.1
End as Bonus
from employee_salary
join parks_departments
on dept_id = department_id;
select * from employee_demographics
where employee_id IN (
						select employee_id 
							from employee_salary 
								where dept_id =1);
select * 
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id 
where dept_id =1;
select *,( select avg(salary) as AVG_salary from employee_salary)as AVG_salary,
case 
	when salary <( select avg(salary) as AVG_salary from employee_salary)
    then 'less'
    when salary >( select avg(salary) as AVG_salary from employee_salary)
    then 'more'
    when salary = ( select avg(salary) as AVG_salary from employee_salary)
    then 'equal'
END as according_to_AVG_salary
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id ;
select *,( select avg(salary) as AVG_salary from employee_salary)as AVG_salary
from employee_demographics as ed;
select avg(max_age) from (
select gender, max(age) as max_age , min(age) as min_age , avg(age) as AVG_age
from employee_demographics 
group by gender) as agg_table;
select gender , avg(salary)
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id 
group by gender;
select gender , avg(salary) over()
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id ;
select ed.first_name ,ed.last_name , gender, avg(salary) over(partition by gender) as avg_salary
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id ;
select ed.first_name ,ed.last_name , gender, 
sum(salary) over(partition by gender order by ed.employee_id) as rolling_sum
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id ;
select ed.first_name ,ed.last_name , gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc ) as emp_rank,
dense_rank() over(partition by gender order by salary desc) as den_emp_rank
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id ;

with CTE_Example(Gender, Max_salary, Min_salary, AVG_salary ) as
(
select gender, max(salary) as max_salary , min(salary) as min_salary , avg(salary) as AVG_salary
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id
group by gender
)
select avg(AVG_salary)
from CTE_Example ;
# is the same answer for 
select avg(AVG_salary) from (
select gender, max(salary) as max_salary , min(salary) as min_salary , avg(salary) as AVG_salary
from employee_demographics as ed
join employee_salary as es
on ed.employee_id = es.employee_id
group by gender) as agg_table;

with CTE_Example as
(
select employee_id, gender , birth_date
from employee_demographics 
where birth_date > '1985-01-01' ), 
CTE_Example2 as 
(
select employee_id , salary
from employee_salary 
where salary >'50000')
select * 
from CTE_Example
join  CTE_Example2 
on CTE_Example.employee_id = CTE_Example2.employee_id;

create temporary table salary_over_50K
select *
from employee_salary 
where salary>50000;
select * from salary_over_50K;

create procedure large_salaries() 
select * 
from employee_salary 
where salary >= 50000;
call large_salaries();

DELIMITER $$
create procedure Large_salaries2()
begin
	select *
	from employee_salary 
	where salary >= 50000;
	select *
	from employee_salary 
	where salary >= 20000;
ENd $$
DELIMITER ;
call Large_salaries2;
DELIMITER $$ 
create procedure salaries(EMP_ID int)
Begin 
	select salary 
    from employee_salary 
    where employee_id = EMP_ID ;
END $$
DELIMITER ;
call salaries(1);

DELIMITER $$ 
create trigger employee_insert
	after insert on employee_salary
    for each row 
Begin 
    insert into employee_demographics (employee_id , first_name , last_name)
    values(new.employee_id, new.first_name , new.last_name) ;
END $$
DELIMITER ;

insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(13, 'Baty', 'Bladil', 'Exntertainment 720 CEO', 1000000,null);
select * from employee_demographics;

DELIMITER $$ 
create event deleting_over60
on schedule every 30 second 
do
Begin 
	delete 
    from employee_demographics
    where age >=60;
END $$
DELIMITER ;
select * from employee_demographics;