USE [master]
GO

if exists (select * from sysdatabases where name='DatabaseAP13AKT')
		drop database DatabaseAP13AKT
go
CREATE DATABASE DatabaseAP13AKT
GO
USE DatabaseAP13AKT
go

CREATE  TABLE [dbo].[Picture](
	[Id] [int] IDENTITY(1,1) NOT NULL Primary Key,
	[IsActive] [bit] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ImagePath] [nvarchar](100)NOT NULL
	)

GO
CREATE TABLE [dbo].[Manufacturer](
	[Id] [int] IDENTITY(1,1) NOT NULL Primary Key,
	[IsActive] [bit] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50)NOT NULL,
	[LastName] [nvarchar](50) NOT NULL)


GO
go


CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL Primary Key,
	[IsActive] [bit] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[TaxRate] [float] NOT NULL)
	
GO




CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL Primary Key,
	[IsActive] [bit] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[NetUnitPrice] [money]NOT NULL,
	[PictureId] [int] NOT NULL REFERENCES [Picture] ON DELETE CASCADE, 
	[Description] [nvarchar](50) NULL,
	[ManufacturerId] [int] NOT NULL REFERENCES [Manufacturer] ON DELETE CASCADE, 
	[CategoryId] [int] NOT NULL REFERENCES [Category] ON DELETE CASCADE, 
	[Size] [int] NULL,
	[Stock] [int] NOT NULL)

GO

CREATE TABLE [dbo].[Customer](
    [Id] [int] IDENTITY(1,1) NOT NULL Primary Key,
    [FirstName] [nvarchar](50) NOT NULL,
    [LastName] [nvarchar](50) NOT NULL,
    [Title] [nvarchar](50) NOT NULL,
    [Email] [nvarchar](50) NOT NULL,
    [Street] [nvarchar](50) NOT NULL,
    [Zip] [nvarchar](50) NOT NULL,
    [City] [nvarchar](50) NOT NULL,
    [PwHash] [binary](50) NOT NULL,
    [Salt] [binary](50) NOT NULL,
    [IsActive] [bit] NOT NULL)
GO

CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL Primary Key,
	[IsActive] [bit] NOT NULL,
	[CustomerId] [int] NOT NULL REFERENCES [Customer] ON DELETE CASCADE, 
	[PriceTotal] [money] NOT NULL,
	[DateOrdered] date NOT NULL,
	[Street] [nvarchar](50) NULL,
	[Zip] [int] NULL,
	[City] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL)


go
CREATE TABLE [dbo].[OrderLine](
	[Id] [int] IDENTITY(1,1) NOT NULL Primary Key,
	[IsActive] [bit] NOT NULL,
	[OrderId] [int] NOT NULL REFERENCES [Order] ON DELETE CASCADE, 
	[ProductId] [int] NOT NULL REFERENCES [Product] ON DELETE CASCADE, 
	[Amount] [int] NOT NULL,
	[NetUnitPrice] [decimal](18, 2) NOT NULL,
	[TaxRate] [float] NOT NULL)
 

GO

 

