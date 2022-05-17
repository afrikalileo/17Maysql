select pr.FirstName,pr.LastName,hr.BirthDate from Person.Person as pr inner join HumanResources.Employee as hr on pr.BusinessEntityID = hr.BusinessEntityID

select pr.FirstName,pr.LastName,ph.PhoneNumber, pph.Name  from Person.Person as pr 
inner join Person.PersonPhone as ph on pr.BusinessEntityID = ph.BusinessEntityID
inner join person.PhoneNumberType as pph on pph.PhoneNumberTypeID = ph.PhoneNumberTypeID

--  Çalışanın Adı, Soyadı Departmanının Adı (son çalıştığı departman listelenecek)

select pr.FirstName, pr.LastName, hrd.Name from person.Person as pr 
inner join HumanResources.Employee as hre on pr.BusinessEntityID =hre.BusinessEntityID
inner join HumanResources.Department as hrd on hrd.BusinessEntityID = hre.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory as hrh on hrd.DepartmentID = hrh.DepartmentID WHERE hrh.EndDate is null

-- 4

select COUNT(*) from Person.Person as pr
inner join HumanResources.EmployeeDepartmentHistory as hrh on hrh.BusinessEntityID=pr.BusinessEntityID
inner join HumanResources.Department as hrp on hrp.DepartmentID=hrh.DepartmentID
where hrp.Name='finance'

--Satış Soruları 
-- ADET BAZINDA en çok siparişi veren müşterimin Id si,
select top 1 CustomerID,count(SalesOrderID) CountofOrder from Sales.SalesOrderHeader 
group by CustomerID order by CountofOrder desc

-- Bugüne kadar verilmiş en yüksek cirolu sipariş
select top(1) (OrderQty*UnitPrice)from sales.SalesOrderDetail as soh inner join Sales.SalesOrderHeader as sso on soh.SalesOrderID = sso.SalesOrderID
-- Sipariş cirolarımı TerriorityID ye göre grupla. 8, 564.000
select sso.TerritoryID, sum(sso.TotalDue)bolgesiparis from sales.SalesOrderHeader sso group by sso.TerritoryID order by sso.TerritoryID
-- Kaç adet sipariş gecikti?

select COUNT(*) from Sales.SalesOrderHeader where ShipDate > DueDate
-- En çok siparişim hangi bölgeye gecikti ve kaç adet?
select sst.Name,count(*)bolgesiparis1 from Sales.SalesOrderHeader as sso inner join sales.SalesTerritory as sst on sso.TerritoryID = sst.TerritoryID  where ShipDate > DueDate order by bolgesiparis1 desc
-- Vista kredi kartıyla kaç adet sipariş verilmiştir? 

select count(*) from Sales.CreditCard as scd inner join sales.SalesOrderHeader as sso on scd.CreditCardID = sso.CreditCardID 


-- Sipariş hesaplamalaırnda discount kolonu da kullanılacak

select top 1 SUM(sod.OrderQty * (sod.UnitPrice*(1-sod.UnitPriceDiscount))), sod.SalesOrderID from 
Sales.SalesOrderDetail as sod

-- Taşıma Ücreti 50 den düşük siparişlerimi yazdır

Select * from Sales.SalesOrderHeader where Freight < 50