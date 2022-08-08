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
 
  --4.Show customer name, service description, charges	of requests served by employees older than age 30. (make use of sub query)

	 select cname from Customer where Cust_Id in (select Cust_Id from Service_Request where Emp_id in(select age from Employee where age<30));

  --5.	Write a query to select customer names for whom employee ‘John’ has not served any request.(make use of sub query)
	select cname from Customer where cust_id not in(select cust_id from Service_Request where Emp_id=(select Emp_id from Employee where ename='john'));
  
  select * from Service_Status;
  
  --6.Show employee name, total charges of all the requests served by that employee. Consider only ‘closed’ requests.
  select ename from employee where ename in(select ename from Service_Status where desc_are in(select desc_are from Service_Status where desc_are='Closed'));
  
 
  --9.Delete all cancelled requests from request table.
  delete Service_Request where status_id in(select status_id from Service_Status where desc_are='closed');





  
 

  --1.Write a query to create Student and Score table.
  create table Statuss(statusid int primary key,descvalue int not null, descare varchar(20));

  create table Students(studid int primary key,sname varchar(20) not null,mobile bigint,batchid int,statusid int foreign key REFERENCES Statuss(statusid),yearofpass date);
  
  create table Score(studid int,testdate date,topic varchar(20),marksobtained int);

  create table Attendence(studid int foreign key REFERENCES Students(studid),adate date,present varchar(10) not null);
  
  create table Batch(batchid int primary key,bname varchar(20) not null,teacherid int );

  create table Teacher(teacherid int primary key,tname varchar(20) not null);

  --2.Write a query to add column Qualification to Student table. ( Assume it was not present earlier)– add qualification column after status id

  alter table Students add qualification varchar(10);

  --3.Write single query to create StudentCopy table which will have same structure and data of table.
  select * into StudentCopy from Students;

  --4.List all studentsname from july2018 who were absent for test on 18Aug2018.
  select sname from Students s inner join Batch b on s.batchid=b.batchid inner join Attendence a on a.studid=s.studid where adate='18-aug-2018' and present='No';

 -- 5.	Update record of student Mithilesh from July2018 batch to Aug2018.Batch id of both batches is not known.
  update Students set banme=Aug2018 inner join Batch on where bname=null;

  --7.	List all Students from July2018 whose qualification is “BE” and year of passing is 2018.
  select * from Students s  inner join Batch b on s.batchid=b.batchid where yearofpass=2018;

  --8.List student name ,topic and topic wise marks of each student from July2018 batch.
  select sname from Students s inner join Score c on s.studid=c.studid inner join Batch b  on s.batchid=b.batchid where bname='july2018';

  --9.	Display batchname and Batchwise Placed student count for all batches from which less than 5 students are placed.
  select bname,count(*) from Batch group by batchid having count(*)<=5;

  --10.	Display top 3 students from july2018 batch with least attendance.
  select top(3) from Students where studid=(select studid from Batch  where bname=2018);

  --11.	Delete all records of those students from attendance who are ‘PLACED’
  delete Students 

  --12.	Delete all records of students whose average marks are less than 50.
  delete Students where studid=(select studid from Score where marksobtained<=50);

  --13.	Create a view to which shows sid name batchname. 
  Create View vk as select studid,sname from Students s inner join Batch b on s.batchid=b.batchid;
  
  --14.	Create index so that retrieval of records is faster when retrieved based on status id
  create index idxs on Statuss(statusid);

  --15.	Give one example of left outer join using above database.
  select sname from Students s left join Batch b on s.batchid=b.batchid;