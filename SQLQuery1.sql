--uc1
create database payroll_services;

use payroll_services;

--UC2
create table employee_payrol
(

id int NOT NULL IDENTITY(1,1) PRIMARY KEY,

name varchar(150) not null,
salary float NOT NULL,

start date not null
);

--UC3
Insert into employee_payrol(name, salary, start)
values
('abhishek',30000,'2018-01-03'),
('palak',22000,'2018-03-03'),
('sanjeev',35000,'2017-11-03');

--UC4
select * from employee_payrol;

--UC5
select name, salary from employee_payrol where name='abhishek'; 

select * from employee_payrol where start between cast('2019-03-03' as date) and getdate();



select getdate();

select convert(date,getdate());

select cast(getdate() as date);

SELECT CONVERT(time, getdate())

--uc6
alter table employee_payrol
add gender char(1);

select * from employee_payrol;

update employee_payrol set gender='F' where name='palak';

update employee_payrol set gender='M' where name='abhishek' or name='sanjeev';

select * from employee_payrol;

--UC7
select gender, avg(salary) from employee_payrol where gender='F' group by gender;

select gender, count(*) from employee_payrol group by gender;

select count(name) from employee_payrol;

select gender, sum(salary) from employee_payrol group by gender;

select min(salary) as "Lowest Salary" from employee_payrol;

select max(salary) Highest_Salary from employee_payrol;

select name, salary from employee_payrol where salary= (select max(salary) from employee_payrol);

--adding phone number, address and department into the table UC8
select * from employee_payrol;

alter table employee_payrol add  phone_number int;

alter table employee_payrol add address varchar(150) default 'bangalore';

alter table employee_payrol add department varchar(150) not null default 'HR';

alter table employee_payrol
alter column phone_number bigint;

update employee_payrol
set phone_number =8527419632, address= 'bhopal',department='IT'
where name='abhishek';

update employee_payrol
set phone_number =8447433632, address= 'noida'
where name='palak';

update employee_payrol
set phone_number=9415800892, address='bangalore'
where name='sanjeev';

select * from employee_payrol;

--UC9
Exec sp_rename 'employee_payrol.salary','Base_pay','COLUMN';

alter table employee_payrol add Deductions float , Taxable_pay float,Net_pay float,Income_Tax float 

update employee_payrol
set deductions= 100, taxable_pay = 200, net_pay= base_pay-300, income_tax= 0.1*(base_pay)
where name='abhishek' or name='palak';

select * from employee_payrol

update employee_payrol
set deductions=50, taxable_pay=100, net_pay= base_pay-200, income_tax=0.15*(base_pay)
where name='sanjeev';

create table company
(company_id int primary key,
companyName varchar(50) not null);

--inserted data into company table
insert into company
values(101, 'TCS');
--altering table employee payroll to add company id column
alter table employee_payrol
add company_id int not null default 101;
--adding department table
create table departments
(departmentID int primary key,
departmentName varchar(50) not null,
noOfEmployees int ,
headOfDepartment varchar(50) not null);
--adding data into department table
insert into departments
values
(01,'IT',29,'kuldeep'),(02,'HR',35,'Shilpa'),(03,'Maintainence',5,'pradeep');

insert into departments(departmentID,departmentName,headOfDepartment)
values(04,'Sales','Makhan'),(05,'Marketing','reena');
--creating employee department table
create table EmployeeDepartment
(employeeID int not null, departmentID int not null);
--selecting data from employee payroll
select * from employee_payrol;
--inserting data into employee department which acts a link between employee and department to cater many to many relation ship between them
insert into EmployeeDepartment
values
(1,01),(2,02),(3,02),(1,03);
--deleting redundant data from employee payroll
delete from employee_payrol
where name='abhishek' and department='IT';

select * from employee_payrol;
--dropping department column from employee payroll
alter table employee_payrol drop constraint DF__employee___depar__37A5467C;
alter table employee_payrol drop column department;
--renaming table name from employee payroll to employee using stored procedure
exec sp_rename 'employee_payrol', 'employee'
--creating table payroll
create table payroll
(employeeID int not null primary key, basepay decimal not null, deductions decimal not null, taxable_pay decimal not null,
tax decimal not null, netPay decimal not null);

select * from employee;
--inserting data into payroll
insert into payroll
values
(1,50000,5000,45000,1000, 44000),(2,100000,10000,90000,2000,88000),(3,300000,30000,270000,20000,250000);
--altering table employee to delete columns of payroll
alter table employee
drop column base_pay;

alter table employee
drop column deductions,
taxable_pay,
net_pay,
income_tax;
