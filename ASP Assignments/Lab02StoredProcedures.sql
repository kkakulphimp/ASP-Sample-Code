use kkakulphimp1_NorthwindNew
go
if exists
(
	select * from sysobjects
	where name = 'GetCustomers'
)
	drop procedure GetCustomers
go

create procedure GetCustomers
@filter varchar(25) = ''
as
select C.CustomerID, CompanyName
from kkakulphimp1_NorthwindNew.dbo.Customers as C
where C.CompanyName like '%' + @filter + '%'
go

if exists
(
	select * from sysobjects
	where name = 'CustCatSummary'
)
	drop procedure CustCatSummary
go

create procedure CustCatSummary
@id nchar(5)
as
select CategoryName as 'Category Name', Sum(OD.Quantity) as 'Total', '$' + cast(convert(varchar, Cast(Sum(Quantity * OD.UnitPrice) as money), 1) as varchar) as 'Costs'
from kkakulphimp1_NorthwindNew.dbo.Customers as C
inner join kkakulphimp1_NorthwindNew.dbo.Orders as O on
C.CustomerID = O.CustomerID
inner join kkakulphimp1_NorthwindNew.dbo.[Order Details] as OD on
O.OrderID = OD.OrderID
inner join kkakulphimp1_NorthwindNew.dbo.Products as P on
OD.ProductID = P.ProductID
inner join kkakulphimp1_NorthwindNew.dbo.Categories as CA on
P.CategoryID = CA.CategoryID
where C.CustomerID = @id
group by CategoryName
order by Sum(OD.Quantity) desc
go

--exec CustCatSummary 'CHOPS'


if exists
(
	select * from sysobjects
	where name = 'DeleteOrderDetails'
)
	drop procedure DeleteOrderDetails
go

create procedure DeleteOrderDetails
@orderID int,
@productID int,
@status varchar(80) output
as
delete from kkakulphimp1_NorthwindNew.dbo.[Order Details]
where kkakulphimp1_NorthwindNew.dbo.[Order Details].OrderID = @orderID 
and kkakulphimp1_NorthwindNew.dbo.[Order Details].ProductID = @productID
if (@@ROWCOUNT > 0)
set @status = 'Record deleted'
else
set @status = 'No record deleted, possible error'
go

--declare @stuff as varchar(80)

--exec DeleteOrderDetails 10259, 21 , @status = @stuff output

--select @stuff
--go

if exists
(
	select * from sysobjects
	where name = 'InsertOrderDetails'
)
	drop procedure InsertOrderDetails
go

create procedure InsertOrderDetails
@OrderID int,
@ProductID int,
@Quantity int,
@Discount float = 0
as
if not exists
(
	select ProductID from kkakulphimp1_NorthwindNew.dbo.Products
	where ProductID = @ProductID
)
	return 0
if not exists
(
	select OrderID from kkakulphimp1_NorthwindNew.dbo.[Order Details]
	where OrderID = @OrderID
)
	return 0
if not exists
(
	select ProductID from kkakulphimp1_NorthwindNew.dbo.[Order Details]
	where OrderID = @OrderID and ProductID = @ProductID
)
begin
declare @price as money
select @price = UnitPrice
from Products
where ProductID = @ProductID
Insert into kkakulphimp1_NorthwindNew.dbo.[Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (@OrderID, @ProductID, @price, @Quantity, @Discount)
end
else
begin
update [Order Details]
set Quantity = @Quantity
where OrderID = @OrderID and ProductID = @ProductID
end
return @@ROWCOUNT
go

--exec InsertOrderDetails 10248, 2, 20
--go
--select * from [Order Details]
--select * from products