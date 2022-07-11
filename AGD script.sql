create database AGD
GO
use AGD
GO
create table tblAuthors (authorID int identity(1,1) primary key, fName nvarchar(50), lName nvarchar(50), style nvarchar(50))
GO
create table tblPaintings(paintingID int identity(1,1) primary key, authorID int, title nvarchar(50), style nvarchar(50), [description] nvarchar(100))
GO
create table tblEstimatedValue(refernceID int identity (1,1) primary key, paintingID int, previousOwnerNo int not null, conditionOf decimal (5, 2) not null, authenticity bit not null, price decimal (10, 2)) 
GO

alter function priceOf (
	@previousOwnerNo int,
	@conditionOf decimal (5, 2), 
	@authenticity bit
)
returns decimal(8, 2) 
as begin
declare @price decimal(10, 2) = 0.00

if @previousOwnerNo < 2 set @price = 1000.00
else
set @price = 100.00

if @conditionOf > 85.00 set @price = @price + 9000.00
else set @price = @price + 4500.00

if @authenticity = 1 set @price = @price + 10000.00
else set @price = @price + 0.00

return @price

end


GO

alter procedure sp_EstimateValue @paintingID int, @previousOwnerNo int, @conditionOf decimal (5, 2), @authenticity bit
as begin 
insert into tblEstimatedValue (paintingID, previousOwnerNo, conditionOf, authenticity, price)
select @paintingID, @previousOwnerNo, @conditionOf, @authenticity, (select dbo.priceOf(@previousOwnerNo, @conditionOf, @authenticity) as price)
end
GO
select * from tblEstimatedValue

GO
create procedure sp_insertAuthors @fName nvarchar(50), @lName nvarchar(50), @style nvarchar(50) 
as begin
insert into tblAuthors (fName, lName, style)
select @fName, @lName, @style
end
GO

alter procedure sp_insertPaintings @authorID int, @title nvarchar(50), @style nvarchar(50), @description nvarchar(100)
as begin
insert into tblPaintings (authorID, title, style, [description])
select @authorID, @title, @style, @description
end

GO
exec sp_insertAuthors 'Georgia', 'O''Kieeffe', 'Precisionism'
GO
exec sp_insertPaintings 1, 'Red Canna', 'Precisionism', 'NULL' 
GO
exec sp_EstimateValue 4, 1, 36.58, 1
GO
select * from tblAuthors
GO
select * from tblPaintings
GO
select * from tblEstimatedValues

GO

Select tblAuthors.authorID, tblAuthors.fname, tblAuthors.lname, tblPaintings.title from tblAuthors 
inner join tblPaintings
on tblAuthors.authorID = tblPaintings.authorID
GO


Select tblPaintings.title, tblEstimatedValue.price, tblPaintings.authorID
from tblPaintings 
inner join tblEstimatedValue
on tblPaintings.paintingID = tblEstimatedValue.paintingID

GO



backup database ArtGalleryDatabase to disk = 'C:\Users\xxxxxxx\backup_dat.bak'
