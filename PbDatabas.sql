create database Pb;
use pb;
create table student(sid int primary key,sname varchar(20) not null,marks int check(marks>0),mobile bigint,city varchar(20) default 'Pune');
insert into student values(1,'shyam',6,987654210,'nande');
select*from student;
insert into student values(2,'Rajesh',50,9865741230,'Beed');
select*from student;
alter table student add hid int;

alter table hotel alter column hid int not null;
--use foreign key 
alter table student add foreign key(hid) references Hotel(hid);

insert into student(sid,sname,marks) values(3,'Raj',60);
insert into student values(4,'Raj',60,9876543210,'pune',1);

--update query
update student set marks=60,city='Pune' where sname='shyam';

--upadte query 
update student set marks=marks+5 where sname='Rajesh';

--Hotel table
create table Hotel(hid int,hname varchar(20));

insert into Hotel values(1,'Raj');
 insert into Hotel values(2,'Taj',4,'Mumbai');

 select * from Hotel;
 --add new column
 alter table Hotel add rating int;
 alter table Hotel add Place varchar(20);

 --change datatype
 alter table Hotel alter column rating float;

 --drop column
 alter table Hotel drop column rating;

 --first define not null
 alter table Hotel alter column hid int not null;

 --add primary key on hid
 alter table Hotel add Primary key(hid);

 --create customer table
 create table Customer(custid int primary key,cname varchar(30),city varchar(30),mobile bigint);

 --insert data
 insert into Customer values(1,'Shyam','Pune',9876543210),(2,'Akash','Nanded',9876543201),(3,'Raj','Nashik',9876542310);

 --insert data 
 
 --
 create table orderDeatils(orderid int primary key,orderdate date,custid int, 
 
 constraint fkcid foreign key(custid) references Customer(custid) on delete set null on update cascade);

 insert into orderDeatils values(101,10-06-22,1),(102,11-06-22,2);

 select * from Customer;
 select * from orderDeatils;
 delete from Customer where custid=3;
 
 create table item(itemid int primary key,itemname varchar(20),price int);

 --use composite key
 create table orderItemDetails(orderid int,itemid int,qty int,primary key(orderid,itemid),
 foreign key(orderid) references orderDeatils(orderid),
 foreign key(itemid) references item(itemid));

 create table thinkemp(empid int primary key,ename varchar(20) not null, salary int, mrgid int);

 alter table thinkemp add constraint fkmgid foreign key(mrgid) references thinkemp(empid);

--return EmpName with Manager
 select e1.ename 'EmpName',e2.ename 'Manager' from thinkemp e1 inner join thinkemp e2 on e1.mrgid=e2.empid; 

 --return whom manger handle greter than 2 employee
 select m.ename,count(*) from thinkemp e inner join thinkemp m on e.mrgid=m.empid group by m.ename having count(*)>=2;

 select * from thinkemp;

 create table em(eid int primary key identity(101,1),ename varchar(20) not null, mobile bigint);
 insert into em (ename,mobile) values('Ajinkya',98765432),('Vaibhav',9865288);

 select * from em;

 create unique nonclustered index idx on em(mobile);

 insert into em(ename) values('sapna');

 create view vktemp as select empid,ename from thinkemp;

  select * from thinkemp;
  insert into vktemp values(9,'Sonali');
  delete from vktemp where empid=3;

  --complex
  create view v2 as select batchid,count(*) as count from stud group bybatchid;

  select * from vk2;

  create view vk3 as select sname,b.batchid,bname from stud s inner join batch b on s.batchid=b.batchid;


  --commit and rollback 
  begin try
	begin tran
	insert into em values('Rajesh',98765431);
	insert into em values('shyam',9867542);
	commit tran;
 end try
 begin catch
	select ERROR_MESSAGE();
	rollback tran;
end catch;
	
select * from em;

truncate table em;

delete em where eid=101;
delete em where eid=102;