--Mockdata
INSERT INTO [dbo].[Picture] ([IsActive], [Name], [ImagePath])
VALUES (1, 'Image1', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(1, 'Image2', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(1, 'Image3', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(0, 'Image4', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(1, 'Image5', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(1, 'Image6', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(0, 'Image7', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(1, 'Image8', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(0, 'Image9', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg'),
(1, 'Image10', 'https://img.bildhost.com/file/bildhostcom/2023/01/31/shoes00.jpeg');
go

INSERT INTO [dbo].[Manufacturer]
VALUES
(1, 'Acme Inc.', 'John', 'Doe'),
(1, 'Bravo Corp.', 'Jane', 'Smith'),
(1, 'Charlie LLC', 'Bob', 'Johnson'),
(1, 'Delta Inc.', 'Samantha', 'Williams'),
(1, 'Echo Ltd.', 'William', 'Brown'),
(1, 'Foxtrot GmbH', 'Ashley', 'Jones'),
(1, 'Golf Inc.', 'Michael', 'Miller'),
(1, 'Hotel LLC', 'Emily', 'Davis'),
(1, 'India Inc.', 'Jacob', 'Wilson'),
(1, 'Juliet Ltd.', 'Madison', 'Anderson')
GO
GO


INSERT INTO [dbo].[Category] ([IsActive], [Name], [TaxRate])
VALUES (1, 'Athletic Shoes', 0.085),
(1, 'Dress Shoes', 0.09),
(1, 'Casual Shoes', 0.065),
(0, 'Running Shoes', 0.075),
(1, 'Basketball Shoes', 0.08),
(1, 'Hiking Shoes', 0.07),
(0, 'Sneakers', 0.095),
(1, 'Sandals', 0.0825),
(0, 'Boots', 0.06),
(1, 'Slippers', 0.0875);
go
GO
INSERT INTO [dbo].[Product] ([IsActive], [ProductName], [NetUnitPrice], [PictureId], [Description], [ManufacturerId], [CategoryId], [Size], [Stock])
VALUES (1, 'Product1', 59.99, 1, 'Description1', 1,1, 8, 100),
(1, 'Product2', 49.99, 2, 'Description2', 2, 2, 9, 200),
(1, 'Product3', 79.99, 3, 'Description3', 3, 3, 10, 150),
(0, 'Product4', 49.99, 4, 'Description4', 4, 4, 11, 50),
(1, 'Product5', 59.99, 5, 'Description5', 5, 5, 12, 300),
(1, 'Product6', 69.99, 6, 'Description6', 6, 6, NULL, 250),
(0, 'Product7', 89.99, 7, 'Description7', 7, 7, 14, 100),
(1, 'Product8', 79.99, 8, 'Description8', 8, 8, 15, 200),
(0, 'Product9', 99.99, 9, 'Description9', 9, 9, 16, 150),
(1, 'Product10', 49.99, 10, 'Description10', 10, 10, 17, 75);
go

INSERT INTO [dbo].[Customer]
VALUES
( 'John', 'Doe', 'Mr.', 'john.doe@example.com', '123 Main St.', '12345', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
( 'Jane', 'Doe', 'Ms.', 'jane.doe@example.com', '456 Elm St.', '67890', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
( 'Bob', 'Smith', 'Mr.', 'bob.smith@example.com', '789 Oak Ave.', '11111', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
('Samantha', 'Jones', 'Ms.', 'samantha.jones@example.com', '246 Pine St.', '22222', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
( 'William', 'Brown', 'Mr.', 'william.brown@example.com', '369 Maple Rd.', '33333', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
( 'Ashley', 'Johnson', 'Ms.', 'ashley.johnson@example.com', '159 Cedar Blvd.', '44444', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
( 'Michael', 'Davis', 'Mr.', 'michael.davis@example.com', '753 Pine St.', '55555', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
('Emily', 'Anderson', 'Ms.', 'emily.anderson@example.com', '951 Oak Ave.', '66666', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
( 'Jacob', 'Thomas', 'Mr.', 'jacob.thomas@example.com', '147 Maple Rd.', '77777', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1),
( 'Madison', 'Jackson', 'Ms.', 'madison.jackson@example.com', '258 Cedar Blvd.', '88888', 'Anytown', 0x0123456789ABCDEF0123456789ABCDEF01234567, 0x0123456789ABCDEF, 1)
GO

INSERT INTO [dbo].[Order]
VALUES
(1, 1, 123.45, '2022-01-01', '123 Main St', 12345, 'Anytown', 'John', 'Doe'),
(1, 2, 456.78, '2022-02-01', '456 Main St', 67890, 'Anytown', 'Jane', 'Smith'),
(1, 3, 789.01, '2022-03-01', '789 Main St', 24680, 'Anytown', 'Bob', 'Johnson'),
(1, 4, 234.56, '2022-04-01', '234 Main St', 13579, 'Anytown', 'Samantha', 'Williams'),
(1, 5, 567.89, '2022-05-01', '567 Main St', 98765, 'Anytown', 'William', 'Brown'),
(1, 6, 890.12, '2022-06-01', '890 Main St', 43210, 'Anytown', 'Ashley', 'Jones'),
(1, 7, 345.67, '2022-07-01', '345 Main St', 65432, 'Anytown', 'Michael', 'Miller'),
(1, 8, 678.90, '2022-08-01', '678 Main St', 17654, 'Anytown', 'Emily', 'Davis'),
(1, 9, 123.45, '2022-09-01', '123 Main St', 23456, 'Anytown', 'Jacob', 'Wilson'),
(1, 10, 456.78, '2022-10-01', '456 Main St', 65489, 'Anytown', 'Madison', 'Anderson')


INSERT INTO [dbo].[OrderLine] ([IsActive], [OrderId], [ProductId], [Amount], [NetUnitPrice], [TaxRate])
VALUES (1, 1, 2, 2, 59.99, 0.085),
(1, 2, 1, 3, 49.99, 0.09),
(1, 3, 2, 1, 79.99, 0.065),
(0, 4, 3, 5, 49.99, 0.075),
(1, 5, 4, 4, 59.99, 0.08),
(1, 6, 5, 2, 69.99, 0.07),
(0, 7, 6, 1, 89.99, 0.095),
(1, 8, 7, 3, 79.99, 0.0825),
(0, 9, 8, 2, 99.99, 0.06),
(1, 10, 9, 1, 49.99, 0.0875);


