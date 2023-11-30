-- SQL Project :-  Finance Analysis
-- Description  
   -- This is a Finance Analysis SQL Project as a Finance Analyst for 'The Big Bank' and the task is finding out about 
   --  the customers and their banking behavior. You also have to examine the accounts they hold and the type of transactions 
    -- they make to develop greater insight into your customers.
    
    -- Script to create and insert data : 
    
Create Database Finance_analysis;
use Finance_analysis;

-- Create the customers table
create table customers (
                     customerid int primary key,
                     firstName varchar(50),
                      lastName varchar(50),
                     city VARCHAR(50),
					state VARCHAR(2));
                    desc customers;
                    select* from customers;
                    
-- Populate the Customers Table
Insert into customers
          ( CustomerID,firstname,lastname,city,state)
values( 1,'John','Doe','New York','NY'),
	   ( 2,'Jane','Doe','New York','NY'),
       (3,'Bob','Smith','San Francisco','CA'),
       (4,'Alice','Johnson','San Francisco','CA'),
       (5,'Michael','lee','los Angeles','CA'),
       (6,'Jennifer','Wang','Los Angeles','CA');
       
-- Create the Branches Table
create table branches( 
                    BranchID int primary key,
                   BranchName varchar(50),
                   City varchar(50),
				   State varchar(2)
);
INSERT INTO Branches (BranchID, BranchName, City, State)
VALUES(1, 'Main', 'New York', 'NY'),
       (2, 'Downtown', 'San Francisco', 'CA'),
       (3, 'West LA', 'Los Angeles', 'CA'),
		(4, 'East LA', 'Los Angeles', 'CA'),
        (5, 'Uptown', 'New York', 'NY'),
        (6, 'Financial District', 'San Francisco', 'CA'),
	     (7, 'Midtown', 'New York', 'NY'),
        (8, 'South Bay', 'San Francisco', 'CA'),
        (9, 'Downtown', 'Los Angeles', 'CA'),
        (10, 'Chinatown', 'New York', 'NY'),
        (11, 'Marina', 'San Francisco', 'CA'),
        (12, 'Beverly Hills', 'Los Angeles', 'CA'),
        (13, 'Brooklyn', 'New York', 'NY'),
        (14, 'North Beach', 'San Francisco', 'CA'),
        (15, 'Pasadena', 'Los Angeles', 'CA');
select * from branches;

-- create the accounts table
Create Table Accounts( 
                      AccountID Int Primary key,
                      CustomerId int,
                      BranchId int,
                      AccountType Varchar(50),
                      Balance Decimal(10,2),
                      foreign key(customerId) references customers(CustomerId),
                      foreign key(branchId) references branches(branchId));
           
-- Populate the Accounts Table
INSERT INTO Accounts (AccountID, CustomerID, BranchID, AccountType, Balance)
VALUES (1, 1, 5, 'Checking', 1000.00),
(2, 1, 5, 'Savings', 5000.00),
(3, 2, 1, 'Checking', 2500.00),
(4, 2, 1, 'Savings', 10000.00),
(5, 3, 2, 'Checking', 7500.00),
(6, 3, 2, 'Savings', 15000.00),
(7, 4, 8, 'Checking', 5000.00),
(8, 4, 8, 'Savings', 20000.00),
(9, 5, 14, 'Checking', 10000.00),
(10, 5, 14, 'Savings', 50000.00),
(11, 6, 2, 'Checking', 5000.00),
(12, 6, 2, 'Savings', 10000.00),
(13, 1, 5, 'Credit Card', -500.00),
(14, 2, 1, 'Credit Card', -1000.00),
(15, 3, 2, 'Credit Card', -2000.00);
select * from accounts;

-- Create The Transactions table
CREATE TABLE Transactions (
    TransactionID int primary key,
    AccountID int,
    TransactionDate DATE,
    Amount decimal(10,2),
    foreign key  (AccountID)
        references Accounts (AccountID)
);

-- Populate the Transactions Table
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount)
VALUES (1, 1, '2022-01-01', -500.00),
(2, 1, '2022-01-02', -250.00),
(3, 2, '2022-01-03', 1000.00),
(4, 3, '2022-01-04', -1000.00),
(5, 3, '2022-01-05', 500.00),
(6, 4, '2022-01-06', 1000.00),
(7, 4, '2022-01-07', -500.00),
(8, 5, '2022-01-08', -2500.00),
(9, 6, '2022-01-09', 500.00),
(10, 6, '2022-01-10', -1000.00),
(11, 7, '2022-01-11', -500.00),
(12, 7, '2022-01-12', -250.00),
(13, 8, '2022-01-13', 1000.00),
(14, 8, '2022-01-14', -1000.00),
(15, 9, '2022-01-15', 500.00);

select * from customers;
select * from branches;
select * from accounts;
select * from transactions;

-- 1. What are the names of all the customers who live in New York?
      select firstname,lastname 
      from customers
      where city = 'New York'
      group by firstname,lastname;

-- 2. What is the total number of accounts in the Accounts table?
     select count(distinct AccountID) as total_no_of_accounts 
     from Accounts;
     
-- 3. What is the total balance of all checking accounts?
     select sum(balance) as total_balance from accounts where accounttype ='checking';
     
-- 4. What is the total balance of all accounts associated with customers who live in Los Angeles?
      select sum(balance) total_balance from accounts a
      join customers c on a.customerId =c.customerid
      where city = 'los angeles';
      
-- 5. Which branch has the highest average account balance?
	select b.branchname,avg(a.balance) as avg_account_balance
    from branches b
    Join Accounts a on b.branchid = a.branchid
    group by b.branchname
    order by avg_account_balance 
    limit 1;
    
    
     select * from accounts;
    select * from customers;
    
-- 6. Which customer has the highest current balance in their accounts?
     select c.customerid,c.firstname,c.lastname, sum(a.balance)as current_balance
     from customers c
     JOIN accounts a ON c.customerid = a.customerid
     group by c.customerid,c.firstname,c.lastname
     order by current_balance desc
     limit 1;
   
   select * from customers;
   select * from transactions;
   select * from accounts;
-- 7. Which customer has made the most transactions in the Transactions table?
     select c.customerid,c.firstname,c.lastname, count(t.transactionid) as no_of_transactions
     from customers c
     JOIN accounts a ON c.customerid = a.accountid
     JOIN transactions t ON a.accountid = t.accountid
     group by c.customerid,c.firstname,c.lastname
     order by no_of_transactions DESC
     Limit 1;
     
-- 8.Which branch has the highest total balance across all of its accounts?
     select b.branchname,sum(a.balance) as total_balance
     from branches b
     JOIN accounts a ON b.branchid = a.branchid
     group by b.branchname
     order by total_balance DESC
     LIMIT 1;
	
-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
     select c.customerid,c.firstname,c.lastname,sum(a.balance) total_balance
     from customers c
     JOIN Accounts a ON c.customerid = a.customerid
     where a.accounttype in ('checking','savings')
     group by c.customerid,c.firstname,c.lastname
     order by total_balance desc
     Limit 1;

-- 10. Which branch has the highest number of transactions in the Transactions table?
     select b.branchname, count(distinct t.transactionid) as no_of_transactions
     from branches b
     JOIN accounts a ON b.branchid = a.branchid
     JOIN Transactions t ON a.accountid = t.accountid
     group by b.branchname 
     order by no_of_transactions DESC
     Limit 1;
     



