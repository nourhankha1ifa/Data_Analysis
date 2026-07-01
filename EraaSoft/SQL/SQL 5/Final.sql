-- tables
select * from Branch;
select * from Customer;
select * from Employee;
select * from Inventory;
select * from [Product];
select * from Sale;
select * from SaleDetails;

-- 1
select [Name] from Customer
where [Name] like 'K%';

-- 2
select ProductName, Price from [Product]
where Price >= 1000;

-- 3
select ProductName, Category from [Product]
where Category = 'Electronics';

-- 4
select ProductName from [Product]
where ProductName like '%desk%';

-- 5
select b.BranchName, count(emp.EmployeeID) as TotalNumOfEmp
from Employee emp
right join Branch b on b.BranchID = emp.BranchID
group by b.BranchID, b.BranchName;

-- 6
select b.BranchName, p.ProductName, i.Quantity
from [Product] p
left join Inventory i on i.ProductID = p.ProductID
left join Branch b on b.BranchID = i.BranchID
group by b.BranchID, b.BranchName, p.ProductName, i.Quantity;

-- 7
select count(CustomerID) as totalCustomers from Customer;

-- 8
select c.[Name], s.SaleDate from Customer c
join Sale s on s.CustomerID = c.CustomerID
where month(s.SaleDate) = 4;

-- 9
select b.BranchName, sum(s.TotalAmount) as TotalRevenue from Sale s
join Branch b on b.BranchID = s.BranchID
group by b.BranchID, b.BranchName;

-- 10
select top 1 
	p.ProductName, sum(sd.Quantity) as TotalQuantity
from SaleDetails sd
join [Product] p on p.ProductID = sd.ProductID
GROUP BY p.ProductName;

-- 11
select emp.[Name], count(s.EmployeeID) as TotalSales
from Employee emp
left join Sale s on s.EmployeeID = emp.EmployeeID
group by s.EmployeeID, emp.[Name]
having s.EmployeeID > 1
order by TotalSales desc;

-- 12
