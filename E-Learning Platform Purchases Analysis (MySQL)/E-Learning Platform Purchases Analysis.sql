create database learnhub;
use learnhub;

create table learners (
learner_id int auto_increment primary key,
full_name varchar(25),
country varchar(10)
);
create table courses (
course_id int auto_increment primary key,
course_name varchar(25),
category varchar(25),  
unit_price decimal(10,2)
);
create table purchases (
purchase_id int auto_increment primary key,
learner_id int,
course_id int,
foreign key(learner_id) references learners(learner_id),
foreign key(course_id) references courses(course_id),
quantity int,
purchase_date date
);

INSERT INTO learners (full_name, country)
VALUES
('John Smith', 'USA'),
('Priya Sharma', 'India'),
('David Lee', 'Canada'),
('Maria Garcia', 'Spain'),
('Ahmed Khan', 'UAE'),
('Emily Johnson', 'UK'),
('Arjun Patel', 'India'),
('Sophia Brown', 'Australia'),
('Michael Wilson', 'USA'),
('Fatima Hassan', 'Egypt');
select * from learners;

INSERT INTO courses (course_name, category, unit_price)
VALUES
('SQL Basics', 'Database', 249.99),
('Power BI', 'Analytics', 179.99),
('Excel Advanced', 'Analytics', 139.99),
('Python Basics', 'Programming', 359.99),
('Web Development', 'Programming', 299.99),
('Tableau Fundamentals', 'Analytics', 199.99),
('Java Programming', 'Programming', 329.99);
select * from courses;

INSERT INTO purchases
(learner_id, course_id, quantity, purchase_date)
VALUES
(1, 1, 3, '2026-01-15'),
(1, 2, 2, '2026-02-10'),
(2, 3, 1, '2026-02-20'),
(3, 4, 4, '2026-03-05'),
(4, 2, 2, '2026-03-18'),
(5, 2, 1, '2026-04-12'),
(9, 1, 3, '2026-04-25'),
(3, 3, 2, '2026-05-01'),
(6, 6, 2, '2026-05-10'),
(7, 6, 1, '2026-05-15');
select * from purchases;

-- AS --
select full_name as learner_name, country as location from learners;
select quantity as purchase_quantity, purchase_date as enrollment_date from purchases;

-- SORTING --
-- Order by --
select * from courses order by category;

-- Limit --
select * from purchases order by purchase_date desc limit 5;

-- JOINS --
-- Inner Join --
select  l.learner_id, 
		l.full_name, 
        c.course_name, 
        c.category, 
        p.quantity, 
        (c.unit_price*p.quantity) as total_amount, 
        p.purchase_date
from learners as l
join purchases as p
on l.learner_id = p.learner_id
join courses as c
on p.course_id = c.course_id
order by l.learner_id;
        
-- Left Join --
select  l.learner_id, 
		l.full_name, 
        c.course_name, 
        c.category, 
        p.quantity, 
        (c.unit_price*p.quantity) as total_amount, 
        p.purchase_date
from learners as l
left join purchases as p
on l.learner_id = p.learner_id
left join courses as c
on p.course_id = c.course_id
order by l.learner_id;
        
-- Right Join --
select  l.learner_id, 
		l.full_name, 
        c.course_name, 
        c.category, 
        p.quantity, 
        (c.unit_price*p.quantity) as total_amount, 
        p.purchase_date
from learners as l
right join purchases as p
on l.learner_id = p.learner_id
right join courses as c
on p.course_id = c.course_id
order by l.learner_id;
        
-- Total Spending --
select  l.*, 
		p.quantity, 
        c.unit_price, 
        (p.quantity*c.unit_price) as total_spending 
from learners as l
join purchases as p
on l.learner_id = p.learner_id
join courses as c
on p.course_id = c.course_id
order by learner_id;

-- Top 3 Most Purchased Course --
Delimiter $$
create procedure GetTop3Courses (in n int)  
begin
	select p.*, c.course_name
    from purchases as p
    join courses as c
    on p.course_id = c.course_id
    order by p.quantity desc limit n;
end $$
Delimiter ;   
call GetTop3Courses (3);

-- Category wise Revenue and Unique Learner Analysis --
select  c.category, 
		sum(c.unit_price*p.quantity) as total_revenue,
        count(distinct p.learner_id) as unique_learners
from courses as c
join purchases as p
on c.course_id =p.course_id
group by c.category;

-- Learners Purchasing from Multiple Categories --
select  l.learner_id, 
		l.full_name, 
        count(distinct c.category) as category_count
from learners as l
join purchases as p
on l.learner_id = p.learner_id
join courses as c
on p.course_id = c.course_id
group by l.learner_id, l.full_name 
having category_count > 1;

--  Not Purchased Courses --
select * from courses where course_id not in (select course_id from purchases);

        
        
        
        
        
        
        
        




































