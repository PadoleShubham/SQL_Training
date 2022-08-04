create database employee;
use Employee;
create table employee(Eid int primary key,Ename varchar(40) not null,Dname varchar(20) not null,salary int,age int);
insert into employee values(1,'Rajesh','IT',25000,24);
insert into employee values(2,'shyam','Sales',30000,25);
insert into employee values(3,'Nagesh','ME',20000,20);
insert into employee values(4,'akash','IT',25000,26);
insert into employee values(5,'Suraj','Medical',26000,30);
insert into employee values(6,'aka','Sales');


select*from employee;




