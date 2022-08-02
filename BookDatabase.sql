create database BookStore;
use BookStore;
create table Book(bid int primary key,bname varchar(40) not null,author varchar(20) not null,price int not null);
insert into Book values(1,'Java','Nirali',150);
insert into Book values(2,'C','Nirali',120);

select author from Book;
select bname from Book;
select author,price from Book;
select * from Book;

--Doctor Table
create table Doctor(Did int,Daddress varchar(30),qualification varchar(30),Noofpatient_handled int);



--PatientMaster Table
create table PatientMaster(Pcode int,Pname varchar(30),Paddres varchar(30),Age int,Gender char(10),Bloodgroup char(10));

--Admitted Patient
create table AdmittedPatients(Pcode int,EntryDate date,WardNo int,Disease varchar(20),did varchar(10));

--Bill table
create table Bill(BillNo int,Pcode int,BillAmount bigint);

--set primary key in Doctor Table
alter table Doctor alter column Did int not null;
alter table Doctor add Primary key(Did);

--set primary key in PatientMaster Table
alter table PatientMaster alter column Pcode int not null;
alter table PatientMaster add primary key(Pcode);

--set primary key in AdmittedPatients
alter table AdmittedPatients alter column Pcode int not null;
alter table AdmittedPatients add primary key(Pcode);

--set primary key in Bill tabel
alter table Bill alter column BillNo int not null;
alter table Bill add Primary key(BillNo);

--add Foreign Key
alter table Bill add foreign key(Pcode) references AdmittedPatients(Pcode);

--Describe all tables
sp_help Doctor;

--Drop priamry key from PatientMaster
alter table PatientMaster drop constraint PK_PatientM_9F96D7D94OFBDE79;


--add descharge_date column AdmittedPatient
alter table AdmittedPatients add Discharge_date date;

--change date type for wardno in AdmittedPatients
alter table AdmittedPatients alter column WardNo varchar(20);

--add primary key to PatientMaster
alter table PatientMaster alter column Pcode int not null;
alter table PatientMaster add Primary key(Pcode);

--insert 5 record in Doctor table
insert into Doctor values(1,'Pune','MBBS',5),(2,'Mumbai','BHMS',4),(3,'Nashik','MD',10),(4,'Nanded','BAMS',6),(5,'Sangli','MD',8);

select*from Doctor;

--FIND the no of doctor as per qualification

select *from Doctor where qualification='MBBS';
select *from Doctor where qualification='BHMS';
select *from Doctor where qualification='BAMS';
select *from Doctor where qualification='MD';

--Written test
--1.write a query to create Employee table.

create table Service_Request(Service_Id int primary key,service_desc varchar(20),request_open_date date,request_closed_date date,charges int,
 cust_id int,Emp_id int,status_id int);

 create table Service_Status(Status_Id int primary key,desc_values int not null,desc_are varchar(10));

 create table Employee(Emp_Id int primary key, ename varchar(20) not null, age int, requestsCompleted varchar(10), emp_rating int);

 create table Customer(Cust_Id int primary key, cname varchar(20) not null, address_line1 varchar(20), address_line2 varchar(20), city varchar(10),
 pin_code int);

 --add forein key
 alter table Service_Request add foreign key(cust_id) references Customer(cust_id);
 alter table Service_Request add foreign key(Emp_id) references Employee(Emp_id);
 alter table Service_Request add foreign key(status_id) references Service_Status(status_id);

 --2.Write a query to add column totalRequests (integer) to customer table 
 alter table Customer add totalRequests int;

 --3.Write single query to create ReqCopy table which will have same structure and data of service_request table.

 select * into ReqCopy from Service_Request;

  select * from Employee; 

  --4.Show customer name, service description, charges	of requests served by employees older than age 30. (make use of sub query)

  select cname from Customer where service_desc in (select service_desc,charges from Service_Request where age=(select age from Employee where age<30));

  --5.	Write a query to select customer names for whom employee ‘John’ has not served any request.(make use of sub query)
  select cname from Customer where cust_id not in(select cust_id from Service_Request where Emp_id=(select Emp_id from Employee where ename='john'));
  