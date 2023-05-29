create database library;
use library;

#creating Books table
create table Books(book_id int primary key,title varchar(30),author varchar(30),publisher varchar(30),publication_year int,IBSN int,genre char,availability boolean);
alter table Books modify genre varchar(30);
desc Books;
select * from Books;

#creating Borrowers table
create table Borrowers(borrower_id int,name varchar(25),address char,phone_number bigint,email nvarchar(255));
alter table Borrowers modify address varchar(30);
alter table Borrowers add primary key(borrower_id);
desc Borrowers;
select * from Borrowers;

#creating Loans table
create table Loans(loan_id int,book_id int,borrower_id int,date_of_borrowed date,due_date date,date_returned date);
alter table Loans add primary key(loan_id);
alter table Loans add constraint foreign key(book_id) references Books(book_id);
alter table Loans add constraint foreign key(borrower_id) references Borrowers(borrower_id);
desc Loans;
select
#creating Reservations table
create table Reservations(reservation_id int,book_id int,borrower_id int,date_reserved date,date_need date,status varchar(20),constraint chk_Frequency check(status in("active","canceled","expired")));
alter table Reservations add primary key(reservation_id);
alter table Reservations add constraint foreign key(book_id) references Books(book_id);
alter table Reservations add constraint foreign key(borrower_id) references Borrowers(borrower_id);
desc Reservations;
select * from Reservations;


# inserting the data into tables

insert into Books values(1,"Harry potter","dev","sun",2000,1000,"Imaginatioin",true);
insert into Books values(2,"Tenali ramakrishna","seru","mn",1988,1001,"royal",true);
insert into Books values(3,"sindbad and adventures","ali","micros",2002,1002,"Adventure",true);
insert into Books values(4,"Tinkle","div","sun",2003,1004,"humour",true);
select * from Books;

insert into Borrowers values(200,"divya","draksharamam",9041348022,"divya3943@gmail.com");
insert into Borrowers values(201,"deepthi","draksharamam",9486375389,"deepthi3r459ds3@gmail.com");
insert into Borrowers values(202,"priya","srikal",9648399087,"priyaa343a3943@gmail.com");
insert into Borrowers values(203,"uma","venkataya",48468348022,"ch_umaa3943@gmail.com");
insert into Borrowers values(204,"prasanna","annaipet",8596533992,"prasanna343a3943@gmail.com");
select * from Borrowers;

insert into Loans values(100,2,202,'2023-05-03','2023-06-03','2023-05-25');
insert into Loans values(101,1,203,'2023-05-06','2023-06-06','2023-05-15');
insert into Loans values(102,4,201,'2023-04-13','2023-05-13','2023-05-12');
insert into Loans values(105,4,204,'2023-04-13','2023-05-11','2023-05-10');
select * from Loans;

insert into Reservations values(301,2,202,"2023-02-26","2023-05-28","active");
insert into Reservations values(302,4,203,"2023-02-26","2023-04-28","expired");
insert into Reservations values(303,2,201,"2023-04-04","2023-06-01","active");
insert into Reservations values(304,3,202,"2023-05-27","2023-06-03","canceled");
select * from Reservations;

#Queries
#Get all available books
select * from Books where availability=1;

#Get all borrowed books
select Books.title,Books.author,Borrowers.name,Loans.date_of_borrowed,Loans.due_date 
from Books
INNER JOIN  Loans ON Books.book_id=Loans.book_id
INNER JOIN Borrowers on Loans.borrower_id=Borrowers.borrower_id;

#Get all the borrower names
select name from Borrowers;

#Get all reserved books
select Books.title,Books.author,Borrowers.name,Reservations.date_reserved,Reservations.date_need 
from Books 
Inner join Reservations
on Books.book_id=Reservations.book_id
INNER JOIN Borrowers on Borrowers.borrower_id=Reservations.borrower_id;

# Get the names of persons who have not borrowed any book
select Borrowers.name from borrowers 
where Borrowers.borrower_id not in
(select Borrowers.borrower_id from Borrowers 
Inner join Loans 
on Borrowers.borrower_id=Loans.borrower_id);

#count the total number of Reservations done
select count(*) from Reservations;

#Find the not used books till now
select title from Books where book_id not in (select Books.book_id from Books
INNER JOIN Loans
on Books.book_id=Loans.book_id);

#get the book names which are in both the loans and reservations list
select Books.title from Books
where Books.book_id in 
(select Loans.book_id from Loans 
INNER JOIN Reservations
on Loans.book_id=Reservations.book_id);

#find the books which do not have any reservations
select Books.title from Books where Books.book_id not in(
select Books.book_id from Books
INNER JOIN Reservations
on Books.book_id=Reservations.book_id);