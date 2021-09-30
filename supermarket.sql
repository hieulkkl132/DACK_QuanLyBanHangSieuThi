-- 2021-09-18
-- author: Buu Duong Tan

DROP DATABASE IF EXISTS supermarket
GO
CREATE DATABASE supermarket
GO
USE supermarket
GO

DROP TABLE IF EXISTS LoginTypes
GO
CREATE TABLE LoginTypes (
	LoginTypeID int IDENTITY(1, 1) NOT NULL,
	LoginTypeName nvarchar(100) NOT NULL,

	PRIMARY KEY(LoginTypeID)
)
GO

DROP TABLE IF EXISTS Logins
GO
CREATE TABLE Logins (
	LoginID int IDENTITY(1, 1) NOT NULL,
	LoginTypeID int NOT NULL,
	Username nvarchar(100) NOT NULL,
	Password nvarchar(100) NOT NULL,

	PRIMARY KEY(LoginID),
	FOREIGN KEY(LoginTypeID) REFERENCES LoginTypes(LoginTypeID)
)
GO

DROP TABLE IF EXISTS Positions
GO
CREATE TABLE Positions (
	PositionID int IDENTITY(1, 1) NOT NULL,
	PositionName nvarchar(100) NOT NULL,

	PRIMARY KEY(PositionID)
)
GO

DROP TABLE IF EXISTS Employees
GO
CREATE TABLE Employees (
	EmployeeID int IDENTITY(1, 1) NOT NULL,
	LoginID int,
	LastName nvarchar(100) NOT NULL,
	FirstName nvarchar(100) NOT NULL,
	PositionID int,
	BirthDate date NOT NULL,
	Address nvarchar(100) NOT NULL,
	City nvarchar(100) NOT NULL,
	District nvarchar(100) NOT NULL,
	Phone nvarchar(100),
	Email nvarchar(100),

	PRIMARY KEY(EmployeeID),
	FOREIGN KEY(LoginID) REFERENCES Logins(LoginID),
	FOREIGN KEY(PositionID) REFERENCES Positions(PositionID)
)
GO

DROP TABLE IF EXISTS Categories
GO
CREATE TABLE Categories (
	CategoryID int IDENTITY(1, 1) NOT NULL,
	CategoryName nvarchar(100) NOT NULL,

	PRIMARY KEY(CategoryID)
)
GO

DROP TABLE IF EXISTS Products
GO
CREATE TABLE Products (
	ProductID int IDENTITY(1, 1) NOT NULL,
	ProductName nvarchar(100) NOT NULL,
	CategoryID int NOT NULL,
	QuantityPerUnit int NOT NULL,
	UnitPrice float NOT NULL,
	UnitsInStock int NOT NULL,
	Active smallint NOT NULL,

	PRIMARY KEY(ProductID),
	FOREIGN KEY(CategoryID) REFERENCES Categories(CategoryID)
)
GO

DROP TABLE IF EXISTS Suppliers
GO
CREATE TABLE Suppliers (
	SupplierID int IDENTITY(1, 1) NOT NULL,
	CompanyName nvarchar(100) NOT NULL,
	Contact nvarchar(100) NOT NULL,
	ContactTitle nvarchar(100) NOT NULL,
	Address nvarchar(100) NOT NULL,
	City nvarchar(100) NOT NULL,
	District nvarchar(100) NOT NULL,
	Phone nvarchar(10),
	Fax nvarchar(100)

	PRIMARY KEY(SupplierID)
)
GO

DROP TABLE IF EXISTS Importations
GO
CREATE TABLE Importations (
	ImportID int IDENTITY(1, 1) NOT NULL,
	SupplierID int NOT NULL,
	EmployeeID int NOT NULL,
	ImportWay nvarchar(100) NOT NULL,
	Freight float NOT NULL,

	PRIMARY KEY(ImportID),
	FOREIGN KEY(SupplierID) REFERENCES Suppliers(SupplierID),
	FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID)
)
GO

DROP TABLE IF EXISTS ImportationDetails
GO
CREATE TABLE ImportationDetails (
	ImportID int NOT NULL,
	ProductID int NOT NULL,
	ImportDate date NOT NULL,
	ImportUnits int NOT NULL,
	UnitPrice float NOT NULL,

	PRIMARY KEY(ImportID, ProductID, ImportDate),
	FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
)
GO

DROP TABLE IF EXISTS Members
GO
CREATE TABLE Members (
	MemberID int IDENTITY(1, 1) NOT NULL,
	JoinDate date NOT NULL,
	Rank nvarchar(100) NOT NULL,
	Point int NOT NULL,

	PRIMARY KEY(MemberID)
)
GO

DROP TABLE IF EXISTS Customers
GO
CREATE TABLE Customers (
	CustomerID int IDENTITY(1, 1) NOT NULL,
	MemberID int,
	LastName nvarchar(100) NOT NULL,
	FirstName nvarchar(100) NOT NULL,
	BirthDate date NOT NULL,
	Address nvarchar(100) NOT NULL,
	City nvarchar(100) NOT NULL,
	District nvarchar(100) NOT NULL,
	Phone nvarchar(100),
	Email nvarchar(100),

	PRIMARY KEY(CustomerID),
	FOREIGN KEY(MemberID) REFERENCES Members(MemberID)
)
GO

DROP TABLE IF EXISTS Receipts
GO
CREATE TABLE Receipts (
	ReceiptID int IDENTITY(1, 1) NOT NULL,
	EmployeeID int NOT NULL,
	CustomerID int NOT NULL,
	ReceiveDate date NOT NULL,
	ReceiveMethod nvarchar(100) NOT NULL,

	PRIMARY KEY(ReceiptID),
	FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID),
	FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
)
GO

DROP TABLE IF EXISTS ReceiptDetails
GO
CREATE TABLE ReceiptDetails (
	ReceiptID int NOT NULL,
	ProductID int NOT NULL,
	UnitPrice float NOT NULL,
	Quantity int NOT NULL,
	Discount float,

	PRIMARY KEY(ReceiptID, ProductID),
        FOREIGN KEY(ReceiptID) REFERENCES Receipts(ReceiptID),
	FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
)
GO

DROP TABLE IF EXISTS Promotions
GO
CREATE TABLE Promotions (
	PromotionID int IDENTITY(1, 1) NOT NULL,
	PromotionName nvarchar(100) NOT NULL,
	Description nvarchar(100),

	PRIMARY KEY(PromotionID)
)
GO

DROP TABLE IF EXISTS Events
GO
CREATE TABLE Events (
	PromotionID int NOT NULL,
	ProductID int NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	LimitQuantity int,
	Discount float NOT NULL,
	Description nvarchar(100),

	PRIMARY KEY(PromotionID, ProductID, StartDate),
	FOREIGN KEY(PromotionID) REFERENCES Promotions(PromotionID),
	FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
)
GO
--STORED PROCEDURE HERE !!!___________________________________________________________________________

Create PROCEDURE DPromotion
@Promotion_ID int
AS
BEGIN
	   Set nocount on
	   declare @R int;
       delete from Events where PromotionId=@Promotion_ID;
       delete from Promotions where PromotionID=@Promotion_ID;
      if (@@ROWCOUNT > 0) select @R = 1;
	  else select @R = 0;
	  select @R as alias
END
GO

CREATE PROC spCheckExistedUsername(@username nvarchar(100)) -- 1851010015-DuongTanBuu
AS
BEGIN
        SET NOCOUNT ON
	DECLARE @result int
        SET @result = 0

	SELECT
		@result = COUNT(Username)
	FROM
		Logins
	WHERE
		Username = @username

	SELECT @result
END
GO

--____________________________________________________________________________________________________
INSERT INTO Positions(PositionName)
	VALUES(N'manager'),
          (N'security'),
          (N'custodian'),
          (N'stock clerk'),
          (N'HR'),
          (N'receiving'),
          (N'IT'),
          (N'product specialist'),
          (N'cart attendant'),
          (N'cashier')
GO
INSERT INTO LoginTypes(LoginTypeName)
	VALUES(N'manager'),
	      (N'staff')
GO
INSERT INTO Logins(LoginTypeID, Username, Password)
	VALUES(1, N'buu', N'buu'),
          (1, N'phi', N'phi'),
          (1, N'hieu', N'hieu'),
          (1, N'bao', N'bao'),
          (2, N'dat', N'dat')
GO
INSERT INTO Employees(LoginID, LastName, FirstName, PositionID, BirthDate, Address, City, District, Phone, Email)
	VALUES(1, N'Duong Tan', N'Buu', 1, '2000-07-03', N'some where on Earth', N'Ho Chi Minh', N'6', N'0909122344', N'1851010015buu@ou.edu.vn'),
          (2, N'Diep Hoang', N'Phi', 1, '2000-01-01', N'some where on Earth', N'Quang Ngai', N'Go Vap', N'0909122344', N'1851010097phi@ou.edu.vn'),
          (3, N'Bui Xuan', N'Hieu', 1, '2000-01-01', N'some where on Earth', N'Ho Chi Minh', N'Go Vap', N'0909122344', N'1851010045hieu@ou.edu.vn'),
          (4, N'Tran Kim', N'Bao', 1, '2000-01-01', N'some where on Earth', N'Ho Chi Minh', N'Go Vap', N'0909122344', N'1851010014bao@ou.edu.vn'),
          (5, N'Dao Tien', N'Dat', 2, '2000-01-01', N'some where in North', N'Hai Phong', N'Go Vap', N'0909122344', N'1851010023dat@ou.edu.vn')
GO
--____________________________________________________________________________________________________
INSERT INTO Categories(CategoryName)
VALUES
	(N'GXFNC'),
	(N'XQTWH'),
	(N'TOHXU'),
	(N'SBDJP'),
	(N'GPWGU'),
	(N'MAGYH'),
	(N'HZMNI'),
	(N'YEJAY'),
	(N'FVOJV'),
	(N'AASUW'),
	(N'JBUQR'),
	(N'VOUYK'),
	(N'EUUHA'),
	(N'ONXTD'),
	(N'UTRBG'),
	(N'XGHSJ'),
	(N'HVWRZ'),
	(N'VDDJU'),
	(N'GKHLM'),
	(N'YLEVF')
GO
INSERT INTO Members(JoinDate, Rank, Point) 
VALUES
	(N'2019-04-04', N'platinum', 5902),
	(N'2017-09-13', N'economic', 3303),
	(N'2020-05-27', N'bronze', 4048),
	(N'2007-03-20', N'economic', 7967),
	(N'2004-11-19', N'gold', 2084),
	(N'2018-06-09', N'platinum', 2067),
	(N'2021-03-27', N'platinum', 7065),
	(N'2018-02-22', N'economic', 6884),
	(N'2013-11-28', N'silver', 2475),
	(N'2005-04-23', N'silver', 4718),
	(N'2015-11-11', N'bronze', 7979),
	(N'2017-06-15', N'bronze', 2035),
	(N'2005-11-26', N'gold', 9702),
	(N'2008-05-12', N'gold', 4629),
	(N'2006-04-08', N'economic', 3369),
	(N'2014-05-16', N'economic', 9236),
	(N'2000-08-15', N'gold', 647),
	(N'2004-06-10', N'silver', 1210),
	(N'2005-12-24', N'gold', 9450),
	(N'2000-02-24', N'gold', 3083),
	(N'2018-11-18', N'platinum', 1670),
	(N'2006-04-13', N'economic', 3494),
	(N'2001-04-28', N'economic', 1689),
	(N'2002-12-06', N'economic', 6303),
	(N'2012-10-20', N'platinum', 5309),
	(N'2000-11-23', N'economic', 6412),
	(N'2016-06-17', N'gold', 2374),
	(N'2018-04-28', N'bronze', 263),
	(N'2018-07-04', N'bronze', 7766),
	(N'2004-09-13', N'platinum', 1603),
	(N'2009-06-04', N'economic', 51),
	(N'2001-02-20', N'economic', 1566),
	(N'2015-06-06', N'silver', 6584),
	(N'2013-11-10', N'silver', 4146),
	(N'2007-11-04', N'gold', 975),
	(N'2015-06-10', N'economic', 8356),
	(N'2011-06-01', N'bronze', 7957),
	(N'2012-07-20', N'economic', 3937),
	(N'2004-02-15', N'economic', 5748),
	(N'2003-11-04', N'platinum', 514),
	(N'2017-12-21', N'platinum', 445),
	(N'2013-04-29', N'bronze', 6705),
	(N'2003-02-24', N'silver', 4243),
	(N'2017-04-10', N'gold', 8423),
	(N'2018-08-10', N'bronze', 7248),
	(N'2005-10-06', N'silver', 3395),
	(N'2008-06-22', N'gold', 2533),
	(N'2014-08-28', N'bronze', 7075),
	(N'2010-10-22', N'gold', 9922),
	(N'2016-08-13', N'platinum', 1743),
	(N'2011-08-11', N'platinum', 6459),
	(N'2002-03-07', N'silver', 5779),
	(N'2001-10-15', N'platinum', 4440),
	(N'2008-08-30', N'platinum', 7914),
	(N'2000-06-14', N'bronze', 401),
	(N'2014-03-26', N'gold', 7792),
	(N'2020-06-07', N'economic', 4038),
	(N'2003-05-01', N'platinum', 8995),
	(N'2006-03-05', N'bronze', 207),
	(N'2002-03-14', N'economic', 9534),
	(N'2020-08-24', N'silver', 6855),
	(N'2020-11-29', N'bronze', 3994),
	(N'2019-06-12', N'silver', 4324),
	(N'2000-01-14', N'silver', 1365),
	(N'2005-06-27', N'economic', 9237),
	(N'2001-08-26', N'platinum', 8517),
	(N'2013-09-13', N'economic', 6848),
	(N'2006-01-11', N'bronze', 3232),
	(N'2007-04-16', N'platinum', 1441),
	(N'2012-12-06', N'economic', 5015),
	(N'2021-01-26', N'gold', 2740),
	(N'2010-03-23', N'economic', 3935),
	(N'2004-03-02', N'platinum', 9719),
	(N'2012-07-20', N'gold', 6446),
	(N'2004-06-08', N'bronze', 2020),
	(N'2012-05-23', N'bronze', 6008),
	(N'2020-01-10', N'platinum', 9141),
	(N'2020-12-07', N'silver', 9513),
	(N'2019-08-18', N'gold', 8002),
	(N'2011-08-27', N'platinum', 8996),
	(N'2018-11-25', N'bronze', 8120),
	(N'2019-02-24', N'bronze', 6639),
	(N'2020-05-04', N'gold', 1777),
	(N'2004-05-11', N'platinum', 2443),
	(N'2015-05-15', N'gold', 7261),
	(N'2014-12-21', N'gold', 9564),
	(N'2020-03-31', N'silver', 3596),
	(N'2007-03-11', N'economic', 1710),
	(N'2004-11-26', N'economic', 7632),
	(N'2013-07-30', N'platinum', 573),
	(N'2018-03-03', N'platinum', 2640),
	(N'2001-07-12', N'silver', 4311),
	(N'2003-12-22', N'silver', 1178),
	(N'2013-08-23', N'platinum', 1862),
	(N'2005-12-15', N'silver', 540),
	(N'2009-03-25', N'economic', 2403),
	(N'2016-10-25', N'silver', 4782),
	(N'2003-02-15', N'platinum', 2252),
	(N'2013-03-06', N'gold', 7838),
	(N'2017-05-29', N'bronze', 6353),
	(N'2009-10-18', N'gold', 6697),
	(N'2021-08-08', N'silver', 6521),
	(N'2011-05-12', N'platinum', 4141),
	(N'2005-11-26', N'gold', 2720),
	(N'2001-04-26', N'economic', 5528),
	(N'2021-07-14', N'silver', 3808),
	(N'2020-06-21', N'economic', 3012),
	(N'2003-08-30', N'economic', 5740),
	(N'2008-06-29', N'platinum', 9928),
	(N'2014-06-04', N'silver', 9928),
	(N'2016-01-31', N'silver', 1145),
	(N'2007-05-02', N'bronze', 9609),
	(N'2014-07-01', N'gold', 8875),
	(N'2001-04-13', N'economic', 6126),
	(N'2007-12-30', N'bronze', 8153),
	(N'2016-06-20', N'silver', 2249),
	(N'2020-10-06', N'bronze', 4627),
	(N'2018-09-28', N'gold', 7276),
	(N'2005-03-26', N'silver', 3846),
	(N'2018-12-19', N'silver', 3516),
	(N'2000-12-04', N'bronze', 9074),
	(N'2008-12-30', N'platinum', 2534),
	(N'2010-07-28', N'gold', 8983),
	(N'2007-04-20', N'gold', 570),
	(N'2001-07-07', N'platinum', 6852),
	(N'2004-03-19', N'platinum', 5646),
	(N'2009-01-22', N'platinum', 6969),
	(N'2018-08-03', N'silver', 6445),
	(N'2018-01-17', N'gold', 3683),
	(N'2002-05-19', N'bronze', 1181),
	(N'2020-10-14', N'bronze', 2908),
	(N'2002-06-26', N'bronze', 2523),
	(N'2019-03-06', N'bronze', 3192),
	(N'2000-07-20', N'gold', 5755),
	(N'2008-07-24', N'silver', 329),
	(N'2007-04-12', N'silver', 5295),
	(N'2008-06-01', N'silver', 6630),
	(N'2020-11-16', N'gold', 7574),
	(N'2017-05-26', N'platinum', 7865),
	(N'2020-09-01', N'bronze', 8037),
	(N'2017-07-24', N'platinum', 9526),
	(N'2011-05-30', N'economic', 5549),
	(N'2008-03-19', N'platinum', 5667),
	(N'2002-06-13', N'economic', 6485),
	(N'2003-02-23', N'silver', 7210),
	(N'2009-08-23', N'gold', 1616),
	(N'2014-10-16', N'silver', 1398),
	(N'2005-10-02', N'gold', 16),
	(N'2005-10-31', N'silver', 5874),
	(N'2011-05-19', N'silver', 9597),
	(N'2020-06-02', N'gold', 3810),
	(N'2007-04-09', N'platinum', 6893),
	(N'2002-06-16', N'silver', 3501),
	(N'2011-02-02', N'bronze', 6917),
	(N'2002-12-15', N'platinum', 320),
	(N'2003-06-30', N'economic', 8182),
	(N'2004-06-24', N'bronze', 9943),
	(N'2009-05-29', N'bronze', 8422),
	(N'2011-01-05', N'bronze', 122),
	(N'2000-03-24', N'platinum', 8827),
	(N'2010-07-11', N'bronze', 7293),
	(N'2010-06-18', N'platinum', 2137),
	(N'2011-03-10', N'bronze', 4967),
	(N'2011-11-30', N'economic', 6605),
	(N'2018-07-31', N'silver', 978),
	(N'2018-02-07', N'economic', 8890),
	(N'2002-05-18', N'silver', 5211),
	(N'2003-07-25', N'gold', 8722),
	(N'2000-09-23', N'silver', 3917),
	(N'2021-07-27', N'silver', 3898),
	(N'2002-05-18', N'economic', 3312),
	(N'2004-05-25', N'bronze', 1609),
	(N'2020-09-06', N'silver', 1716),
	(N'2007-01-07', N'silver', 9833),
	(N'2006-10-14', N'platinum', 2914),
	(N'2017-01-22', N'silver', 6059),
	(N'2004-07-17', N'bronze', 8073),
	(N'2006-03-06', N'gold', 102),
	(N'2016-03-18', N'economic', 3187),
	(N'2008-12-06', N'gold', 8453),
	(N'2010-08-26', N'platinum', 6855),
	(N'2019-07-12', N'silver', 1467),
	(N'2015-06-14', N'silver', 9856),
	(N'2017-07-19', N'bronze', 1813),
	(N'2009-05-04', N'economic', 2486),
	(N'2005-09-17', N'gold', 9338),
	(N'2003-04-12', N'gold', 6388),
	(N'2011-10-16', N'gold', 8885),
	(N'2016-01-05', N'silver', 3538),
	(N'2020-05-17', N'gold', 4113),
	(N'2018-11-25', N'economic', 2175),
	(N'2011-05-09', N'economic', 2913),
	(N'2008-12-25', N'silver', 52),
	(N'2012-08-10', N'silver', 8934),
	(N'2006-10-24', N'silver', 3915)
GO
INSERT INTO Customers(MemberID, LastName, FirstName, BirthDate, Address, City, District, Phone, Email) 
VALUES
	(1, N'LNMEK', N'DIPOG', N'1990-12-08', N'FKJDR', N'Dien Bien', N'UCEJZ', N'3948077388', N'CPBNW@email.com'),
	(2, N'JLAST', N'NNRRH', N'1993-12-12', N'BAQAP', N'Vinh Phuc', N'YWBQF', N'5933811437', N'RQEZT@email.com'),
	(3, N'GWQGG', N'FEDJL', N'2000-05-20', N'TWCNU', N'Quang Ngai', N'BAZJH', N'6892953390', N'NCNDM@email.com'),
	(4, N'YDOEC', N'XHRDD', N'1998-11-22', N'VXFYB', N'Phu Tho', N'DNOAK', N'5690366506', N'GQPGG@email.com'),
	(5, N'IFWNI', N'IYCST', N'2000-08-06', N'WUGRX', N'Quang Ninh', N'NVHLP', N'8216317317', N'YUHVT@email.com'),
	(6, N'KGHWE', N'LCSPB', N'1993-04-30', N'OQLWN', N'Thua Thien Hue', N'ZRGCE', N'5342504157', N'JVYHQ@email.com'),
	(7, N'RHGSD', N'SHWNH', N'1999-01-27', N'RTYIW', N'Bac Ninh', N'VEFBH', N'8156214199', N'BHDUB@email.com'),
	(8, N'XMUSD', N'EFOYE', N'1994-05-13', N'VNIUE', N'Lai Chau', N'XZENN', N'4304073493', N'LWRTW@email.com'),
	(9, N'TWWWS', N'VVFWX', N'1995-10-25', N'KHFSN', N'Ca Mau', N'LUGHH', N'3679807518', N'BMSXJ@email.com'),
	(10, N'HETSX', N'KKFDA', N'1993-03-01', N'AUVXP', N'Dak Nong', N'ZRBNB', N'9080873208', N'HGBJP@email.com'),
	(11, N'BRAIL', N'RRAPT', N'2000-06-14', N'RRVZS', N'Lang Son', N'ZZPBU', N'8151658907', N'GZNXG@email.com'),
	(12, N'MTLFM', N'EYUNZ', N'2000-07-09', N'MSNJU', N'Gia Lai', N'HDZPC', N'8469996571', N'AJNZQ@email.com'),
	(13, N'LRPZR', N'EJXML', N'1997-10-13', N'TJASF', N'Ho Chi Minh', N'BQTUG', N'3006559230', N'EQXQG@email.com'),
	(14, N'KSLML', N'QQWLH', N'1999-12-13', N'FTTIU', N'Quang Nam', N'LTBGZ', N'4106517682', N'TQMLN@email.com'),
	(15, N'UYJQN', N'VLJHY', N'1992-12-15', N'TPWYY', N'Ninh Thuan', N'TODCU', N'4841658436', N'LAGRG@email.com'),
	(16, N'YQFSQ', N'QINQC', N'1997-04-20', N'IWAOM', N'Phu Yen', N'ZWIND', N'9735310950', N'YZTPW@email.com'),
	(17, N'KCPGK', N'IFFJJ', N'1996-10-10', N'JKWRK', N'Long An', N'CTJFO', N'1292275365', N'SJUPB@email.com'),
	(18, N'JMNZZ', N'EPITG', N'1993-04-24', N'QRGPC', N'Ha Nam', N'WXECX', N'1769913068', N'XGNPX@email.com'),
	(19, N'RAOVY', N'XTSWZ', N'1999-03-17', N'KZVPY', N'Hai Duong', N'FURDM', N'1860677548', N'EDGGD@email.com'),
	(20, N'TUMVN', N'SDAQZ', N'1991-12-31', N'QETHS', N'Khanh Hoa', N'NSBEZ', N'7578573185', N'PYADE@email.com'),
	(21, N'YIHAR', N'PCDGS', N'2000-04-15', N'HNFBN', N'Phu Tho', N'TFCOF', N'9619011350', N'HBPUW@email.com'),
	(22, N'PCHZG', N'LRRGW', N'1999-06-04', N'YKYOR', N'Kon Tum', N'YXUMX', N'2712675991', N'JNJHU@email.com'),
	(23, N'ZCNGK', N'PZTIT', N'1991-07-30', N'TXPIL', N'Dong Thap', N'KBTAV', N'2412705562', N'DKOBU@email.com'),
	(24, N'LTYAY', N'HXZLG', N'1992-03-21', N'HRDIZ', N'Tra Vinh', N'OIZZH', N'9311728665', N'FWPPR@email.com'),
	(25, N'LVTUF', N'YARWB', N'1990-10-06', N'GOFIP', N'Kien Giang', N'RVHJI', N'2067249032', N'NPBCZ@email.com'),
	(26, N'WMBHP', N'NLLLJ', N'1994-05-16', N'NWCCQ', N'Ha Tinh', N'AZOTE', N'7298625486', N'DLCQD@email.com'),
	(27, N'TSAFE', N'UVPCY', N'1996-12-18', N'XGNAZ', N'Ninh Thuan', N'KWDVU', N'7786079069', N'DHPVM@email.com'),
	(28, N'PGPRM', N'MWKXE', N'1995-03-10', N'BPVKK', N'Can Tho', N'VHTKX', N'4337422272', N'VBKDB@email.com'),
	(29, N'QOWGO', N'GKOCZ', N'1995-10-26', N'BKMVR', N'Ha Noi', N'NWTFP', N'1106630522', N'CRIMO@email.com'),
	(30, N'OKZHF', N'DAOOP', N'1990-11-09', N'BOCNN', N'Yen Bai', N'OPIHV', N'1863474122', N'XINZW@email.com'),
	(31, N'ARIAD', N'AQWJI', N'1996-06-01', N'ZDMEN', N'Thai Binh', N'JDTDN', N'8824314790', N'IGYPB@email.com'),
	(32, N'KHWQF', N'XCPQV', N'1993-01-22', N'KWEYX', N'Tra Vinh', N'YZAZT', N'2622477667', N'OZDBQ@email.com'),
	(33, N'RNCWJ', N'DVEBH', N'2000-12-09', N'HKZMB', N'Hung Yen', N'DZQJP', N'0745985747', N'GUGYK@email.com'),
	(34, N'NPSDU', N'THQFD', N'1993-05-13', N'TYXZZ', N'Thai Nguyen', N'LNTQH', N'8771638513', N'GQRSJ@email.com'),
	(35, N'FETAS', N'EHAPS', N'1990-02-17', N'GTZBC', N'Lai Chau', N'FIFWF', N'2709850872', N'IIPCT@email.com'),
	(36, N'CKCME', N'PTTAK', N'1999-11-04', N'QLJIB', N'An Giang', N'DIAAT', N'1086901747', N'QDQGB@email.com'),
	(37, N'INXEN', N'KSVUF', N'1996-03-22', N'HKOQK', N'Thai Binh', N'BESYG', N'4891310025', N'VAQIX@email.com'),
	(38, N'GFDDO', N'WETOC', N'1995-11-18', N'DTADA', N'Bac Kan', N'JMWFI', N'3430746454', N'JTZDM@email.com'),
	(39, N'BNXYF', N'JWUSM', N'1993-09-24', N'PVRXQ', N'Dong Nai', N'LTSWQ', N'9731300691', N'MFYRX@email.com'),
	(40, N'YNSEC', N'LOCVJ', N'1991-01-03', N'CYJKL', N'Gia Lai', N'LYMWY', N'6876601677', N'EDBYY@email.com'),
	(41, N'FDWNF', N'ZEJEJ', N'1993-05-08', N'XMLGM', N'Binh Thuan', N'UMZCP', N'6584075683', N'IBSRM@email.com'),
	(42, N'EIBAD', N'MMSIY', N'1992-03-28', N'QPZER', N'Ben Tre', N'KZXSO', N'2911124169', N'RGCRD@email.com'),
	(43, N'OODCH', N'WBLOB', N'1998-06-12', N'MKSSR', N'Quang Ninh', N'TMJWF', N'6575530757', N'STXQR@email.com'),
	(44, N'HCWJV', N'ZGIWQ', N'2000-11-02', N'LDLTY', N'Ba Ria - Vung Tau', N'UUHML', N'5965288504', N'HLJJF@email.com'),
	(45, N'KSJCW', N'SBCBB', N'1996-12-15', N'JHAYF', N'Dong Thap', N'DUODP', N'8609801064', N'NYNMF@email.com'),
	(46, N'TIYVU', N'SZOGY', N'1996-11-09', N'ZLJRD', N'Dien Bien', N'TCTIW', N'7779407281', N'NSXEM@email.com'),
	(47, N'XXZQI', N'ZNITL', N'1998-08-27', N'MTXDH', N'Hau Giang', N'BIZFT', N'2372938535', N'KWPIT@email.com'),
	(48, N'JEELC', N'DSTLB', N'1992-12-30', N'RIHTU', N'Phu Tho', N'OLGVI', N'0523509239', N'CUVGK@email.com'),
	(49, N'ZNIBW', N'OZLLP', N'1998-10-08', N'BQISR', N'Phu Tho', N'AYCXB', N'8600018037', N'SOXYS@email.com'),
	(50, N'XWCHB', N'UBUGD', N'2000-04-03', N'LPMGA', N'Dak Lak', N'ORONZ', N'3415154086', N'WIEXX@email.com'),
	(51, N'AMMZG', N'OEOVI', N'1999-04-08', N'VWRYY', N'Vinh Phuc', N'PBHPM', N'3571197329', N'QLMSA@email.com'),
	(52, N'RWIQF', N'ZLTVW', N'1997-07-08', N'SGHKW', N'Nghe An', N'ZUBIF', N'3207515863', N'OBWYX@email.com'),
	(53, N'MERZG', N'VQBJR', N'1995-12-11', N'CUGJR', N'Quang Tri', N'FXCEX', N'7632610948', N'KXQQW@email.com'),
	(54, N'YZONW', N'AWXVH', N'1994-07-10', N'UKRVD', N'Nam Dinh', N'YEYAH', N'5335342060', N'CQJHT@email.com'),
	(55, N'GNZNS', N'DPPAE', N'1993-03-10', N'KVPWX', N'Ninh Binh', N'JSEJP', N'7032953603', N'QRDXV@email.com'),
	(56, N'QVGBN', N'FXZMI', N'1996-02-12', N'PHPPF', N'Kon Tum', N'RPHWZ', N'1177135678', N'RRMZB@email.com'),
	(57, N'RPSJA', N'AOEYN', N'1994-10-01', N'HMVTG', N'Lang Son', N'IBJGU', N'9641164749', N'YYUYW@email.com'),
	(58, N'PZSTK', N'VZNFH', N'1990-06-21', N'OFUEV', N'Ninh Binh', N'BNGEL', N'4163080244', N'HHLYJ@email.com'),
	(59, N'AERGS', N'TSGYV', N'2000-02-06', N'KYQUP', N'Lang Son', N'ETHYR', N'2447228121', N'CMIYQ@email.com'),
	(60, N'SQXXQ', N'ODCRZ', N'1990-05-21', N'OXBFO', N'Bac Giang', N'ONGFH', N'6177320907', N'FENGF@email.com'),
	(61, N'PHWUV', N'GCQFL', N'1994-07-29', N'MTXQF', N'Hai Duong', N'IYXRN', N'0937008228', N'QMUWB@email.com'),
	(62, N'NRNYB', N'ETREG', N'1997-09-28', N'IXFYZ', N'Son La', N'XEGTM', N'5708692582', N'XJLTB@email.com'),
	(63, N'ZIJSL', N'XNHLZ', N'1992-09-07', N'KABSM', N'Da Nang', N'ZNQWB', N'3993881550', N'YFUGC@email.com'),
	(64, N'PZMIJ', N'YIUNT', N'1995-01-03', N'SXPPI', N'Lam Dong', N'JGXWM', N'3360691878', N'UOZRL@email.com'),
	(65, N'CKNIC', N'TRREW', N'1999-10-13', N'SVTXF', N'Thua Thien Hue', N'ZURES', N'1504328217', N'NKBSP@email.com'),
	(66, N'AGFDM', N'SGHRH', N'1990-03-01', N'IJNGV', N'Phu Tho', N'OZAGV', N'1419784231', N'KDNOK@email.com'),
	(67, N'FEHJO', N'IVIOD', N'1991-05-24', N'IJYQT', N'Ca Mau', N'KGBUA', N'6091588062', N'QWWAA@email.com'),
	(68, N'FHWSQ', N'QFHNO', N'1992-07-12', N'NLRDF', N'Lao Cai', N'IWMEQ', N'8118882544', N'UJXAD@email.com'),
	(69, N'UYKUO', N'MOZGA', N'1997-02-05', N'MWLTD', N'Kon Tum', N'VKHWP', N'8711176253', N'CCASQ@email.com'),
	(70, N'TCPJO', N'UGKWS', N'1996-03-02', N'YAUKQ', N'Ben Tre', N'NNUAY', N'2601042339', N'UCAFE@email.com'),
	(71, N'GCCYJ', N'OMUVQ', N'1995-02-25', N'SOXGZ', N'Dak Lak', N'XJNKC', N'1505878771', N'IDFIH@email.com'),
	(72, N'TIBAJ', N'JNSPI', N'1990-08-12', N'XWOGD', N'Ca Mau', N'GQSKT', N'9786745220', N'GAMRN@email.com'),
	(73, N'RCYPC', N'GGMNL', N'2000-05-17', N'JKORN', N'Tay Ninh', N'UZMVC', N'5957745091', N'SXKOL@email.com'),
	(74, N'GQCIZ', N'DRUPC', N'2000-03-25', N'LYJOX', N'Vinh Long', N'YBMKG', N'7052533185', N'WFZUI@email.com'),
	(75, N'LYZXV', N'IQHGG', N'2000-09-08', N'NSRQG', N'Yen Bai', N'ROYTY', N'4000078880', N'XIHCI@email.com'),
	(76, N'BRZJZ', N'AJQWL', N'1994-05-19', N'AOZDB', N'Cao Bang', N'JURGB', N'2037051379', N'IUWYL@email.com'),
	(77, N'XGZWI', N'NVYLB', N'1999-03-21', N'YNKKT', N'Gia Lai', N'HLHRI', N'7201387991', N'VCCOA@email.com'),
	(78, N'YQAYG', N'XMJLF', N'1990-07-07', N'UXNMG', N'Bac Lieu', N'MYFZV', N'5136325029', N'BIAYH@email.com'),
	(79, N'LTYIM', N'OYOUD', N'1990-09-22', N'NLXPQ', N'Ha Noi', N'SQVXC', N'5186733897', N'FKGHP@email.com'),
	(80, N'XRVRB', N'MQENL', N'1990-11-19', N'ZOQUX', N'Binh Phuoc', N'IAXUA', N'1690757221', N'ZKYHO@email.com'),
	(81, N'ZSYVW', N'JOWFR', N'1995-02-22', N'MPJBW', N'Thanh Hoa', N'MZJKP', N'6534359918', N'XXKNM@email.com'),
	(82, N'XMTCX', N'HLOEG', N'1996-09-19', N'HERJV', N'Hoa Binh', N'RFSPL', N'7467842427', N'DQVJQ@email.com'),
	(83, N'FWZWJ', N'IESXS', N'1999-11-21', N'KLVLZ', N'Ho Chi Minh', N'QFWUD', N'4169938838', N'QOLAD@email.com'),
	(84, N'SVKWC', N'WZJQB', N'1992-09-07', N'MNPBI', N'Ha Noi', N'SPGOF', N'9093705521', N'TXOWY@email.com'),
	(85, N'ZKRBY', N'XCCKC', N'1990-08-03', N'NBABH', N'Hai Phong', N'HGQIS', N'3950130530', N'FCWCA@email.com'),
	(86, N'CFMTT', N'QVLKB', N'2000-05-07', N'OHZCQ', N'Phu Tho', N'QIEPW', N'8692142087', N'TUPSJ@email.com'),
	(87, N'ZJDLK', N'GSOOX', N'1996-09-10', N'JKIPV', N'Long An', N'TVEBO', N'0771399214', N'POZTD@email.com'),
	(88, N'HOTYU', N'GBQKJ', N'1999-04-17', N'LEGCL', N'Quang Ninh', N'FAPYE', N'0254720447', N'VVDPX@email.com'),
	(89, N'EHBXW', N'MIKTP', N'2000-09-29', N'GJDGK', N'Bac Lieu', N'QKDMZ', N'3317878811', N'XVLTU@email.com'),
	(90, N'CLINA', N'WOXMG', N'1993-06-30', N'NHWPJ', N'Kon Tum', N'TFOPA', N'8620792273', N'BNOJJ@email.com'),
	(91, N'WTMPP', N'TKRHO', N'1993-04-19', N'RAKQP', N'Quang Ngai', N'QXDHG', N'0234484078', N'OXKEZ@email.com'),
	(92, N'ZHJLA', N'IYVKA', N'1993-05-22', N'DFEIJ', N'Binh Duong', N'DZMGD', N'8081415634', N'EONVW@email.com'),
	(93, N'BXNSK', N'LBVJF', N'1999-08-19', N'BTOGX', N'Lao Cai', N'VXPEX', N'1303880653', N'XRMCI@email.com'),
	(94, N'WTQVC', N'YMWQW', N'1995-09-13', N'OPDBX', N'Khanh Hoa', N'MKZYN', N'9901309050', N'CKLMD@email.com'),
	(95, N'MSLPX', N'KTFXL', N'1990-05-23', N'CVFXD', N'Thai Nguyen', N'SZIZF', N'0919943729', N'DINIC@email.com'),
	(96, N'FXSRY', N'OBGCA', N'1993-11-24', N'GTAII', N'Gia Lai', N'VTODU', N'2082352834', N'BBJDA@email.com'),
	(97, N'VNOQK', N'WIOPG', N'1998-01-09', N'URCJH', N'Ba Ria - Vung Tau', N'UIWPY', N'6239216513', N'AIGUY@email.com'),
	(98, N'OACSM', N'EHBSD', N'2000-12-07', N'IKINM', N'Binh Dinh', N'KITXS', N'6844124609', N'ZEWUG@email.com'),
	(99, N'UQYJQ', N'YUFXZ', N'1995-03-31', N'VMIWS', N'Kon Tum', N'DSPSQ', N'7095735050', N'XSCOF@email.com'),
	(100, N'CBPTL', N'LCLQZ', N'1998-01-01', N'WCBJN', N'Phu Yen', N'TQGOC', N'0144375112', N'RUVYG@email.com'),
	(101, N'QUUUV', N'WHICG', N'1999-11-11', N'FBFTY', N'Ben Tre', N'NBXRM', N'1109847521', N'YDBFG@email.com'),
	(102, N'SHPVT', N'QGSVQ', N'1998-02-27', N'BSTWP', N'Binh Duong', N'HLNCN', N'9363236921', N'XPGEX@email.com'),
	(103, N'CWVBH', N'JNKDJ', N'1990-03-24', N'WFTKK', N'Hai Phong', N'EEKOD', N'3749692707', N'SCAVT@email.com'),
	(104, N'AJVZS', N'UOMXA', N'1994-11-12', N'XGKAK', N'Dong Nai', N'SIQCQ', N'2404541878', N'NMDRG@email.com'),
	(105, N'VBLMD', N'SMVRS', N'1994-04-06', N'WUSJH', N'Dak Nong', N'HULFK', N'4519583312', N'BZVUA@email.com'),
	(106, N'MTJTE', N'ZFOCF', N'1998-10-09', N'YHQXI', N'Thai Nguyen', N'TQEON', N'1088877120', N'CBLCN@email.com'),
	(107, N'OMSTN', N'JJBMP', N'1990-10-08', N'TKHJF', N'Ha Tinh', N'GGOXL', N'0027519346', N'RJXEM@email.com'),
	(108, N'OHKSW', N'WRUFG', N'1991-05-27', N'KBYHP', N'Hai Duong', N'PQZUK', N'5361415715', N'GAGRL@email.com'),
	(109, N'CBDUG', N'ZGMTA', N'1991-05-09', N'WXXPU', N'Kon Tum', N'IGWML', N'5649517341', N'WRHKF@email.com'),
	(110, N'XPJKQ', N'APWSF', N'1992-03-13', N'BFCZU', N'Dak Lak', N'SVFHL', N'6018094743', N'NOPCL@email.com'),
	(111, N'UZDCF', N'VKYFB', N'2000-11-22', N'OAUKW', N'Quang Nam', N'ZMXOF', N'0955036712', N'RCJGP@email.com'),
	(112, N'TYQQG', N'SYSAV', N'1992-01-28', N'SAEFM', N'Bac Lieu', N'RIKWC', N'5887603147', N'ZNJZO@email.com'),
	(113, N'RGWWC', N'FXYDT', N'1992-06-04', N'SUUPK', N'Tuyen Quang', N'PUOZZ', N'0218688895', N'QKFQC@email.com'),
	(114, N'GXTUJ', N'EXXLN', N'1997-12-04', N'VIBOG', N'Dak Nong', N'MIEZH', N'0869268065', N'HZXMK@email.com'),
	(115, N'HKJKB', N'SOVEV', N'1998-05-01', N'YRIIZ', N'Binh Thuan', N'UJTPW', N'8964108084', N'ISNSI@email.com'),
	(116, N'ZZTQD', N'AYFDJ', N'1992-12-29', N'RMDTK', N'Phu Tho', N'FJSJX', N'1527010323', N'QAXUO@email.com'),
	(117, N'WCWUP', N'LOHIT', N'1999-02-08', N'FONWM', N'Kon Tum', N'UJCTJ', N'4748356750', N'RMFXO@email.com'),
	(118, N'HZKIZ', N'IFVWD', N'1993-07-31', N'XDWTH', N'Da Nang', N'BXBRG', N'7761890394', N'CVKOO@email.com'),
	(119, N'LAKDG', N'YMFTN', N'1994-02-20', N'NIEMK', N'Gia Lai', N'IUIIN', N'6276849389', N'DGXLQ@email.com'),
	(120, N'IDSXF', N'JZYXC', N'1991-10-17', N'SQKCN', N'Lang Son', N'ADCYW', N'2151283160', N'WPJXX@email.com'),
	(121, N'ZVIBN', N'DVHJV', N'1996-08-30', N'HPVMA', N'Yen Bai', N'IPGUN', N'1711552592', N'XXHLT@email.com'),
	(122, N'WTWLH', N'LRHIU', N'1999-02-08', N'HYGQU', N'Quang Binh', N'IWKNC', N'1463546371', N'KIKZC@email.com'),
	(123, N'JVYWN', N'EXBOZ', N'1997-03-02', N'ALRJN', N'Quang Ninh', N'JVMDC', N'8168039337', N'LZAWJ@email.com'),
	(124, N'IZBMQ', N'KTLSP', N'1996-08-21', N'FBRTF', N'Binh Thuan', N'OICYV', N'6001103974', N'HYKWH@email.com'),
	(125, N'LUVIQ', N'BVORG', N'1990-09-14', N'MUUPM', N'Bac Giang', N'JDSRP', N'4985226353', N'SMDZZ@email.com'),
	(126, N'ZEAYA', N'CAAPW', N'1993-06-06', N'WMKPW', N'Lang Son', N'UXGHS', N'6336932513', N'TGQRR@email.com'),
	(127, N'EUCNI', N'KYROS', N'1993-12-17', N'FJFKY', N'Ho Chi Minh', N'YMLCT', N'9050014872', N'RJMRT@email.com'),
	(128, N'YSNML', N'DQLGM', N'1994-10-29', N'RHLOC', N'Ninh Binh', N'CEYFE', N'3379053540', N'QBJDY@email.com'),
	(129, N'WVKBM', N'HWEDJ', N'1998-10-06', N'KLHSD', N'Bac Kan', N'HCELP', N'0123051562', N'BZHRS@email.com'),
	(130, N'SLURG', N'AKFRO', N'1991-06-05', N'GATAR', N'Phu Tho', N'GCCQT', N'1123809067', N'TURIC@email.com'),
	(131, N'PLRCY', N'RILLV', N'1996-02-23', N'PTEDB', N'Thai Nguyen', N'QWZSF', N'4047504171', N'HYPZC@email.com'),
	(132, N'MQEQT', N'MJXOG', N'1991-02-18', N'ZRGYW', N'Lam Dong', N'TPPAX', N'4411873427', N'PLGAJ@email.com'),
	(133, N'YSKHC', N'DVFWN', N'1990-04-19', N'EMDZQ', N'Lai Chau', N'TRESP', N'4148517669', N'BQDPB@email.com'),
	(134, N'EJFHH', N'SOYOT', N'2000-06-06', N'WKCJJ', N'Hai Duong', N'LLGYG', N'2130188174', N'GIBFI@email.com'),
	(135, N'HDVXJ', N'ZSIUH', N'1996-11-23', N'IYVVP', N'Lao Cai', N'UJMXN', N'9640411005', N'UHZYS@email.com'),
	(136, N'IFRUZ', N'YBBFX', N'2000-08-02', N'JYOHF', N'Vinh Long', N'IBDQA', N'2248213555', N'IMKBJ@email.com'),
	(137, N'GBENB', N'LUSEY', N'1991-05-30', N'LYMEP', N'Tuyen Quang', N'WCUQB', N'0953441790', N'PXXYT@email.com'),
	(138, N'AXODD', N'MRIME', N'2000-12-14', N'FMOFZ', N'Dong Nai', N'AWNFE', N'0981265241', N'TXKLD@email.com'),
	(139, N'UNVPN', N'UEYFW', N'2000-09-06', N'MEUVG', N'Thanh Hoa', N'SPJHW', N'1865038243', N'LMSPL@email.com'),
	(140, N'EHXBQ', N'FRASH', N'1996-08-08', N'ZYWAA', N'An Giang', N'QJPGX', N'5787241221', N'MSHEF@email.com'),
	(141, N'VUMTZ', N'GJCZL', N'1992-03-13', N'PEQUY', N'Nam Dinh', N'BMKJN', N'6785092212', N'EZCOU@email.com'),
	(142, N'VQILU', N'MICDT', N'1994-09-13', N'FLDTN', N'Ca Mau', N'LEQMV', N'1713089605', N'HOITZ@email.com'),
	(143, N'WWVRR', N'QVYNU', N'1994-03-21', N'SNGEM', N'Dong Nai', N'MFMEN', N'1282083289', N'ECIRI@email.com'),
	(144, N'GUAMU', N'MQYES', N'1998-03-29', N'USPAD', N'Ha Nam', N'CFEXJ', N'9460450846', N'IAXRY@email.com'),
	(145, N'LGGHK', N'PVSFD', N'1993-09-05', N'LHWTN', N'Ha Nam', N'NGTPE', N'9283948205', N'VHJIM@email.com'),
	(146, N'RTNHE', N'URZEI', N'1997-05-20', N'XDXXF', N'Ha Nam', N'EFXTH', N'1975069895', N'FXDVX@email.com'),
	(147, N'KWOVU', N'JRVOO', N'1992-04-23', N'LPDOP', N'Hung Yen', N'KGMRJ', N'1456354584', N'HZCRR@email.com'),
	(148, N'KJPYQ', N'ACSHM', N'1999-06-09', N'NUENO', N'Hai Duong', N'ADZWZ', N'8589531744', N'ZMYLO@email.com'),
	(149, N'GAYVK', N'AFEVX', N'1999-10-02', N'SYYYZ', N'Bac Ninh', N'SROON', N'9062640853', N'FDZEP@email.com'),
	(150, N'WCAPG', N'TNBBD', N'1990-10-15', N'WHDRV', N'Ho Chi Minh', N'IKMRG', N'2461837594', N'FBJGL@email.com'),
	(151, N'MACCI', N'WIXPP', N'1997-03-01', N'IUPVZ', N'Tuyen Quang', N'VZXNE', N'6006894249', N'PFERP@email.com'),
	(152, N'UCCLO', N'XMDKJ', N'1994-10-11', N'BKFBX', N'Dien Bien', N'PGMYK', N'6826502583', N'VHZGM@email.com'),
	(153, N'QERHU', N'GFHIB', N'1996-07-28', N'DIYAD', N'Thua Thien Hue', N'YYQSO', N'5962292009', N'RDPVY@email.com'),
	(154, N'ZUPJS', N'NNPQU', N'1998-12-19', N'CRESA', N'Ha Nam', N'NKETT', N'2430186453', N'JZLXS@email.com'),
	(155, N'PUNHF', N'UCJVF', N'1990-12-24', N'XYXZW', N'Da Nang', N'LBGZF', N'8304649702', N'IMNYO@email.com'),
	(156, N'IXNKH', N'GHUMX', N'1991-07-15', N'ZHXZB', N'Phu Tho', N'ETDPB', N'8408420521', N'JZDYA@email.com'),
	(157, N'GCFSE', N'OFUUF', N'1995-12-15', N'GTVOQ', N'Dak Lak', N'NCPIB', N'9304079040', N'CVONO@email.com'),
	(158, N'NSQKZ', N'UVUID', N'1994-07-21', N'BHJMQ', N'Ba Ria - Vung Tau', N'ISQYR', N'7684169402', N'TRKTB@email.com'),
	(159, N'SZTZZ', N'YEJDH', N'1998-05-07', N'PDHGH', N'Hau Giang', N'HYAZM', N'8847045488', N'JLAZB@email.com'),
	(160, N'OARGC', N'HTBSH', N'1998-09-23', N'HQWES', N'Phu Yen', N'XANSX', N'9037305527', N'ELXSN@email.com'),
	(161, N'BQCLY', N'YJADF', N'1995-02-06', N'PHLDW', N'Bac Giang', N'CSYBM', N'1670884140', N'FQIVQ@email.com'),
	(162, N'ANDMG', N'NATQK', N'1993-12-09', N'DGOCH', N'Kien Giang', N'XYJWV', N'7955513365', N'JKQYI@email.com'),
	(163, N'ZKSKJ', N'YCPJF', N'1994-06-23', N'KXBSR', N'Quang Tri', N'LHRUH', N'7146172032', N'OQVQY@email.com'),
	(164, N'OKVQD', N'URRCC', N'2000-11-15', N'FAPON', N'Lai Chau', N'SVXXD', N'0219096074', N'OFIEL@email.com'),
	(165, N'GMUIW', N'UWHNG', N'1995-07-06', N'NVGEX', N'An Giang', N'KINZR', N'1088147985', N'AHEXJ@email.com'),
	(166, N'HPICE', N'IWSBN', N'1991-04-26', N'NKRQI', N'Tra Vinh', N'QDWIK', N'0603640082', N'RPLDE@email.com'),
	(167, N'IZJOM', N'SNOWZ', N'1992-10-23', N'WFSBY', N'Binh Thuan', N'SRWZN', N'0184063919', N'ODUIV@email.com'),
	(168, N'NRTFL', N'QBLVS', N'1999-01-15', N'PAOSU', N'Bac Kan', N'GQPWS', N'7986814169', N'CKPRG@email.com'),
	(169, N'CLHOZ', N'ICTMN', N'1996-10-24', N'BSKHP', N'Tien Giang', N'ADSFJ', N'2805140713', N'HIAHJ@email.com'),
	(170, N'VAOIY', N'ZCIRD', N'1995-01-25', N'DXRLQ', N'Son La', N'RZMEG', N'1747559120', N'NFRCY@email.com'),
	(171, N'MQUUE', N'UBBBX', N'1991-11-09', N'IINJL', N'Bac Ninh', N'UJMHP', N'6157698126', N'XHSIU@email.com'),
	(172, N'DPSCP', N'YOHUO', N'1991-01-01', N'KVNFC', N'Gia Lai', N'NRZUZ', N'9242604014', N'UJJLT@email.com'),
	(173, N'ZSWTH', N'FUQND', N'1994-01-06', N'TJOOY', N'Long An', N'ZSGDC', N'7938703500', N'WBDTV@email.com'),
	(174, N'GMIEE', N'OGKXP', N'1992-09-07', N'GXDDI', N'Binh Duong', N'ENTFZ', N'0847550628', N'YWIPX@email.com'),
	(175, N'PTDXU', N'MHWWE', N'1993-04-24', N'RYVZT', N'Gia Lai', N'DNOYP', N'5138904696', N'AQGCE@email.com'),
	(176, N'SECCD', N'QKEUW', N'1993-01-13', N'EXAEE', N'Ben Tre', N'KQXLT', N'0423100700', N'GWIYL@email.com'),
	(177, N'AXMNQ', N'EOAQA', N'1999-11-25', N'JVQFP', N'Tay Ninh', N'MIAGF', N'1800093767', N'NHMZX@email.com'),
	(178, N'FEIYA', N'VMIOJ', N'1993-07-08', N'AFGPW', N'Ba Ria - Vung Tau', N'MZLPN', N'0683453255', N'KUNJU@email.com'),
	(179, N'PIXNR', N'PAYEM', N'1994-06-05', N'KTEJW', N'Binh Dinh', N'SLYEV', N'7810906679', N'NZIUO@email.com'),
	(180, N'FMVBB', N'IANIW', N'1993-01-06', N'VRHCL', N'Ninh Binh', N'QQYQP', N'3246164504', N'MGNBO@email.com'),
	(181, N'VGJCM', N'OFQSA', N'1997-05-29', N'IZNVE', N'Bac Giang', N'RRCIC', N'4647920248', N'UKTWC@email.com'),
	(182, N'EROAN', N'KIEZU', N'1992-09-01', N'NAXKI', N'Hai Duong', N'IMTNL', N'2996774444', N'PHYQY@email.com'),
	(183, N'NJDCI', N'JHYLS', N'1990-08-31', N'BGKCT', N'Hai Duong', N'WHQCO', N'9220372744', N'OHQDA@email.com'),
	(184, N'JMJKT', N'KKKRE', N'1993-11-27', N'RSRWZ', N'Yen Bai', N'WMJUX', N'9191806278', N'HLFGO@email.com'),
	(185, N'XCOGW', N'NXZYY', N'1991-01-15', N'BKRAU', N'Hoa Binh', N'WSOXI', N'6890931142', N'WECII@email.com'),
	(186, N'GMRAO', N'YNSIF', N'1994-11-21', N'WPFOE', N'Ben Tre', N'TTLVH', N'7272580952', N'SERPC@email.com'),
	(187, N'BVYUF', N'SSTMF', N'1993-09-15', N'LMTMJ', N'Lam Dong', N'MYNRH', N'9207191515', N'FBQKO@email.com'),
	(188, N'ZUYYJ', N'NBMLK', N'1993-03-09', N'NOAFN', N'Ba Ria - Vung Tau', N'NFVPX', N'2961354276', N'VTGNG@email.com'),
	(189, N'XLLSP', N'UMSNT', N'1992-01-01', N'YVHAO', N'Ca Mau', N'RMNUC', N'8524230196', N'LKHFL@email.com'),
	(190, N'HBUDZ', N'IYGLF', N'1998-11-13', N'KQLVZ', N'Khanh Hoa', N'SPFBJ', N'8264455757', N'ZYWWY@email.com'),
	(191, N'OPAEP', N'MUBDE', N'1991-09-07', N'IHSAP', N'Phu Tho', N'QOGHR', N'3661529063', N'NLIZT@email.com'),
	(192, N'QUVRE', N'ILRLR', N'1998-11-19', N'VUZHP', N'Tien Giang', N'FJGLA', N'7501916934', N'SJANN@email.com'),
	(193, N'SKRVV', N'XBGHF', N'1996-09-12', N'WGXDM', N'Dak Lak', N'ECAFA', N'6517045513', N'ABGIZ@email.com'),
	(194, N'NPJOC', N'PXYHS', N'1993-09-16', N'BSUSJ', N'Quang Nam', N'ELHAU', N'0701800945', N'SAKAE@email.com'),
	(195, N'CGTYY', N'AFGED', N'1994-06-20', N'NVPHB', N'Thua Thien Hue', N'PJPGB', N'3668760391', N'HQBWJ@email.com')
GO
INSERT INTO Employees(LastName, FirstName, PositionID, BirthDate, Address, City, District, Phone, Email) 
VALUES
	(N'WTUYL', N'WUFCH', 10, N'1990-05-17', N'GESYQ', N'Dong Nai', N'QWYAZ', N'9739060918', N'PSKVD@email.com'),
	(N'QSHPL', N'WPQHI', 10, N'1994-01-11', N'YXKKF', N'Lao Cai', N'RCJCA', N'7852175104', N'MCSRC@email.com'),
	(N'CMXUB', N'WTXFT', 10, N'1999-07-02', N'MNGLV', N'Vinh Long', N'SAWNK', N'4199937358', N'TCOUV@email.com'),
	(N'STDHR', N'NPWZB', 10, N'1998-12-24', N'ROIZK', N'Binh Duong', N'EVNJL', N'7415149788', N'DYORT@email.com'),
	(N'RUYHP', N'HZTTZ', 10, N'1997-09-23', N'UCMIG', N'Bac Giang', N'OWHDL', N'0943778418', N'KJDCF@email.com'),
	(N'EUYPC', N'NRHYR', 10, N'1992-02-04', N'MCUYX', N'Can Tho', N'EQXZJ', N'9043681983', N'NKWNN@email.com'),
	(N'UIHIR', N'KGLHI', 10, N'2000-04-07', N'KEEQV', N'Tra Vinh', N'OALSF', N'3271600370', N'YMHUA@email.com'),
	(N'ZXMON', N'WMXCG', 10, N'1990-12-29', N'YJTQO', N'Ho Chi Minh', N'WWOYJ', N'7894475796', N'XDEKT@email.com'),
	(N'TKIQK', N'QHVVI', 10, N'1991-02-03', N'CUUXS', N'Quang Nam', N'IAJMP', N'3066884226', N'BPFBI@email.com'),
	(N'OQIKP', N'TBHKX', 10, N'1999-08-11', N'NWCAV', N'Quang Tri', N'TADIJ', N'4457053478', N'MTEVM@email.com')
GO
INSERT INTO Employees(LastName, FirstName, PositionID, BirthDate, Address, City, District, Phone, Email) 
VALUES
	(N'VIFHQ', N'MYQSQ', 4, N'1993-09-07', N'GHJME', N'Tuyen Quang', N'VTUVD', N'7213249181', N'UFZSC@email.com'),
	(N'TVKWB', N'DEIYZ', 6, N'1993-09-26', N'RKTJX', N'Quang Ngai', N'DNSFV', N'6090173105', N'GLKAL@email.com'),
	(N'IGCVJ', N'BTAOK', 2, N'1999-01-11', N'PGWRF', N'Quang Binh', N'HBSEI', N'2439762448', N'AWZZS@email.com'),
	(N'FPNGA', N'UHINY', 9, N'1994-06-16', N'UMEBD', N'Nam Dinh', N'DUSEE', N'8894640978', N'NRXVD@email.com'),
	(N'OAMDY', N'RRDGU', 2, N'1998-02-26', N'HGWQL', N'Dak Lak', N'HRBKY', N'2914185766', N'JSQGR@email.com'),
	(N'EKVKX', N'MGIHP', 2, N'1997-06-12', N'GCVTJ', N'Can Tho', N'CTWCL', N'8776832099', N'ZCXQM@email.com'),
	(N'ZHSFO', N'CTLJY', 3, N'1999-01-22', N'KVJBX', N'Hung Yen', N'AREUJ', N'3244803919', N'HFVXN@email.com'),
	(N'MOFDZ', N'LHYJH', 2, N'1990-06-27', N'CKNIX', N'Ha Nam', N'AMYEB', N'1193139520', N'PZPMU@email.com'),
	(N'NORYA', N'RSYVB', 6, N'1992-12-16', N'UFDTK', N'Vinh Phuc', N'QHOTI', N'1002459091', N'VGHQR@email.com'),
	(N'CFGJA', N'FWGVU', 2, N'1995-02-05', N'WDNAQ', N'Soc Trang', N'BXQGL', N'4804187293', N'YMOUR@email.com'),
	(N'MXUMH', N'DUXFL', 6, N'1997-03-20', N'CBJJA', N'Hai Duong', N'NEZUF', N'2458085099', N'TMNDT@email.com'),
	(N'FCBTB', N'NZOIM', 4, N'1994-10-25', N'GBGMO', N'Thanh Hoa', N'TRCMP', N'3119986961', N'QHCQM@email.com'),
	(N'YOOVJ', N'MNRKL', 8, N'2000-08-01', N'DLDKW', N'Vinh Long', N'BRVKH', N'4526707090', N'EMDTY@email.com'),
	(N'LDKDM', N'GAXAR', 4, N'1991-01-16', N'XLEFP', N'Binh Phuoc', N'YVDPK', N'5643892262', N'PWTJD@email.com'),
	(N'UMFGH', N'RYORL', 2, N'1990-12-25', N'HJWKH', N'Dong Thap', N'KSMLQ', N'1625427303', N'PULCJ@email.com'),
	(N'LDZJT', N'LVDCL', 8, N'1997-02-14', N'VQUTN', N'Gia Lai', N'CNAEH', N'0061276132', N'FVBDY@email.com'),
	(N'KNDJZ', N'XWONY', 2, N'1991-01-13', N'FQVYW', N'Binh Dinh', N'GPCKO', N'8224879207', N'YUVYI@email.com'),
	(N'QLLFI', N'MVCZI', 7, N'1999-08-30', N'RHVYW', N'Nghe An', N'MYNPU', N'0459500965', N'URUWK@email.com'),
	(N'QERUE', N'KBBFW', 5, N'1991-11-10', N'MCIGN', N'Long An', N'GOUKT', N'1748073914', N'YIVNH@email.com'),
	(N'ITZMX', N'XNNMF', 7, N'1999-07-30', N'FZMPT', N'Binh Thuan', N'ZFLZL', N'6191834768', N'RGGRF@email.com'),
	(N'JNJUY', N'QAXMW', 4, N'1996-05-24', N'ZCVHJ', N'Nghe An', N'QDMVA', N'5422087528', N'PBUGS@email.com'),
	(N'CTKIA', N'WCTCE', 5, N'1991-02-22', N'FCVVR', N'Gia Lai', N'XVASG', N'8241395349', N'UZKSQ@email.com'),
	(N'FJDJI', N'YDRCZ', 5, N'1997-04-05', N'MMNFJ', N'Bac Ninh', N'MYCWZ', N'4029705323', N'OAPSC@email.com'),
	(N'GCFIV', N'ASXZU', 4, N'1995-11-04', N'OPNZZ', N'Ca Mau', N'QYSTN', N'3512469110', N'SPEEI@email.com'),
	(N'TMXVK', N'IYGGT', 8, N'1991-02-28', N'QBILJ', N'Hau Giang', N'GWNXX', N'2510900254', N'MMUQJ@email.com'),
	(N'RUJCR', N'JQMXW', 3, N'1997-09-10', N'BRBXJ', N'Lao Cai', N'KTQNG', N'4067872145', N'ZIUJD@email.com'),
	(N'CEAAX', N'PDLAM', 2, N'1998-10-21', N'CFFGJ', N'Lang Son', N'LWGBW', N'5773136086', N'KBPRU@email.com'),
	(N'HFUUN', N'SHIMT', 6, N'1994-08-16', N'YVTVF', N'Dong Thap', N'HJFOL', N'3678119605', N'ZXIQS@email.com'),
	(N'RQWCZ', N'NHNSS', 4, N'1998-06-04', N'EMLLG', N'Long An', N'RZZBN', N'1236398822', N'XQBGQ@email.com'),
	(N'MDNBL', N'TUYUG', 3, N'1996-11-06', N'HGWAA', N'Tra Vinh', N'HEKHH', N'6150271753', N'ORDBC@email.com'),
	(N'GMGUL', N'JRABB', 8, N'1996-10-03', N'OAAZM', N'Bac Lieu', N'BHVTZ', N'7109991682', N'ZPVUK@email.com'),
	(N'QETCV', N'IFAKI', 2, N'1991-06-18', N'MOWTA', N'Quang Tri', N'LQYZT', N'8512802818', N'CFANJ@email.com'),
	(N'UGKUN', N'CQMVN', 5, N'1995-09-03', N'PEVCK', N'Thua Thien Hue', N'SVRDQ', N'3977741028', N'POVXE@email.com'),
	(N'CQAIU', N'DGVFC', 8, N'1999-01-31', N'GXMVV', N'Cao Bang', N'OMNOD', N'4464219070', N'JOEXB@email.com'),
	(N'BYLQP', N'QJYFU', 5, N'1991-09-15', N'YCYRC', N'Son La', N'LUDVX', N'1786502207', N'CHSJQ@email.com')
GO
INSERT INTO Products(ProductName, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, Active) 
VALUES
	(N'RCUHM', 13, 16, 291232, 550, 1),
	(N'JBKAR', 8, 48, 778156, 2906, 1),
	(N'VDKWT', 13, 74, 538182, 2847, 1),
	(N'ALBQT', 3, 64, 72274, 4580, 1),
	(N'OBZZQ', 20, 68, 209462, 3384, 1),
	(N'HSOGN', 14, 6, 645199, 313, 1),
	(N'KRMCC', 18, 40, 499010, 4606, 1),
	(N'ZWOQB', 13, 20, 794735, 4794, 1),
	(N'KEZOO', 18, 92, 59272, 4816, 1),
	(N'FUSRV', 20, 50, 249076, 1011, 1),
	(N'IHOWN', 5, 120, 194863, 2152, 1),
	(N'ARLFQ', 7, 118, 535251, 2677, 1),
	(N'VGIBR', 14, 70, 667941, 3064, 1),
	(N'ISCUX', 16, 14, 27096, 3000, 1),
	(N'UMYBX', 15, 94, 593513, 603, 1),
	(N'BDSDM', 14, 26, 898765, 4536, 1),
	(N'ACLIO', 6, 70, 185244, 4184, 1),
	(N'LCQMG', 6, 102, 955648, 3244, 1),
	(N'XMWXR', 6, 98, 333986, 684, 1),
	(N'CPOGE', 9, 16, 299791, 2568, 1),
	(N'IOEYL', 17, 82, 678574, 4081, 1),
	(N'PGYNF', 6, 90, 946160, 1598, 1),
	(N'TMEDL', 1, 98, 723618, 2116, 1),
	(N'ULSJT', 17, 2, 875225, 123, 1),
	(N'JSRIQ', 20, 8, 883784, 1411, 1),
	(N'NQDHR', 8, 110, 185144, 545, 1),
	(N'ZKKBI', 19, 102, 181399, 104, 1),
	(N'VZJNH', 8, 68, 661308, 4610, 1),
	(N'QEFQG', 2, 52, 584620, 1867, 1),
	(N'CEISQ', 11, 88, 714848, 902, 1),
	(N'WLYTA', 16, 4, 31533, 3040, 1),
	(N'NBFEI', 12, 14, 907257, 3310, 1),
	(N'DWEIC', 20, 32, 141912, 3766, 1),
	(N'ERLIG', 8, 74, 39866, 1024, 1),
	(N'OMJER', 15, 104, 74491, 4101, 1),
	(N'OMTFE', 1, 10, 830804, 2011, 1),
	(N'UXYXD', 14, 112, 368088, 1613, 1),
	(N'KQJLO', 17, 72, 715817, 4525, 1),
	(N'TFKNP', 17, 20, 714158, 4286, 1),
	(N'CMPPT', 5, 46, 71049, 4792, 1),
	(N'WLGUL', 13, 18, 201251, 1966, 1),
	(N'FBGXY', 20, 76, 856179, 506, 1),
	(N'MRDZA', 11, 8, 495598, 1741, 1),
	(N'FUAZQ', 1, 8, 946772, 137, 1),
	(N'JCUFH', 5, 8, 209403, 3647, 1),
	(N'TKTOE', 10, 96, 993607, 3454, 1),
	(N'USLDH', 11, 58, 697941, 1653, 1),
	(N'LJKNT', 7, 10, 497232, 4520, 1),
	(N'QSJOC', 1, 52, 408311, 982, 1),
	(N'LFXWW', 15, 66, 539923, 4594, 1),
	(N'OZYGH', 14, 94, 906357, 2563, 1),
	(N'KAUEY', 7, 46, 270676, 4653, 1),
	(N'NGVKU', 19, 6, 554288, 4126, 1),
	(N'XLQUY', 7, 92, 836132, 4656, 1),
	(N'ZCANV', 12, 102, 907963, 3888, 1),
	(N'UMJVG', 7, 82, 483571, 2712, 1),
	(N'WWZWA', 2, 96, 266602, 1450, 1),
	(N'KNVKG', 13, 6, 267969, 3276, 1),
	(N'JRCID', 9, 86, 100864, 4394, 1),
	(N'AVTWD', 18, 112, 685767, 149, 1),
	(N'CKIME', 6, 72, 884136, 2399, 1),
	(N'SWNAE', 16, 108, 862876, 2233, 1),
	(N'PEMTQ', 12, 120, 88006, 4104, 1),
	(N'LDBCO', 7, 20, 898359, 3505, 1),
	(N'LQUPN', 5, 98, 83005, 694, 1),
	(N'BAOSK', 5, 88, 265641, 802, 1),
	(N'VYBAI', 12, 102, 172831, 380, 1),
	(N'WZHIL', 18, 56, 825225, 4703, 1),
	(N'HQWIK', 14, 44, 966240, 1060, 1),
	(N'GIGCS', 1, 114, 973482, 4830, 1),
	(N'INJJL', 16, 112, 979829, 1414, 1),
	(N'GGECB', 10, 30, 846435, 299, 1),
	(N'MONBZ', 15, 36, 419046, 1534, 1),
	(N'PEOAV', 11, 46, 676025, 1038, 1),
	(N'TEVEX', 19, 52, 766058, 1039, 1),
	(N'ENRME', 12, 106, 827752, 4646, 1),
	(N'NJTFS', 5, 24, 962763, 2671, 1),
	(N'VTUJC', 11, 112, 200060, 2855, 1),
	(N'YWSOI', 12, 40, 222575, 2733, 1),
	(N'YZFEI', 16, 110, 627792, 3823, 1),
	(N'YUPAI', 19, 76, 807432, 1814, 1),
	(N'IXUHT', 8, 106, 980316, 4872, 1),
	(N'HAXWY', 2, 2, 252223, 3785, 1),
	(N'WXPQT', 19, 20, 504709, 2721, 1),
	(N'AKTPP', 16, 46, 842385, 3482, 1),
	(N'MCTLT', 15, 26, 501182, 1082, 1),
	(N'RLCYU', 6, 66, 337406, 1372, 1),
	(N'BMLUJ', 10, 90, 465278, 2246, 1),
	(N'IPETM', 5, 34, 286191, 1154, 1),
	(N'COTUJ', 20, 82, 848002, 4102, 1),
	(N'KHBVT', 8, 102, 255875, 1666, 1),
	(N'SEDXB', 10, 84, 600923, 2395, 1),
	(N'ZAGID', 14, 94, 686925, 4774, 1),
	(N'CJJRY', 16, 108, 291254, 290, 1),
	(N'QNIBT', 19, 86, 539026, 4390, 1),
	(N'OENQU', 14, 88, 537588, 3878, 1),
	(N'UKJKD', 20, 62, 996511, 2919, 1),
	(N'KKWXP', 6, 32, 303295, 4477, 1),
	(N'VYFQA', 2, 54, 64438, 355, 1),
	(N'CKGLJ', 15, 100, 873153, 1191, 1)
GO
INSERT INTO Promotions(PromotionName, Description) 
VALUES
	(N'CHXIF', N'JTWNFDLXAY'),
	(N'VXUAH', N'ETFXJAOSAM'),
	(N'LWFTL', N'BMREMKQWQF'),
	(N'REOLX', N'QLUKBONLOB'),
	(N'MWOVD', N'YITWICLLHJ'),
	(N'IRUCG', N'AYFURIPFRP'),
	(N'HNQWK', N'PUBELGEFOD'),
	(N'AIZXL', N'SOBKXFWSFV'),
	(N'NHTPN', N'LDRSAQJRXW'),
	(N'RVABK', N'PPYPJLSEVT'),
	(N'RCYKO', N'YWIKEOZAMX'),
	(N'ANVHW', N'LXRHFZSRJO'),
	(N'YUICL', N'YUPQKCYUEM'),
	(N'FWWBY', N'FUVPGNUYHX'),
	(N'LKGGC', N'VZUEJUQWWG'),
	(N'UDPSX', N'QPHHKYKWQO'),
	(N'ZLRFN', N'EADACNQKVE'),
	(N'FPLOM', N'WFVAGBUSNS'),
	(N'TPLFS', N'IKYOASNKHW'),
	(N'YLQKM', N'OAJJRNLWSA'),
	(N'ONDER', N'SUMZCCYPCC'),
	(N'ATROW', N'XYEOOLKZHC'),
	(N'IRYOT', N'COTAWQOJQI'),
	(N'CUPHB', N'PFSLXQBHCP'),
	(N'HDFRH', N'RAZZNRDXAO'),
	(N'YPJXV', N'QOTXCKEEQD'),
	(N'UEIJB', N'HXMDDEEVYU'),
	(N'RIAQM', N'YJDFOAFTED'),
	(N'XKPEU', N'DOWXPKHXHF'),
	(N'MIDFW', N'PYGYZDIFSO'),
	(N'SGTQK', N'MNDJMCIQUL'),
	(N'WIMFN', N'KXKOHZXJYG'),
	(N'RZOBH', N'XRBOZIFYPE'),
	(N'VJKVJ', N'YZMYTDBCGR'),
	(N'SJQTZ', N'DYIFCKZHGQ'),
	(N'YXIYK', N'DPCHRLNOVF'),
	(N'MYRZW', N'MGTXXRKIHQ'),
	(N'WQYPO', N'PWJIRXGUDW'),
	(N'WUNOZ', N'UGOZNTLBTC'),
	(N'HLTJT', N'MLKFHKYWAG'),
	(N'KUYES', N'GRAUBCLHAK'),
	(N'XZXVQ', N'BBDVKOWLNP'),
	(N'NOTJL', N'LVYQVYCKJS'),
	(N'JWPSV', N'MEEDODPZTF'),
	(N'OFWKF', N'ZHILCSEYKM'),
	(N'HZVZT', N'BFLZNGJIMD'),
	(N'HLFRJ', N'UDOQLMCJRG'),
	(N'WJGLH', N'EHMHFAHERW'),
	(N'VGMON', N'XBQAYISZED'),
	(N'AQTCJ', N'TNORZTYCSE')
GO
INSERT INTO Events(PromotionID, ProductID, StartDate, EndDate, LimitQuantity, Discount, Description) 
VALUES
	(2, 97, N'2010-02-18', N'2010-07-18', 600, 0.49, N'OFPELXIDPS'),
	(26, 9, N'2020-06-05', N'2020-11-05', 100, 0.34, N'LRCCHCWKCY'),
	(15, 91, N'2011-08-06', N'2011-09-06', 100, 0.33, N'BBZRXDFTDW'),
	(37, 51, N'2012-07-28', N'2012-11-28', 500, 0.45, N'NZOKFXYDMT'),
	(39, 74, N'2004-12-29', N'2005-05-29', 500, 0.21, N'NBKZIRGSQF'),
	(33, 71, N'2015-04-11', N'2015-08-11', 500, 0.04, N'IITRAGCYEV'),
	(34, 93, N'2019-09-19', N'2019-10-19', 1000, 0.4, N'JVDIPAZBMY'),
	(43, 45, N'2020-12-12', N'2021-06-12', 900, 0.58, N'OANBUWCRXE'),
	(3, 36, N'2008-04-02', N'2008-06-02', 700, 0.37, N'OCFTUFEXIX'),
	(14, 53, N'2013-05-07', N'2013-09-07', 700, 0.18, N'LIJQPKXDXV'),
	(2, 70, N'2009-08-12', N'2009-12-12', 1000, 0.32, N'DWIIEMIQCD'),
	(37, 90, N'2001-08-06', N'2002-02-06', 400, 0.23, N'EZDGVWBIBX'),
	(4, 10, N'2011-01-22', N'2011-03-22', 200, 0.3, N'GKOYHUHSRV'),
	(4, 61, N'2002-09-18', N'2003-03-18', 200, 0.25, N'OECNBSVDMO'),
	(10, 19, N'2002-08-15', N'2002-12-15', 900, 0.28, N'JLCNLUIOLQ'),
	(28, 5, N'2011-06-12', N'2011-12-12', 200, 0.42, N'TQRCUOJLJJ'),
	(6, 40, N'2012-07-16', N'2013-01-16', 400, 0.44, N'ETKFEZNJRH'),
	(37, 87, N'2017-11-05', N'2018-02-05', 300, 0.44, N'UYSNXUJROG'),
	(13, 71, N'2007-05-13', N'2007-07-13', 1000, 0.57, N'IIGKCOTIOL'),
	(11, 91, N'2000-05-24', N'2000-08-24', 400, 0.44, N'YGDDFTVLRS'),
	(39, 76, N'2010-02-14', N'2010-06-14', 300, 0.25, N'GYKDUVXOWO'),
	(2, 15, N'2020-11-07', N'2021-03-07', 900, 0.11, N'KWQVWMZSCZ'),
	(28, 76, N'2004-12-12', N'2005-05-12', 100, 0.29, N'STCQIRUIDA'),
	(45, 1, N'2012-07-06', N'2013-01-06', 700, 0.33, N'ILBPVDGWBE'),
	(38, 8, N'2015-07-27', N'2015-08-27', 300, 0.23, N'WCXVFWLJUP'),
	(44, 21, N'2017-08-11', N'2017-11-11', 900, 0.17, N'INXZNGHCAF'),
	(15, 68, N'2003-05-29', N'2003-10-29', 700, 0.31, N'GEGBMDDHED'),
	(39, 3, N'2007-03-14', N'2007-09-14', 400, 0.18, N'DOFLCEDUDL'),
	(37, 35, N'2006-04-03', N'2006-06-03', 200, 0.52, N'WNAWXHXDPR'),
	(17, 81, N'2001-10-30', N'2002-02-28', 700, 0.01, N'BWYVHKUCZE'),
	(29, 86, N'2007-10-25', N'2008-02-25', 1000, 0.45, N'TTCPSCNEQD'),
	(43, 19, N'2011-09-08', N'2011-10-08', 900, 0.54, N'DQQIDZZMGE'),
	(34, 5, N'2018-08-01', N'2018-10-01', 300, 0.06, N'BHTROFYVUA'),
	(18, 99, N'2005-01-08', N'2005-02-08', 800, 0.46, N'LVEXNHVRVF'),
	(17, 59, N'2005-09-14', N'2005-12-14', 500, 0.01, N'XGANHZWICH'),
	(31, 5, N'2005-04-21', N'2005-07-21', 400, 0.35, N'TPJHKPARFA'),
	(18, 39, N'2016-06-14', N'2016-10-14', 400, 0.5, N'HFMFWINVEL'),
	(23, 3, N'2010-05-05', N'2010-06-05', 300, 0.38, N'NOMNWSNJLI'),
	(35, 81, N'2010-11-03', N'2011-01-03', 500, 0.44, N'AZOYWAVQHV'),
	(26, 50, N'2003-09-04', N'2004-02-04', 800, 0.13, N'KTZQJXXVXI'),
	(20, 62, N'2019-01-21', N'2019-06-21', 400, 0.16, N'RNFUSMEFKH'),
	(29, 6, N'2009-05-24', N'2009-07-24', 600, 0.42, N'IHZFACVNMW'),
	(28, 11, N'2009-10-26', N'2010-01-26', 1000, 0.3, N'ACRIUDOCQN'),
	(33, 7, N'2002-03-17', N'2002-06-17', 900, 0.18, N'GGQYUIKNLK'),
	(21, 31, N'2020-08-22', N'2020-09-22', 800, 0.48, N'YZNGOGFPLE'),
	(48, 63, N'2017-05-04', N'2017-06-04', 800, 0.16, N'YJIFFRBWPU'),
	(43, 91, N'2006-08-15', N'2007-01-15', 400, 0.23, N'TSSUFKFCZM'),
	(38, 1, N'2005-10-07', N'2005-11-07', 700, 0.36, N'PZHKLSMBNL'),
	(45, 93, N'2014-11-03', N'2015-05-03', 700, 0.34, N'VBQAWFFJHX'),
	(14, 10, N'2016-04-26', N'2016-05-26', 100, 0.26, N'SCIUTOGQHQ'),
	(35, 100, N'2010-08-29', N'2010-09-29', 400, 0.32, N'QVDHSHQUHD'),
	(20, 4, N'2000-09-19', N'2000-10-19', 600, 0.2, N'TTNGZOKOXD'),
	(15, 23, N'2003-10-14', N'2003-11-14', 500, 0.19, N'ZHVFHODTDX'),
	(37, 23, N'2012-11-29', N'2013-04-29', 500, 0.12, N'QISWAXQBAI'),
	(3, 84, N'2017-04-25', N'2017-09-25', 800, 0.03, N'NFCYSJICGN'),
	(35, 48, N'2004-01-05', N'2004-03-05', 400, 0.01, N'RNZFZEEMLD'),
	(16, 33, N'2006-05-15', N'2006-10-15', 400, 0.28, N'YSHXRJEITF'),
	(45, 78, N'2007-03-21', N'2007-09-21', 100, 0.33, N'JWWKTDPNRS'),
	(36, 62, N'2016-02-12', N'2016-08-12', 900, 0.45, N'EYQVQIVCXQ'),
	(21, 97, N'2010-04-12', N'2010-05-12', 600, 0.56, N'MTCVCGYDDD'),
	(16, 45, N'2011-07-27', N'2011-12-27', 400, 0.45, N'TWWAXPOSYM'),
	(24, 23, N'2015-06-12', N'2015-12-12', 900, 0.09, N'GHOBJGMRIS'),
	(47, 27, N'2013-06-11', N'2013-09-11', 700, 0.38, N'DNBQXOTIEH'),
	(41, 52, N'2015-09-14', N'2015-12-14', 400, 0.28, N'VFWNCZQWYF'),
	(6, 12, N'2008-08-31', N'2009-02-28', 300, 0.34, N'WYOUSOBGHI'),
	(35, 49, N'2007-09-06', N'2007-11-06', 700, 0.03, N'XXPLGNPEQO'),
	(19, 19, N'2010-06-26', N'2010-08-26', 900, 0.42, N'UKVKCGDKYP'),
	(48, 97, N'2005-12-25', N'2006-06-25', 900, 0.52, N'EJAGRNPHMK'),
	(29, 6, N'2018-01-22', N'2018-03-22', 900, 0.25, N'DUSWVSQONU'),
	(25, 20, N'2009-09-28', N'2009-12-28', 500, 0.25, N'MIRBSDKVBO'),
	(24, 95, N'2003-02-01', N'2003-05-01', 1000, 0.2, N'LISOVGNTNO'),
	(33, 85, N'2014-05-22', N'2014-06-22', 300, 0.45, N'WDTKDFYTTH'),
	(43, 94, N'2002-08-24', N'2002-09-24', 800, 0.49, N'RGTREQQRGN'),
	(43, 36, N'2006-01-09', N'2006-04-09', 500, 0.38, N'NMKGZLFIUU'),
	(11, 29, N'2007-03-18', N'2007-06-18', 500, 0.57, N'LIHZFYPJBQ'),
	(35, 92, N'2013-11-03', N'2014-03-03', 300, 0.33, N'BTGKNIJKFE'),
	(24, 26, N'2010-02-28', N'2010-03-28', 1000, 0.34, N'ISTQJSGQFX'),
	(35, 65, N'2017-07-11', N'2018-01-11', 300, 0.5, N'VYFFZZVRPI'),
	(5, 98, N'2004-03-04', N'2004-06-04', 800, 0.44, N'OSAITPTAOR'),
	(30, 10, N'2013-08-06', N'2014-01-06', 400, 0.21, N'UMQZPXGBWZ'),
	(45, 85, N'2004-11-13', N'2005-04-13', 200, 0.37, N'IAXAFWLLJK'),
	(48, 55, N'2001-07-27', N'2001-12-27', 900, 0.34, N'BSWSHYFOJA'),
	(8, 94, N'2012-07-14', N'2013-01-14', 700, 0.54, N'YMQTTPDIOX'),
	(43, 29, N'2020-05-11', N'2020-07-11', 1000, 0.04, N'UYQGQVGVXR'),
	(50, 85, N'2011-06-28', N'2011-08-28', 500, 0.47, N'JDUTFVLRLF'),
	(34, 40, N'2013-06-02', N'2013-07-02', 800, 0.28, N'CTSESQGWBT'),
	(12, 41, N'2010-10-16', N'2011-04-16', 100, 0.17, N'GGDCNRTGRE'),
	(9, 29, N'2014-05-15', N'2014-07-15', 500, 0.5, N'GKSNGZBGPH'),
	(6, 9, N'2006-02-05', N'2006-05-05', 900, 0.04, N'BYGBHRMLSZ'),
	(42, 100, N'2010-06-23', N'2010-07-23', 1000, 0.08, N'YGADCZMLCH'),
	(35, 82, N'2020-10-01', N'2020-12-01', 600, 0.55, N'UXWXTWRTIY'),
	(40, 74, N'2002-04-20', N'2002-08-20', 400, 0.34, N'SMEGREQRDT'),
	(25, 50, N'2004-05-13', N'2004-07-13', 400, 0.3, N'MHBAAOKKCI'),
	(25, 15, N'2016-09-13', N'2017-03-13', 800, 0.04, N'VLIEZBIMKG'),
	(5, 14, N'2002-07-01', N'2003-01-01', 400, 0.52, N'ELUWUKKNHZ'),
	(21, 100, N'2012-09-20', N'2012-11-20', 600, 0.45, N'VEDIBHKONM'),
	(22, 93, N'2018-11-01', N'2019-02-01', 700, 0.04, N'OPVKNCEVBW'),
	(50, 96, N'2017-12-31', N'2018-03-31', 900, 0.53, N'GTYIKQDKZH'),
	(50, 10, N'2005-05-03', N'2005-08-03', 300, 0.59, N'DQMOXOMZQN'),
	(36, 62, N'2015-06-14', N'2015-07-14', 900, 0.51, N'JPEBNXYNEU'),
	(26, 2, N'2017-12-30', N'2018-06-30', 700, 0.47, N'EOKBGKQFMJ'),
	(17, 75, N'2016-12-18', N'2017-06-18', 1000, 0.32, N'MNSQNAMCRX'),
	(21, 38, N'2002-02-26', N'2002-08-26', 700, 0.26, N'QTJACPXVGG'),
	(35, 47, N'2019-11-28', N'2019-12-28', 100, 0.1, N'QKKDODLSBF'),
	(33, 32, N'2000-07-02', N'2000-11-02', 200, 0.42, N'AUMISMCTBW'),
	(41, 38, N'2002-12-08', N'2003-05-08', 800, 0.08, N'BXLIPCQSQS'),
	(27, 37, N'2010-07-26', N'2010-08-26', 400, 0.38, N'LMURYFYCLH'),
	(43, 52, N'2006-06-01', N'2006-08-01', 100, 0.24, N'CWCOPOULMO'),
	(45, 58, N'2015-10-02', N'2016-04-02', 500, 0.02, N'OVOUYIFPIJ'),
	(36, 97, N'2011-01-01', N'2011-06-01', 900, 0.47, N'NHYKOECXDL'),
	(15, 19, N'2020-09-10', N'2020-10-10', 400, 0.5, N'JJOESWXJKQ'),
	(41, 4, N'2013-06-27', N'2013-09-27', 900, 0.55, N'PFFPAPXXEI'),
	(46, 89, N'2005-07-17', N'2005-10-17', 900, 0.59, N'TFJLQDRAST'),
	(49, 53, N'2007-07-19', N'2007-12-19', 500, 0.2, N'SOZCMYFIVH'),
	(10, 22, N'2017-08-22', N'2018-01-22', 800, 0.32, N'FSZNGFLIKF'),
	(27, 42, N'2009-02-14', N'2009-07-14', 200, 0.03, N'EBHVWHHWHO'),
	(34, 24, N'2011-09-08', N'2012-03-08', 900, 0.25, N'FJIGBZHPFR'),
	(20, 46, N'2010-06-28', N'2010-11-28', 200, 0.01, N'KQLNZWDGYS'),
	(10, 26, N'2010-05-05', N'2010-11-05', 200, 0.23, N'HYUNCLVPBI'),
	(26, 99, N'2013-12-03', N'2014-06-03', 800, 0.03, N'QVSUWWYZYP'),
	(14, 13, N'2000-11-21', N'2001-04-21', 600, 0.59, N'XJKWTGAEMA'),
	(15, 18, N'2012-03-14', N'2012-08-14', 100, 0.14, N'GGZRCVSUTL'),
	(45, 65, N'2012-11-01', N'2013-01-01', 200, 0.02, N'OIHPLWIKQU'),
	(7, 42, N'2000-07-10', N'2000-12-10', 300, 0.28, N'RPJRBKDPFW'),
	(44, 40, N'2002-02-20', N'2002-03-20', 300, 0.24, N'YIIONZDCGH'),
	(44, 51, N'2018-10-17', N'2019-04-17', 100, 0.5, N'ICSSZKHAEB'),
	(37, 58, N'2009-10-29', N'2010-02-28', 1000, 0.49, N'WDPOKZYPEL'),
	(26, 52, N'2014-01-29', N'2014-04-29', 700, 0.04, N'JCSDIZZFAF'),
	(36, 11, N'2019-06-23', N'2019-11-23', 900, 0.53, N'RGRDKQPGWA'),
	(34, 48, N'2016-06-08', N'2016-09-08', 500, 0.35, N'TTQRCMNAYC')
GO
INSERT INTO Suppliers(CompanyName, Contact, ContactTitle, Address, City, District, Phone, Fax) 
VALUES
	(N'OKDKT', N'RUKXH', N'BDPTK', N'XWUNY', N'Ca Mau', N'MIIHT', N'8870983821', N'49783172'),
	(N'BPFEB', N'SDZFS', N'MTMXB', N'NPNHN', N'Lai Chau', N'FJQAC', N'6231919107', N'45880897'),
	(N'GORKQ', N'SSWJF', N'QGXRM', N'CAXFN', N'Nam Dinh', N'TGRRF', N'6143122391', N'05537856'),
	(N'BVOIG', N'OWDNY', N'HYPPL', N'TDNMO', N'Tuyen Quang', N'TJBQK', N'8116298799', N'58288252'),
	(N'AXEOF', N'QTKFO', N'RVEJX', N'CVFBA', N'Hai Duong', N'SQIXV', N'1117521745', N'83836488'),
	(N'TIPOQ', N'GBTOO', N'RRSJY', N'TXLYP', N'Cao Bang', N'QFHLP', N'8205293914', N'32732765'),
	(N'NIMUB', N'ZODPG', N'XXDZR', N'EXZOA', N'Thanh Hoa', N'YYZWA', N'7048796725', N'43652661'),
	(N'LPRFJ', N'AWXDM', N'VOONJ', N'FHDGG', N'Ha Tinh', N'GXQOF', N'5762035537', N'01266427'),
	(N'ALKBQ', N'BSQNC', N'LIDYG', N'KEICO', N'Tuyen Quang', N'VBOTR', N'3470448356', N'07122036'),
	(N'SEXWL', N'EXWGE', N'IBFTX', N'DXSVB', N'Ha Nam', N'TZTVJ', N'5699419343', N'00172512'),
	(N'AFIIR', N'LKITF', N'AECCU', N'OBVQU', N'Ha Tinh', N'ZCWSG', N'5202274526', N'75311331'),
	(N'OPIZV', N'UBYZU', N'IPYXL', N'IPBWS', N'Hoa Binh', N'LSLWY', N'8518320989', N'80447855'),
	(N'QZIYR', N'YDODK', N'TXGWT', N'TMWOH', N'Thai Nguyen', N'LYRAH', N'1581260552', N'18875416'),
	(N'ILIZI', N'AMFAL', N'KHEYE', N'UYZIM', N'Ho Chi Minh', N'KNJKK', N'5699105037', N'84793524'),
	(N'SJWVR', N'AAVEB', N'QIPUF', N'UUCPL', N'Cao Bang', N'IVKJP', N'6902727095', N'95651844'),
	(N'DRAHQ', N'HGEMC', N'SPWOB', N'XSHNZ', N'Dong Nai', N'WOVYB', N'1892856015', N'15454723'),
	(N'ZQRYT', N'BVNUF', N'SVGPE', N'DZVTB', N'Da Nang', N'CBOVH', N'3189380892', N'59284154'),
	(N'SIYXI', N'RAROF', N'ZUWIX', N'VOYUW', N'Dong Nai', N'RFGBL', N'1306096981', N'68129043')
GO
INSERT INTO Receipts(EmployeeID, CustomerID, ReceiveDate, ReceiveMethod) 
VALUES
	(8, 1, N'2005-04-20', N'QR pay'),
	(8, 2, N'2012-06-25', N'QR pay'),
	(13, 3, N'2009-05-22', N'QR pay'),
	(6, 4, N'2018-06-26', N'cash'),
	(10, 5, N'2011-02-24', N'QR pay'),
	(15, 6, N'2012-01-17', N'cash'),
	(9, 7, N'2012-12-21', N'e-banking'),
	(13, 8, N'2008-05-25', N'COD'),
	(13, 9, N'2003-05-08', N'e-wallet'),
	(11, 10, N'2012-03-01', N'cash'),
	(6, 11, N'2007-11-12', N'QR pay'),
	(14, 12, N'2017-09-08', N'QR pay'),
	(6, 13, N'2017-12-25', N'e-banking'),
	(14, 14, N'2014-02-09', N'cash'),
	(8, 15, N'2019-05-18', N'QR pay'),
	(8, 16, N'2013-03-16', N'e-banking'),
	(12, 17, N'2008-07-05', N'e-wallet'),
	(6, 18, N'2021-08-18', N'e-banking'),
	(10, 19, N'2014-10-24', N'e-banking'),
	(12, 20, N'2013-10-23', N'cash'),
	(15, 21, N'2003-02-03', N'QR pay'),
	(7, 22, N'2001-03-12', N'e-wallet'),
	(12, 23, N'2015-07-06', N'cash'),
	(7, 24, N'2008-08-05', N'QR pay'),
	(10, 25, N'2002-11-24', N'e-banking'),
	(11, 26, N'2019-06-01', N'COD'),
	(13, 27, N'2013-07-04', N'COD'),
	(10, 28, N'2011-06-22', N'COD'),
	(11, 29, N'2013-11-04', N'COD'),
	(9, 30, N'2006-11-15', N'COD'),
	(14, 31, N'2018-09-09', N'QR pay'),
	(15, 32, N'2017-06-23', N'cash'),
	(12, 33, N'2012-04-13', N'COD'),
	(15, 34, N'2001-06-16', N'cash'),
	(11, 35, N'2002-12-15', N'cash'),
	(10, 36, N'2003-05-23', N'cash'),
	(10, 37, N'2004-01-28', N'e-wallet'),
	(6, 38, N'2001-01-10', N'cash'),
	(12, 39, N'2013-06-23', N'COD'),
	(8, 40, N'2003-03-07', N'cash'),
	(8, 41, N'2019-08-19', N'QR pay'),
	(7, 42, N'2000-02-10', N'cash'),
	(14, 43, N'2016-08-12', N'COD'),
	(9, 44, N'2011-07-28', N'e-banking'),
	(15, 45, N'2019-12-12', N'COD'),
	(13, 46, N'2010-01-22', N'cash'),
	(10, 47, N'2005-07-20', N'e-banking'),
	(14, 48, N'2008-05-29', N'e-banking'),
	(10, 49, N'2012-03-10', N'COD'),
	(10, 50, N'2010-02-21', N'e-banking'),
	(13, 51, N'2012-06-04', N'cash'),
	(9, 52, N'2012-08-18', N'e-banking'),
	(8, 53, N'2014-05-18', N'COD'),
	(13, 54, N'2000-02-21', N'QR pay'),
	(10, 55, N'2003-04-19', N'cash'),
	(8, 56, N'2017-06-10', N'QR pay'),
	(14, 57, N'2017-09-30', N'e-wallet'),
	(12, 58, N'2004-09-07', N'COD'),
	(15, 59, N'2020-08-03', N'e-banking'),
	(11, 60, N'2005-09-13', N'COD'),
	(11, 61, N'2008-01-31', N'cash'),
	(8, 62, N'2004-08-05', N'QR pay'),
	(6, 63, N'2019-12-02', N'COD'),
	(15, 64, N'2021-04-28', N'cash'),
	(13, 65, N'2020-01-26', N'cash'),
	(8, 66, N'2009-10-05', N'COD'),
	(6, 67, N'2003-08-10', N'e-banking'),
	(6, 68, N'2014-04-19', N'e-banking'),
	(12, 69, N'2015-05-07', N'cash'),
	(9, 70, N'2001-06-03', N'e-banking'),
	(12, 71, N'2005-10-28', N'QR pay'),
	(15, 72, N'2016-07-14', N'e-wallet'),
	(11, 73, N'2002-09-20', N'QR pay'),
	(14, 74, N'2003-09-04', N'e-banking'),
	(15, 75, N'2001-03-15', N'COD'),
	(11, 76, N'2016-06-27', N'QR pay'),
	(9, 77, N'2020-03-16', N'cash'),
	(9, 78, N'2001-06-24', N'COD'),
	(13, 79, N'2020-07-27', N'QR pay'),
	(10, 80, N'2002-10-27', N'e-banking'),
	(15, 81, N'2014-01-13', N'COD'),
	(13, 82, N'2020-12-19', N'e-wallet'),
	(8, 83, N'2005-06-18', N'COD'),
	(7, 84, N'2012-07-06', N'e-banking'),
	(13, 85, N'2006-10-17', N'cash'),
	(6, 86, N'2009-12-22', N'QR pay'),
	(15, 87, N'2004-02-12', N'e-banking'),
	(9, 88, N'2013-11-08', N'cash'),
	(6, 89, N'2011-07-29', N'e-wallet'),
	(15, 90, N'2018-11-20', N'cash'),
	(8, 91, N'2020-11-27', N'e-banking'),
	(10, 92, N'2019-04-19', N'cash'),
	(14, 93, N'2019-07-30', N'COD'),
	(9, 94, N'2015-09-01', N'e-wallet'),
	(6, 95, N'2004-11-29', N'COD'),
	(9, 96, N'2007-09-29', N'QR pay'),
	(7, 97, N'2000-01-10', N'e-banking'),
	(13, 98, N'2004-02-04', N'cash'),
	(8, 99, N'2007-04-13', N'COD'),
	(6, 100, N'2017-02-10', N'COD'),
	(15, 101, N'2020-07-09', N'cash'),
	(15, 102, N'2014-05-18', N'e-wallet'),
	(8, 103, N'2013-09-16', N'e-banking'),
	(14, 104, N'2019-01-08', N'e-wallet'),
	(7, 105, N'2004-03-08', N'QR pay'),
	(6, 106, N'2014-06-17', N'QR pay'),
	(15, 107, N'2020-12-28', N'QR pay'),
	(12, 108, N'2010-10-24', N'cash'),
	(12, 109, N'2013-04-21', N'COD'),
	(15, 110, N'2016-05-19', N'COD'),
	(14, 111, N'2016-01-19', N'QR pay'),
	(14, 112, N'2012-06-13', N'e-banking'),
	(6, 113, N'2017-07-08', N'COD'),
	(10, 114, N'2021-08-15', N'QR pay'),
	(11, 115, N'2002-07-24', N'e-banking'),
	(6, 116, N'2011-08-02', N'QR pay'),
	(9, 117, N'2007-11-08', N'QR pay'),
	(12, 118, N'2013-06-27', N'COD'),
	(6, 119, N'2010-12-15', N'QR pay'),
	(12, 120, N'2011-01-25', N'QR pay'),
	(9, 121, N'2001-03-23', N'QR pay'),
	(11, 122, N'2019-08-13', N'e-wallet'),
	(12, 123, N'2011-12-25', N'QR pay'),
	(7, 124, N'2010-06-25', N'COD'),
	(13, 125, N'2014-09-02', N'QR pay'),
	(9, 126, N'2006-03-27', N'COD'),
	(13, 127, N'2009-12-30', N'QR pay'),
	(8, 128, N'2000-06-29', N'cash'),
	(13, 129, N'2009-05-29', N'e-banking'),
	(14, 130, N'2020-06-28', N'COD'),
	(8, 131, N'2005-12-19', N'QR pay'),
	(11, 132, N'2002-12-01', N'COD'),
	(12, 133, N'2021-04-30', N'QR pay'),
	(11, 134, N'2015-08-20', N'QR pay'),
	(11, 135, N'2004-07-11', N'e-wallet'),
	(13, 136, N'2014-10-14', N'COD'),
	(6, 137, N'2006-12-05', N'e-wallet'),
	(8, 138, N'2011-04-20', N'COD'),
	(6, 139, N'2018-04-24', N'cash'),
	(6, 140, N'2018-04-15', N'cash'),
	(11, 141, N'2013-01-13', N'cash'),
	(8, 142, N'2018-07-15', N'QR pay'),
	(13, 143, N'2004-05-11', N'QR pay'),
	(15, 144, N'2016-03-21', N'e-banking'),
	(13, 145, N'2006-06-20', N'QR pay'),
	(13, 146, N'2009-08-01', N'cash'),
	(6, 147, N'2004-12-05', N'QR pay'),
	(11, 148, N'2013-10-15', N'e-wallet'),
	(10, 149, N'2019-08-28', N'e-banking'),
	(14, 150, N'2021-07-09', N'COD'),
	(9, 151, N'2018-03-01', N'e-wallet'),
	(14, 152, N'2009-09-24', N'cash'),
	(8, 153, N'2005-06-11', N'e-banking'),
	(10, 154, N'2016-04-05', N'cash'),
	(9, 155, N'2012-01-02', N'e-wallet'),
	(13, 156, N'2008-03-02', N'e-banking'),
	(8, 157, N'2012-06-27', N'COD'),
	(7, 158, N'2015-09-07', N'e-wallet'),
	(14, 159, N'2019-04-14', N'e-wallet'),
	(14, 160, N'2008-05-24', N'COD'),
	(15, 161, N'2016-06-03', N'cash'),
	(6, 162, N'2006-06-08', N'COD'),
	(6, 163, N'2017-02-23', N'e-wallet'),
	(9, 164, N'2018-01-29', N'cash'),
	(8, 165, N'2019-08-31', N'COD'),
	(14, 166, N'2009-06-26', N'e-banking'),
	(12, 167, N'2001-11-09', N'COD'),
	(12, 168, N'2020-03-29', N'cash'),
	(14, 169, N'2013-11-11', N'cash'),
	(10, 170, N'2009-05-21', N'COD'),
	(6, 171, N'2019-04-05', N'COD'),
	(15, 172, N'2015-09-28', N'COD'),
	(6, 173, N'2019-02-23', N'e-banking'),
	(11, 174, N'2003-07-02', N'e-wallet'),
	(12, 175, N'2007-12-24', N'e-wallet'),
	(12, 176, N'2001-12-05', N'e-banking'),
	(15, 177, N'2009-12-26', N'e-banking'),
	(8, 178, N'2006-02-16', N'QR pay'),
	(6, 179, N'2016-09-27', N'e-banking'),
	(7, 180, N'2016-06-02', N'QR pay'),
	(13, 181, N'2011-10-10', N'e-wallet'),
	(14, 182, N'2011-12-31', N'COD'),
	(10, 183, N'2020-06-18', N'COD'),
	(7, 184, N'2002-05-18', N'e-banking'),
	(14, 185, N'2006-05-01', N'cash'),
	(9, 186, N'2011-11-28', N'COD'),
	(13, 187, N'2009-03-27', N'e-banking'),
	(6, 188, N'2019-07-16', N'QR pay'),
	(10, 189, N'2016-09-01', N'COD'),
	(8, 190, N'2006-06-29', N'COD'),
	(8, 191, N'2011-11-24', N'e-banking'),
	(12, 192, N'2012-05-31', N'cash'),
	(11, 193, N'2011-09-18', N'e-banking'),
	(7, 194, N'2005-10-23', N'e-banking'),
	(8, 195, N'2002-08-06', N'COD')
GO
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 40, 263964, 46, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 23, 911347, 34, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 17, 461291, 9, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 94, 759362, 8, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 59, 865018, 15, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 79, 483436, 9, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 95, 54779, 39, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 63, 226188, 20, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 11, 935612, 27, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 37, 76511, 22, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(1, 99, 644017, 46, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 9, 266841, 44, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 43, 230983, 25, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 53, 881343, 33, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 66, 932216, 1, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 52, 886152, 29, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 91, 707673, 32, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 72, 435432, 3, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 15, 213540, 18, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 1, 304049, 36, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(2, 79, 137186, 31, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 63, 111197, 4, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 56, 365429, 24, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 8, 61655, 31, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 96, 613709, 16, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 27, 41232, 3, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 36, 891261, 1, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 44, 842130, 14, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 99, 449884, 35, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 90, 815051, 12, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 41, 31254, 30, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 53, 586156, 27, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 11, 411272, 31, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 88, 434940, 22, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 74, 972286, 31, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 31, 207818, 48, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 48, 759112, 24, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(3, 9, 451805, 25, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 86, 578280, 19, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 77, 82087, 2, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 12, 402741, 16, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 67, 330743, 4, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 16, 873128, 46, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 58, 695368, 22, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 53, 882126, 26, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 33, 131889, 20, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 14, 395756, 8, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(4, 94, 287017, 42, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 3, 998637, 46, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 8, 381648, 9, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 50, 697606, 22, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 9, 860697, 36, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 24, 598935, 6, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 16, 603240, 11, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 39, 962407, 48, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 74, 942852, 32, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 89, 135620, 18, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(5, 17, 742337, 22, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(6, 20, 456224, 33, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(6, 45, 256098, 13, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(6, 37, 609736, 25, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(6, 84, 183733, 2, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(6, 78, 388867, 8, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 5, 707761, 11, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 29, 982022, 43, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 88, 452516, 11, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 33, 697684, 24, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 31, 339645, 46, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 11, 596836, 5, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 68, 443631, 4, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 19, 376855, 15, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 39, 298586, 43, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 38, 556941, 35, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 56, 829089, 34, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 67, 743792, 11, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 6, 435438, 1, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 35, 222362, 19, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(7, 13, 912231, 10, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 76, 658308, 16, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 68, 145203, 20, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 96, 344611, 44, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 20, 721214, 44, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 87, 635246, 37, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 9, 549787, 49, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 2, 974931, 38, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 80, 705046, 12, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(8, 40, 353581, 19, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 58, 95579, 49, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 95, 828520, 34, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 33, 749871, 46, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 26, 102161, 44, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 18, 624554, 1, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 87, 417273, 25, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 49, 589782, 47, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 6, 830139, 48, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(9, 66, 106537, 24, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 70, 934590, 26, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 78, 615668, 31, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 55, 769789, 16, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 39, 43573, 22, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 65, 98148, 2, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 86, 976799, 47, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 56, 742937, 6, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 76, 646187, 34, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 1, 368184, 4, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 42, 727077, 38, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(10, 32, 838092, 48, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 93, 915258, 28, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 45, 218909, 16, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 58, 706357, 42, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 65, 632577, 9, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 9, 996498, 38, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 75, 726852, 22, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 82, 767911, 45, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 20, 764309, 23, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 49, 618896, 30, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 47, 321113, 39, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 98, 813132, 18, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 89, 436970, 15, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 4, 927412, 35, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 1, 690975, 3, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 87, 541305, 11, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(11, 71, 277200, 31, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(12, 17, 51322, 3, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(12, 3, 591456, 29, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(12, 99, 985547, 41, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(13, 34, 753191, 30, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(13, 51, 665446, 7, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(13, 12, 635712, 25, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(13, 99, 994001, 30, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(13, 27, 884816, 19, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(13, 55, 10862, 48, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(14, 62, 360454, 25, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 85, 619786, 43, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 72, 956429, 35, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 79, 916917, 25, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 17, 100218, 33, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 29, 370276, 44, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 22, 675052, 14, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 75, 176603, 26, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 89, 784559, 4, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 37, 472347, 36, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 73, 451011, 8, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 88, 272224, 7, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 6, 144095, 10, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 77, 505534, 37, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 52, 729680, 3, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(15, 61, 320765, 29, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 65, 182034, 4, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 78, 490417, 41, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 62, 362951, 10, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 69, 658325, 2, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 98, 409305, 14, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 17, 395750, 18, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 23, 111320, 29, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 57, 172823, 35, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 14, 997091, 1, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 38, 307950, 34, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 49, 837248, 37, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 10, 279565, 28, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 30, 601213, 36, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(16, 1, 604266, 31, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 100, 647823, 21, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 87, 264385, 41, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 92, 256165, 36, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 66, 85918, 14, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 97, 907148, 15, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 37, 453308, 47, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 64, 283933, 42, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 80, 381857, 20, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 53, 643019, 16, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 40, 430917, 35, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 31, 330998, 44, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 54, 415701, 39, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 42, 248145, 8, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 79, 404814, 47, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 16, 873630, 24, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(17, 96, 920519, 40, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(18, 17, 888272, 28, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(18, 63, 710975, 40, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(18, 8, 574040, 8, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(18, 64, 65059, 43, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(18, 86, 529797, 45, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(19, 39, 721836, 17, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(19, 58, 424389, 30, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(19, 55, 557087, 32, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(19, 7, 103139, 6, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(19, 8, 415341, 3, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(19, 89, 292168, 48, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(20, 30, 538261, 49, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(20, 1, 597811, 4, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(20, 8, 34107, 5, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(20, 53, 518398, 7, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(20, 85, 775931, 29, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(21, 80, 48333, 19, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(21, 85, 62713, 18, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(21, 41, 316889, 9, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(21, 40, 59274, 14, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(21, 14, 547046, 28, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(21, 15, 605985, 12, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(21, 48, 357126, 17, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(21, 10, 752286, 38, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(22, 6, 162826, 23, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(22, 93, 11394, 44, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(22, 58, 373579, 16, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(22, 3, 758963, 30, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(22, 50, 242679, 38, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(22, 100, 472127, 23, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(22, 41, 525389, 3, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(22, 81, 949584, 25, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 3, 115443, 45, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 67, 468433, 41, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 98, 999638, 20, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 16, 947681, 44, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 39, 223051, 15, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 76, 471268, 34, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 72, 792277, 47, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 69, 567242, 10, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 23, 328416, 17, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 52, 262478, 17, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 26, 41139, 47, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 1, 835115, 29, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 90, 284820, 25, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 88, 89397, 49, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(23, 46, 868466, 26, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(24, 42, 247771, 48, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(24, 70, 764415, 39, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(24, 65, 280972, 22, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(24, 53, 669695, 42, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 13, 867895, 31, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 78, 211001, 5, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 99, 581678, 34, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 56, 273923, 3, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 29, 659896, 25, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 55, 491503, 33, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 8, 420909, 25, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 33, 899142, 7, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 12, 288440, 46, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(25, 65, 682107, 5, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 9, 527690, 1, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 37, 254419, 33, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 41, 75253, 49, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 79, 312116, 47, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 67, 796207, 38, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 51, 920344, 9, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 21, 930653, 31, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 31, 353950, 41, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 95, 436539, 36, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 1, 648712, 48, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 76, 613567, 46, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 19, 508623, 25, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 65, 427671, 49, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 44, 599965, 35, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 25, 935648, 48, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 68, 503566, 12, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 14, 330885, 30, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 56, 597006, 4, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(26, 85, 415614, 43, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 90, 565478, 30, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 33, 819331, 40, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 37, 524869, 49, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 68, 614899, 20, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 57, 664214, 3, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 75, 657772, 27, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 17, 480871, 35, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 60, 377091, 14, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 58, 409854, 24, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 46, 101565, 24, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 81, 925390, 41, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 95, 971787, 34, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 40, 640695, 45, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 93, 294917, 22, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(27, 51, 405702, 10, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 24, 999324, 12, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 85, 378887, 17, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 36, 151848, 27, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 81, 97206, 21, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 83, 38993, 6, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 35, 206172, 44, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 40, 83118, 15, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 71, 302023, 4, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 1, 661766, 20, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 31, 833984, 39, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 97, 933322, 38, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 34, 679456, 38, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 3, 67001, 37, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(28, 82, 303275, 6, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 30, 783342, 8, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 18, 366034, 8, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 76, 33434, 13, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 64, 800930, 35, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 39, 800351, 26, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 86, 839923, 34, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 98, 347651, 5, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 26, 954782, 1, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 2, 653839, 40, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 94, 826519, 7, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 24, 27826, 37, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 84, 37964, 10, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 78, 344397, 16, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 53, 427482, 29, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 52, 75413, 17, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 61, 934274, 6, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 73, 419215, 21, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(29, 22, 940550, 17, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 74, 368795, 8, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 86, 15322, 27, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 95, 191455, 40, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 80, 522611, 4, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 96, 501269, 7, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 15, 250756, 11, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 52, 589055, 47, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 55, 343664, 2, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 30, 495895, 25, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 32, 783036, 31, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 21, 710228, 18, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 64, 602770, 4, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 53, 624997, 15, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(30, 25, 641206, 34, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 40, 63286, 37, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 82, 314315, 23, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 58, 658547, 21, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 94, 571573, 24, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 69, 260748, 29, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 61, 794592, 23, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 37, 736816, 43, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 70, 611175, 35, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 72, 104775, 13, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 33, 474440, 28, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(31, 75, 746914, 33, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(32, 48, 768227, 5, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(32, 64, 714272, 14, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(32, 24, 660947, 15, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(32, 10, 913514, 29, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(33, 34, 970736, 36, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(33, 22, 738560, 20, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(33, 59, 71170, 3, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(33, 33, 879866, 14, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(33, 48, 729849, 32, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(33, 10, 400359, 48, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(34, 8, 971649, 28, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(34, 3, 385106, 43, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(34, 64, 479697, 14, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 22, 496258, 28, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 86, 699625, 47, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 71, 686736, 40, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 77, 982042, 32, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 35, 599829, 7, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 81, 194255, 40, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 15, 586277, 18, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 18, 418221, 6, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 69, 653107, 21, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 46, 322224, 19, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 47, 420899, 18, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 42, 685379, 46, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 78, 593703, 42, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 1, 499803, 19, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(35, 90, 735906, 31, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 1, 113695, 20, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 18, 519632, 8, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 75, 967004, 17, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 84, 642228, 36, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 12, 632681, 20, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 67, 669332, 11, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 39, 198147, 17, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 98, 613160, 31, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 43, 263622, 40, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 48, 184247, 12, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 89, 606987, 11, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 50, 396865, 49, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 60, 779547, 44, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 31, 716383, 43, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 61, 990388, 1, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 55, 469899, 12, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 29, 57085, 25, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 91, 980902, 47, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(36, 73, 951110, 32, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 87, 920478, 17, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 79, 251040, 33, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 56, 369955, 40, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 36, 569849, 37, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 61, 900233, 27, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 89, 997017, 2, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 28, 334403, 9, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 52, 158143, 5, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 58, 125726, 22, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 39, 273811, 46, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 23, 888597, 40, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 63, 314701, 27, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 25, 442276, 48, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(37, 31, 711153, 38, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 51, 946365, 25, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 100, 627860, 24, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 35, 376367, 32, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 11, 680555, 43, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 62, 896052, 40, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 83, 687648, 48, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 97, 725922, 43, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 91, 146598, 23, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 44, 560282, 8, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 68, 602864, 16, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 72, 245987, 18, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 24, 925033, 49, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(38, 88, 553634, 42, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 92, 245415, 23, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 23, 946000, 42, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 83, 662588, 32, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 9, 501385, 40, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 89, 876595, 11, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 22, 985688, 36, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 90, 780980, 39, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 12, 747970, 26, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 66, 758313, 40, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 2, 197743, 22, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 36, 580629, 11, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 61, 236774, 49, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 38, 765930, 9, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 18, 548964, 45, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 39, 371377, 45, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 41, 492139, 31, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 5, 860094, 37, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 53, 752687, 30, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(39, 49, 875509, 33, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 81, 149328, 35, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 52, 61372, 45, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 38, 136303, 32, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 91, 726792, 49, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 62, 163442, 37, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 2, 545416, 30, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 88, 297535, 41, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 57, 557130, 29, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 4, 267468, 40, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(40, 77, 33188, 23, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 24, 919743, 31, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 21, 994041, 29, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 80, 868418, 7, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 25, 555966, 8, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 2, 258278, 2, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 61, 83038, 5, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 43, 142781, 19, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 3, 952105, 18, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 86, 520867, 12, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 39, 130513, 3, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 59, 728244, 15, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 95, 951978, 19, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 40, 101538, 22, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 28, 745667, 45, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 34, 680218, 27, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 46, 782299, 31, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 44, 821121, 47, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(41, 96, 835926, 2, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 74, 345867, 2, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 18, 572461, 46, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 80, 678540, 27, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 34, 593057, 34, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 53, 254371, 23, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 54, 248977, 31, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 96, 738037, 40, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 82, 552626, 47, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 10, 732132, 46, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(42, 58, 758600, 18, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 71, 675940, 46, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 9, 670623, 14, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 14, 844658, 48, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 20, 750262, 33, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 4, 121469, 18, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 45, 917794, 17, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 32, 203276, 33, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 93, 219285, 34, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 81, 490758, 32, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 77, 782748, 23, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 61, 202413, 6, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 19, 257907, 22, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 37, 446292, 14, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 2, 987262, 18, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 62, 262478, 10, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(43, 68, 340331, 30, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 21, 237441, 33, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 79, 884326, 9, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 27, 894772, 49, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 78, 886070, 26, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 20, 554496, 33, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 2, 298814, 31, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 13, 207268, 21, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 23, 668325, 28, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 82, 520465, 36, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 47, 852674, 31, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 58, 675265, 19, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 40, 36719, 6, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 86, 799824, 34, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 50, 674859, 43, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(44, 33, 202976, 29, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 33, 500933, 6, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 46, 298874, 44, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 88, 999982, 5, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 39, 11663, 43, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 71, 819373, 9, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 83, 575914, 34, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 47, 84086, 9, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 80, 133265, 22, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(45, 26, 281832, 26, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(46, 76, 492924, 23, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(46, 19, 180268, 23, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 11, 779045, 37, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 25, 113983, 21, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 80, 467407, 13, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 43, 420628, 41, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 28, 902308, 10, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 99, 360737, 21, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 15, 627997, 22, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 35, 560413, 25, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 3, 848681, 29, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 41, 131609, 32, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 6, 603173, 23, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 44, 278908, 38, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(47, 85, 135353, 44, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(48, 29, 199297, 26, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(48, 9, 628161, 39, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(48, 23, 127129, 14, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 24, 535387, 48, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 95, 343909, 30, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 100, 336128, 14, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 28, 415545, 24, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 52, 345848, 41, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 84, 177308, 23, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 20, 772275, 39, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 57, 662253, 24, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 75, 957127, 2, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 96, 603211, 12, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(49, 94, 981186, 38, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(50, 37, 623937, 25, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(50, 42, 210364, 47, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 11, 573835, 47, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 56, 887290, 36, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 90, 65913, 36, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 58, 226961, 33, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 74, 129089, 47, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 89, 774671, 24, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 46, 483303, 17, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 3, 797533, 32, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 41, 407820, 42, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 52, 170616, 43, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 48, 88494, 33, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 22, 890609, 18, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 29, 962288, 19, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 20, 777696, 42, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 96, 772164, 22, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 2, 301933, 5, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 39, 581905, 9, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 79, 725834, 40, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(51, 61, 406338, 28, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(52, 30, 211122, 29, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(52, 4, 317347, 5, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(52, 19, 868286, 37, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(52, 24, 438504, 14, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 2, 912083, 25, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 36, 901398, 21, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 96, 958768, 37, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 97, 587036, 18, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 32, 161538, 29, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 49, 133273, 18, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 83, 41689, 11, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 58, 717343, 21, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 66, 778958, 4, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 70, 65788, 45, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 59, 666900, 40, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 82, 242526, 6, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 61, 767792, 41, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 73, 749518, 17, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 4, 551708, 37, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 22, 579843, 32, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 1, 697499, 19, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(53, 89, 507616, 14, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(54, 99, 978022, 31, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(54, 5, 716836, 29, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(54, 36, 89449, 47, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(54, 76, 124501, 47, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(54, 17, 692645, 41, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(54, 56, 481368, 5, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(55, 50, 291169, 20, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(55, 47, 327175, 29, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(55, 9, 786011, 17, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(56, 63, 418980, 22, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 30, 714262, 27, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 22, 359225, 40, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 42, 998517, 2, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 15, 966276, 41, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 82, 186155, 34, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 68, 526880, 31, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 77, 828474, 48, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 36, 864697, 13, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 83, 884015, 16, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 48, 960055, 37, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(57, 1, 239786, 36, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 72, 816651, 13, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 94, 882294, 20, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 58, 826567, 23, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 47, 419352, 2, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 93, 562529, 21, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 20, 55308, 45, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 62, 42091, 25, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 23, 712312, 41, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 48, 929742, 28, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(58, 51, 231915, 49, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 45, 627513, 14, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 28, 242672, 23, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 22, 574353, 46, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 19, 447445, 47, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 49, 834563, 47, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 76, 588011, 31, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 42, 241251, 40, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 38, 559132, 3, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 79, 190430, 16, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 48, 890415, 3, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 61, 865664, 17, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 43, 155877, 19, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 85, 879051, 13, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 87, 623831, 45, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 27, 734501, 37, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 59, 366079, 39, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 9, 666010, 28, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 25, 366392, 17, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(59, 97, 848853, 42, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(60, 13, 377084, 45, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(60, 21, 346282, 35, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(60, 15, 338262, 42, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(60, 31, 828493, 31, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(60, 81, 661520, 39, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(60, 18, 733625, 19, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(60, 1, 913635, 28, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(60, 24, 549268, 12, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 4, 128682, 38, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 69, 260232, 26, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 53, 277906, 25, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 31, 656585, 40, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 65, 813306, 14, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 52, 747827, 41, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 70, 504894, 21, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 57, 646021, 16, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 35, 103129, 47, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 16, 495009, 7, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 20, 431642, 35, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 29, 173595, 16, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 97, 759928, 13, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 23, 829688, 32, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 48, 105933, 44, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 89, 352143, 14, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 58, 849106, 15, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 6, 727347, 27, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 18, 693306, 24, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(61, 80, 965230, 1, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 61, 714380, 45, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 33, 430494, 5, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 19, 804787, 22, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 74, 570077, 23, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 66, 25455, 8, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 89, 63036, 25, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 15, 986115, 35, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 68, 810143, 46, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 9, 440374, 31, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 24, 467102, 24, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 21, 914703, 33, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(62, 3, 612861, 41, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 75, 807674, 33, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 7, 801454, 41, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 30, 459675, 48, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 34, 774270, 5, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 22, 352405, 45, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 87, 424141, 3, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 42, 19731, 14, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 36, 883095, 16, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 74, 182333, 23, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 92, 407043, 34, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 86, 214616, 37, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(63, 89, 307948, 8, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 1, 432889, 40, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 74, 257577, 29, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 73, 541175, 42, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 41, 548828, 40, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 45, 931519, 31, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 31, 229029, 47, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 4, 502532, 19, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 36, 976291, 23, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 56, 297006, 32, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 58, 393111, 25, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 16, 165407, 3, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 86, 499518, 1, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 19, 930292, 7, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 89, 288927, 6, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 40, 844226, 40, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 81, 296654, 9, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 33, 696090, 5, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 50, 126725, 21, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(64, 69, 719418, 47, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(65, 95, 95918, 35, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(65, 30, 425077, 46, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 100, 479414, 43, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 93, 947946, 35, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 66, 121327, 49, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 58, 589157, 25, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 81, 966624, 24, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 25, 429240, 28, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 21, 790466, 5, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 60, 226983, 39, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 61, 366545, 42, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 22, 683612, 7, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 90, 760567, 1, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 9, 159870, 47, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 20, 465593, 10, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 77, 521912, 28, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 12, 832441, 47, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 15, 448598, 2, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 65, 134415, 18, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 43, 487998, 4, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 82, 742928, 31, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(66, 44, 575231, 48, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 92, 861343, 7, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 100, 477792, 1, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 46, 878774, 22, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 72, 669560, 33, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 21, 503937, 4, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 90, 33253, 45, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 48, 45136, 27, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 22, 381107, 32, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 65, 512534, 32, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 96, 540070, 2, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 76, 886473, 35, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 12, 536478, 11, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(67, 53, 286899, 15, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 73, 366155, 44, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 32, 908653, 4, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 85, 526073, 8, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 70, 382570, 14, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 12, 362500, 9, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 26, 110549, 6, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 57, 303618, 48, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 90, 438432, 38, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 72, 709646, 17, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 95, 51906, 24, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(68, 59, 433698, 38, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 98, 396931, 14, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 61, 61061, 19, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 55, 305118, 45, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 44, 668567, 24, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 22, 163786, 41, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 2, 726503, 28, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 46, 122175, 32, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 54, 81510, 17, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 60, 557973, 6, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 63, 31164, 13, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 79, 509927, 43, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 73, 743362, 38, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 34, 685208, 42, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 85, 344572, 2, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(69, 82, 904215, 33, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(70, 45, 724066, 40, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(70, 98, 405286, 6, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(70, 16, 219688, 31, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(70, 81, 262487, 17, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(70, 9, 494617, 27, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(70, 37, 632332, 20, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(70, 79, 594296, 41, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(70, 65, 36855, 21, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 30, 160723, 2, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 32, 26308, 47, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 71, 628556, 6, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 67, 974312, 39, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 37, 617517, 45, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 94, 961146, 20, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 41, 173871, 26, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 28, 626408, 32, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 92, 357934, 18, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 35, 176909, 18, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 18, 280618, 17, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 88, 527446, 7, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 57, 561736, 8, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 6, 584741, 35, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 91, 35073, 23, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 59, 905614, 22, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 47, 541573, 18, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(71, 84, 373929, 3, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(72, 95, 992503, 40, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(72, 91, 665526, 9, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(72, 26, 233229, 10, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(72, 54, 384471, 2, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 22, 714469, 27, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 79, 257215, 5, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 21, 549195, 37, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 60, 895675, 22, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 92, 678112, 46, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 87, 481363, 6, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 73, 899582, 10, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 37, 160806, 14, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 55, 678014, 9, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 2, 63234, 23, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 85, 82906, 41, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 78, 849895, 32, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 26, 313107, 8, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 89, 839488, 41, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 13, 253405, 13, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 12, 159576, 21, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 75, 506999, 21, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 25, 523161, 9, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 74, 367093, 39, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(73, 45, 137564, 35, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(74, 73, 601162, 25, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(74, 64, 516411, 33, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(75, 21, 800504, 21, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(75, 87, 430825, 37, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(75, 57, 835577, 37, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(75, 1, 193594, 11, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(75, 9, 160101, 41, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(76, 40, 165622, 39, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(76, 43, 91067, 11, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(76, 100, 979724, 42, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(76, 11, 807648, 28, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(76, 58, 580573, 34, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(76, 66, 38901, 39, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(76, 17, 810340, 1, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(76, 78, 870682, 11, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 6, 197063, 21, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 78, 356764, 1, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 48, 12007, 8, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 99, 963563, 30, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 64, 950408, 45, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 18, 825741, 48, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 7, 788923, 1, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 29, 653448, 43, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 30, 431889, 30, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(77, 15, 115031, 1, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(78, 12, 220150, 18, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(78, 80, 487877, 5, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(78, 23, 236958, 5, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(78, 67, 375606, 12, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(78, 47, 623582, 26, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(78, 95, 616670, 49, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(78, 96, 365190, 13, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(78, 27, 842669, 10, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 50, 510162, 12, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 100, 999149, 6, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 24, 805679, 38, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 40, 753050, 21, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 53, 863997, 3, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 12, 90256, 6, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 2, 390146, 49, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 90, 694011, 31, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 71, 237377, 44, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 70, 67076, 3, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 95, 606286, 19, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(79, 81, 61313, 14, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 79, 221259, 45, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 57, 422967, 27, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 38, 708196, 11, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 60, 308564, 47, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 97, 259908, 11, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 82, 923342, 40, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 80, 620580, 38, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 29, 205100, 13, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 58, 504763, 46, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 42, 506039, 49, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 81, 811523, 20, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 95, 649374, 3, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 87, 293904, 11, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 31, 821988, 47, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 16, 862898, 20, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 83, 336967, 2, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(80, 62, 17677, 33, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(81, 62, 640205, 37, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(81, 64, 82077, 12, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(81, 71, 467062, 39, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(81, 25, 733023, 32, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(81, 67, 745639, 25, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 21, 452809, 1, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 53, 900323, 16, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 66, 209153, 24, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 20, 941490, 14, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 52, 303271, 3, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 38, 744035, 4, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 34, 84395, 17, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 4, 655559, 31, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 98, 25304, 17, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 39, 723451, 28, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 49, 440468, 35, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 32, 698668, 21, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 69, 519972, 28, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 9, 123791, 16, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 90, 703715, 16, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 88, 958875, 1, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 40, 578688, 7, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 82, 671576, 36, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(82, 26, 355312, 39, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(83, 43, 580762, 10, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(83, 57, 906716, 11, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(83, 31, 39435, 40, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(83, 96, 773844, 42, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(83, 77, 716405, 29, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(83, 74, 873637, 21, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(84, 5, 537232, 47, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(85, 54, 343820, 28, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(85, 44, 404747, 30, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(85, 76, 372754, 44, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 92, 268997, 48, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 34, 884698, 14, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 29, 310342, 20, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 77, 468418, 6, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 11, 997865, 35, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 69, 495010, 9, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 12, 756935, 27, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 57, 848594, 26, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(86, 41, 399651, 27, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 95, 188966, 25, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 21, 134055, 18, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 65, 781266, 39, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 33, 160487, 37, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 79, 806627, 21, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 61, 804728, 10, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 60, 57402, 21, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 82, 716651, 32, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 29, 355986, 31, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 99, 377883, 35, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 80, 660275, 22, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 83, 198040, 6, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 77, 159895, 17, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 90, 79564, 11, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(87, 45, 457949, 26, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 29, 295098, 7, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 92, 244136, 28, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 82, 613058, 30, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 55, 58332, 29, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 78, 768093, 46, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 15, 488599, 10, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 75, 334020, 26, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 86, 950079, 25, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 63, 753591, 10, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(88, 26, 133898, 38, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(89, 31, 165787, 20, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(89, 87, 531090, 39, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(89, 52, 497263, 44, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(89, 75, 68476, 37, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(89, 21, 22824, 6, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(89, 36, 595985, 23, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(89, 45, 615451, 11, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(89, 48, 134822, 19, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 23, 464409, 14, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 77, 491923, 13, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 81, 532921, 8, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 57, 973522, 17, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 69, 774243, 10, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 34, 342853, 1, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 85, 30145, 21, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 31, 324295, 38, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 36, 77543, 47, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 7, 644442, 7, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 44, 693570, 16, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 30, 627168, 40, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 99, 418244, 11, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(90, 86, 799112, 48, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 94, 70223, 15, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 19, 381316, 19, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 92, 195616, 8, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 33, 899130, 47, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 79, 931648, 3, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 5, 281773, 14, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 37, 436184, 21, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 3, 741327, 4, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 62, 947907, 14, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 52, 46149, 17, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 38, 999776, 5, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 50, 582038, 44, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 8, 582467, 15, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 93, 653404, 20, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 70, 87896, 10, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 36, 966653, 9, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(91, 17, 348478, 31, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(92, 82, 536075, 35, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 78, 19051, 26, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 63, 27940, 46, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 72, 597090, 6, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 95, 262804, 24, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 8, 712268, 6, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 82, 872332, 13, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 60, 860027, 34, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 25, 224634, 30, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 31, 810856, 21, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 45, 434454, 42, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 66, 954190, 38, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 55, 81389, 32, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 7, 196551, 15, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(93, 76, 120262, 30, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(94, 84, 719157, 27, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(94, 35, 563381, 9, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(94, 14, 797161, 39, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(94, 75, 642231, 20, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(94, 44, 189903, 10, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(94, 82, 652152, 27, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(94, 45, 269588, 5, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(95, 55, 617404, 22, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(95, 77, 344514, 48, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(95, 10, 741518, 28, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(95, 83, 24141, 12, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(96, 15, 355860, 31, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(96, 69, 220633, 45, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(96, 18, 159038, 8, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(96, 11, 971984, 17, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(96, 45, 819890, 30, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(96, 72, 832617, 32, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(96, 98, 117729, 13, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(96, 94, 168710, 3, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(97, 7, 660151, 37, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 65, 731472, 28, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 57, 639259, 3, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 66, 265055, 24, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 29, 983756, 45, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 27, 72897, 14, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 24, 449016, 26, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 7, 839730, 24, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 44, 11616, 21, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 85, 936297, 13, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 6, 64381, 4, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 67, 30692, 29, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 22, 468617, 45, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 19, 448125, 45, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 43, 577779, 34, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 30, 417778, 26, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(98, 20, 307507, 11, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 41, 989553, 25, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 20, 183945, 14, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 87, 549483, 49, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 22, 881679, 21, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 18, 805099, 18, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 54, 486487, 27, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 30, 137677, 49, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 39, 382617, 23, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 10, 713696, 13, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 100, 174338, 42, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(99, 16, 902912, 36, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 10, 363715, 26, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 78, 441191, 47, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 84, 940285, 39, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 21, 823529, 35, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 51, 949043, 25, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 72, 847744, 26, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 54, 814507, 31, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 33, 311150, 32, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 17, 145583, 11, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 93, 991172, 39, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 3, 922014, 27, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 67, 78168, 43, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 75, 410796, 43, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 41, 892556, 6, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 35, 232756, 1, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 59, 565599, 11, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 34, 658978, 26, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 89, 744868, 17, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(100, 46, 993989, 45, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 27, 827568, 12, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 49, 735531, 49, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 83, 601408, 33, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 96, 899391, 28, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 65, 126802, 49, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 100, 712264, 13, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 36, 734559, 27, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 74, 570702, 18, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 12, 408247, 13, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 90, 258125, 18, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 30, 418780, 46, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 91, 849601, 44, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 63, 310279, 46, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 84, 691006, 29, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(101, 98, 378793, 36, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(102, 5, 85121, 43, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(102, 83, 469506, 27, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(102, 26, 999433, 41, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(102, 75, 104471, 3, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 86, 497061, 14, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 92, 712273, 4, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 24, 72852, 38, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 39, 846238, 3, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 11, 343635, 35, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 100, 675747, 47, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 25, 305593, 14, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 10, 52405, 18, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 26, 77091, 38, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 59, 747325, 16, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 49, 746589, 49, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 52, 473292, 30, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 43, 677363, 35, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 1, 964812, 46, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 33, 535436, 28, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 72, 257669, 49, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(103, 41, 510298, 34, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(104, 66, 702399, 34, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(104, 27, 980317, 36, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(104, 43, 470873, 24, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(104, 74, 320556, 29, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(104, 8, 715603, 23, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 35, 732877, 28, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 14, 662340, 19, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 67, 426228, 21, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 39, 128967, 35, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 54, 973244, 37, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 48, 128184, 31, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 59, 100523, 21, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 8, 336087, 7, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 9, 819315, 19, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(105, 69, 114686, 28, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 30, 291591, 31, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 57, 867444, 40, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 99, 766924, 1, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 81, 216352, 20, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 94, 388156, 21, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 5, 217027, 21, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 93, 535096, 24, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 74, 236558, 32, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 71, 686871, 45, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 64, 95729, 13, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 69, 524122, 22, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 88, 178884, 24, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 18, 714005, 15, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 37, 686154, 17, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 73, 45665, 20, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 24, 299487, 43, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 8, 499464, 38, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 15, 133139, 7, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 100, 930750, 18, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(106, 10, 791210, 25, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(107, 82, 221284, 10, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(107, 100, 365629, 33, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(107, 36, 398663, 42, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(107, 4, 790028, 32, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(107, 34, 888414, 47, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(107, 56, 772792, 46, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(107, 86, 506076, 24, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(107, 45, 135992, 15, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 45, 633507, 11, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 96, 241926, 27, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 54, 348165, 42, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 47, 783469, 42, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 49, 61642, 43, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 94, 77231, 4, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 68, 479510, 42, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 67, 941710, 6, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 17, 153802, 24, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 1, 389464, 46, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 57, 999426, 39, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 36, 639018, 16, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 21, 976837, 5, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(108, 18, 192086, 22, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(109, 91, 687464, 17, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(109, 7, 45082, 21, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(109, 44, 176041, 13, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(109, 11, 569971, 7, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(109, 12, 837031, 42, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(109, 4, 410652, 46, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(110, 18, 872270, 44, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(110, 14, 215751, 2, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(110, 29, 990338, 38, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(110, 78, 300335, 23, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(111, 93, 181547, 32, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(112, 70, 259496, 30, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(112, 20, 392468, 5, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(112, 62, 763419, 43, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(112, 35, 442587, 12, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(113, 32, 917357, 16, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(113, 49, 749158, 44, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(113, 37, 891393, 35, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(113, 38, 768859, 5, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(113, 86, 819125, 2, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(113, 7, 517671, 46, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(113, 70, 931364, 12, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(114, 61, 260072, 7, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(114, 5, 504947, 44, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(114, 68, 554587, 37, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(114, 28, 187234, 39, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(114, 19, 545121, 37, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(114, 25, 303038, 36, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 61, 306949, 44, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 45, 63427, 31, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 65, 268539, 33, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 55, 853047, 22, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 39, 486242, 2, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 18, 284285, 19, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 56, 923530, 39, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 9, 120285, 18, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 59, 148837, 2, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 95, 949664, 7, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 97, 885578, 29, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 94, 456979, 32, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(115, 93, 239222, 49, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 56, 256251, 2, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 37, 42870, 24, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 28, 918471, 29, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 27, 726431, 9, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 74, 938723, 24, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 87, 887518, 9, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 11, 368593, 6, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 73, 900617, 37, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 21, 256765, 41, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 61, 978458, 45, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 83, 829188, 19, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 22, 91210, 18, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 100, 510641, 7, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 23, 897064, 14, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 99, 170121, 15, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 38, 774210, 2, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(116, 47, 445411, 16, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(117, 2, 98685, 46, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(117, 93, 641430, 48, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(117, 64, 711655, 45, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 3, 51894, 22, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 26, 231608, 40, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 77, 585098, 27, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 85, 528644, 5, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 94, 825550, 31, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 30, 742937, 12, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 58, 190436, 45, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 90, 133193, 48, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 32, 912484, 27, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 61, 684543, 14, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 73, 197018, 48, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 28, 277099, 47, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 99, 136336, 43, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 42, 738302, 28, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 37, 778098, 42, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 21, 886812, 29, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(118, 17, 982596, 5, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 54, 851445, 29, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 75, 373022, 49, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 4, 141462, 39, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 14, 409570, 47, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 24, 684101, 16, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 64, 504243, 37, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 21, 117425, 38, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 26, 63970, 29, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 89, 238489, 20, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 59, 121003, 3, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(119, 20, 931582, 49, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 80, 813999, 27, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 20, 509286, 44, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 95, 345845, 48, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 97, 847703, 13, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 7, 164245, 11, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 88, 907386, 29, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 3, 569239, 40, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 96, 614753, 14, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 30, 263047, 6, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 10, 680096, 13, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(120, 6, 441727, 15, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(121, 10, 927101, 30, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(121, 50, 849025, 42, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(121, 13, 983185, 40, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(121, 11, 321973, 9, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(121, 41, 144154, 8, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(122, 77, 539228, 46, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(122, 86, 426387, 37, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(122, 25, 886364, 44, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(122, 56, 147183, 17, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(122, 9, 475513, 22, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 8, 235438, 40, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 67, 727771, 15, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 30, 526595, 3, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 34, 782603, 36, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 7, 912798, 25, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 20, 127772, 41, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 99, 446189, 15, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 50, 189425, 45, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 4, 921671, 6, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 59, 956213, 17, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 16, 63272, 11, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 47, 925667, 15, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 28, 625310, 46, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 60, 812979, 18, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 97, 389469, 10, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(123, 15, 898041, 44, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 15, 293591, 19, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 54, 329805, 23, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 76, 499416, 39, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 8, 280369, 2, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 29, 577163, 5, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 70, 172521, 14, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 16, 591012, 23, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 89, 567591, 43, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 82, 727015, 16, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 91, 916317, 46, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 33, 443620, 41, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 4, 799069, 22, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 17, 423258, 25, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 61, 951657, 7, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(124, 77, 426832, 15, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 16, 490202, 1, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 63, 193152, 49, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 2, 707301, 34, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 70, 963257, 37, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 18, 75675, 42, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 97, 904501, 49, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 92, 435410, 42, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 74, 170534, 11, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 87, 402710, 39, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(125, 84, 60734, 28, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 60, 802308, 1, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 59, 649138, 26, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 36, 486438, 16, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 81, 790214, 39, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 64, 439733, 8, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 62, 967740, 43, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 14, 592477, 38, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 37, 214662, 18, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 35, 221219, 30, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 82, 523643, 40, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 44, 235939, 43, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 88, 338863, 4, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 93, 106849, 21, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 16, 18019, 3, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 96, 889243, 29, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 52, 593299, 26, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 38, 958342, 37, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 21, 704509, 2, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(126, 83, 844607, 46, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 64, 142376, 10, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 15, 949765, 4, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 21, 208197, 42, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 89, 255985, 4, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 41, 905628, 20, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 48, 891676, 46, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 57, 374171, 43, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 78, 441975, 30, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 58, 961780, 32, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 39, 665438, 12, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 54, 658874, 32, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 45, 867227, 40, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 46, 495527, 30, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 44, 777912, 20, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 16, 363137, 40, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 35, 749126, 45, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 43, 993452, 10, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 81, 805910, 9, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(127, 22, 168273, 8, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 66, 633084, 20, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 53, 481184, 38, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 72, 694769, 43, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 71, 71185, 19, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 18, 379959, 13, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 96, 961493, 18, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 60, 391898, 25, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 36, 187336, 37, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 78, 542781, 47, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 99, 245915, 49, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 74, 119754, 14, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 76, 363961, 4, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(128, 25, 478956, 46, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(129, 79, 262892, 45, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(129, 21, 442070, 27, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(129, 30, 755994, 21, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(129, 88, 679574, 36, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 63, 168195, 22, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 36, 375433, 2, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 28, 617074, 17, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 94, 733562, 5, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 96, 43295, 2, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 34, 126152, 15, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 84, 202839, 42, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 37, 354585, 17, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 27, 573600, 37, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 25, 389793, 1, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 22, 601844, 2, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 23, 627505, 9, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 74, 706482, 8, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(130, 32, 680055, 14, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 90, 686696, 18, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 9, 298618, 20, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 35, 145902, 35, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 71, 266479, 43, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 36, 798488, 40, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 22, 324654, 44, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 82, 204832, 20, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 6, 51718, 2, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 100, 419789, 39, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(131, 15, 433261, 2, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 7, 696737, 44, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 23, 755435, 43, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 46, 334555, 10, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 94, 304131, 28, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 64, 435628, 33, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 56, 761294, 35, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 24, 303296, 12, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 66, 712762, 10, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 62, 337324, 41, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 48, 930509, 11, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 1, 262322, 14, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(132, 76, 742692, 9, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(133, 38, 336311, 39, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(133, 39, 659491, 32, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(133, 96, 660074, 1, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(133, 94, 602940, 1, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(133, 91, 232065, 16, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(133, 37, 537027, 44, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(133, 92, 695034, 10, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(133, 72, 153122, 36, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 78, 448223, 15, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 43, 856520, 39, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 36, 827667, 26, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 88, 346190, 24, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 97, 708584, 25, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 62, 243507, 31, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 1, 455196, 20, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 13, 652452, 11, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 6, 637716, 13, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 52, 118912, 49, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 84, 720587, 18, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 46, 599020, 39, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 24, 958213, 47, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(134, 33, 716906, 28, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(135, 74, 935206, 33, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(135, 59, 78012, 49, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(135, 69, 251513, 47, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(135, 53, 991220, 2, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(135, 35, 999314, 35, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(135, 77, 476119, 35, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 33, 131807, 45, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 21, 770005, 19, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 24, 203936, 44, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 55, 342740, 14, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 90, 879479, 14, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 1, 170962, 21, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 93, 126995, 36, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 23, 671605, 22, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 60, 952827, 3, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 64, 144703, 2, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(136, 28, 854746, 27, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(137, 95, 122444, 33, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(137, 69, 636111, 38, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(137, 78, 572663, 43, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(137, 74, 884940, 3, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(137, 40, 179266, 33, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(137, 37, 591450, 34, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 58, 564442, 45, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 28, 951411, 39, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 44, 590000, 5, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 84, 752967, 40, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 68, 622989, 22, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 9, 77112, 17, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 63, 156310, 27, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 13, 433236, 12, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 57, 80001, 49, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 35, 906839, 39, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 11, 900950, 31, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 76, 205921, 26, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 4, 893968, 8, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 92, 910916, 32, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 61, 198413, 27, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(138, 1, 670061, 2, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 75, 12809, 3, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 38, 918425, 20, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 85, 94892, 35, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 81, 562418, 21, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 73, 439873, 49, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 54, 954085, 48, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 8, 782603, 30, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 78, 324644, 19, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 99, 613653, 26, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 96, 451424, 4, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 86, 590531, 35, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 60, 384252, 46, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 5, 257981, 46, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 58, 76456, 23, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 77, 826485, 29, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(139, 2, 420813, 31, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 60, 702721, 11, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 51, 136363, 15, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 82, 147136, 12, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 41, 721755, 34, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 13, 66916, 11, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 90, 870366, 38, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 79, 879651, 38, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 2, 211769, 22, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(140, 95, 516405, 39, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 11, 10403, 46, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 100, 627245, 34, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 39, 749481, 38, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 35, 286023, 44, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 54, 751013, 11, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 56, 195618, 24, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 10, 729805, 27, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 5, 30981, 10, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 73, 77949, 40, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 99, 721509, 22, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 42, 260182, 16, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 57, 899679, 36, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 80, 180593, 4, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 1, 601866, 23, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 36, 879199, 10, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 58, 609416, 45, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 93, 282527, 17, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 38, 216843, 22, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(141, 53, 253380, 36, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 56, 263536, 38, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 77, 698591, 31, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 88, 873979, 15, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 53, 961195, 40, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 61, 979095, 27, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 37, 918784, 45, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 63, 207671, 22, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 79, 629524, 27, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(142, 90, 336614, 32, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(143, 39, 424045, 46, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(143, 55, 298243, 8, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(143, 36, 38064, 33, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(143, 4, 314789, 40, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(143, 35, 55555, 21, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(143, 61, 121917, 2, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(144, 75, 911605, 1, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(144, 95, 891108, 31, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(144, 51, 768667, 13, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 16, 393676, 6, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 85, 773518, 46, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 73, 22126, 21, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 11, 857797, 20, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 75, 994834, 22, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 79, 371771, 44, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 58, 426131, 6, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 3, 756277, 27, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 46, 576174, 3, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 48, 732687, 34, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 26, 999383, 12, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 18, 340709, 34, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(145, 64, 187138, 39, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 80, 762854, 23, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 67, 566185, 17, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 57, 627333, 16, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 91, 739442, 10, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 40, 921048, 32, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 18, 459756, 48, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 62, 720328, 20, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 93, 680119, 23, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 4, 450083, 37, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 100, 84687, 13, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 61, 222223, 21, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 38, 23171, 18, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 34, 636923, 22, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 3, 166804, 3, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(146, 51, 701054, 7, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(147, 45, 430120, 4, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(147, 39, 121143, 8, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(147, 72, 251455, 10, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(147, 21, 93919, 28, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(147, 80, 637755, 6, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 6, 182229, 3, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 22, 481583, 28, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 58, 521309, 16, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 53, 69851, 13, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 64, 568827, 10, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 17, 708602, 31, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 11, 119923, 10, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 12, 853025, 8, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 4, 353666, 33, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 34, 388086, 15, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 91, 873549, 44, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 14, 377203, 6, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 5, 696435, 7, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 80, 743583, 44, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 95, 261734, 6, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 61, 771250, 30, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(148, 32, 78389, 24, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(149, 11, 392742, 11, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(149, 39, 438519, 24, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(149, 84, 84420, 7, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(149, 65, 149257, 33, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(149, 37, 493586, 46, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(149, 18, 524865, 14, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(149, 93, 276102, 47, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(149, 55, 379793, 6, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 67, 208076, 35, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 74, 538285, 30, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 36, 948653, 21, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 15, 374261, 7, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 37, 941274, 10, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 55, 605033, 31, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 78, 557442, 9, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 79, 212974, 27, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(150, 17, 544063, 46, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(151, 47, 377785, 1, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(151, 4, 197838, 7, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(151, 39, 16428, 43, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(151, 33, 268236, 5, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(151, 49, 74689, 11, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(151, 23, 931289, 32, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(151, 100, 148807, 19, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(151, 9, 506475, 26, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 8, 614194, 45, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 34, 122794, 23, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 47, 736802, 25, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 85, 806801, 47, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 59, 580667, 25, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 58, 151732, 21, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 77, 275910, 2, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 22, 525069, 3, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 51, 101167, 38, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 60, 249967, 11, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 61, 91068, 25, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 11, 384671, 29, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 52, 773072, 36, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 73, 721850, 31, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 84, 788511, 43, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 15, 894274, 48, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 89, 121408, 19, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 6, 953306, 42, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 96, 257985, 25, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(152, 91, 916315, 6, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(153, 14, 968522, 19, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(153, 54, 61284, 6, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(153, 16, 882593, 41, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(153, 65, 498552, 12, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(154, 1, 944040, 38, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(154, 35, 280891, 12, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(154, 30, 352177, 32, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(154, 39, 819971, 31, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(154, 81, 21003, 36, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(154, 37, 165001, 39, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 13, 684686, 25, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 69, 38494, 39, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 24, 336345, 5, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 10, 436456, 26, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 8, 297938, 5, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 21, 301792, 14, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 96, 97027, 6, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 60, 180475, 8, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 79, 50493, 19, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 48, 802491, 40, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 61, 209962, 30, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 98, 147207, 38, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 28, 344454, 11, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 26, 348053, 25, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(155, 36, 572084, 47, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(156, 62, 369177, 14, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(156, 86, 489948, 9, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(156, 42, 157955, 33, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(156, 30, 937533, 46, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(157, 14, 45753, 6, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(157, 12, 402623, 19, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(157, 97, 55469, 40, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(157, 85, 233078, 45, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(157, 21, 133377, 48, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(157, 47, 942737, 42, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(157, 11, 717742, 17, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 99, 481699, 31, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 45, 896757, 5, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 65, 136251, 49, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 13, 219510, 47, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 85, 137313, 45, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 41, 686955, 16, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 24, 314861, 34, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 84, 922430, 9, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 10, 991284, 13, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(158, 5, 551270, 18, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(159, 30, 554038, 4, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(159, 83, 38514, 43, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(159, 13, 587000, 36, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(160, 70, 353357, 21, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(160, 97, 748867, 29, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(160, 90, 584970, 41, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(161, 39, 475634, 18, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(161, 78, 107615, 9, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(161, 53, 981517, 5, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(161, 5, 466192, 3, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(161, 45, 704507, 26, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(161, 50, 301702, 36, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(161, 40, 666760, 9, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 42, 802037, 37, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 39, 717716, 21, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 66, 364954, 46, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 75, 558231, 6, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 50, 324743, 24, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 62, 159164, 40, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 83, 193387, 38, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 12, 189636, 19, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 56, 91849, 3, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 91, 365544, 24, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 24, 223907, 22, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 41, 168132, 13, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 85, 352037, 23, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 16, 493595, 21, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 70, 212234, 33, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 40, 267790, 40, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 78, 241956, 29, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 46, 662012, 20, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 17, 784393, 37, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(162, 54, 869226, 28, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(163, 81, 331933, 4, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(163, 96, 767443, 9, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(163, 23, 445578, 34, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(164, 16, 624477, 36, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(164, 92, 448971, 32, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(164, 15, 309344, 12, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(164, 12, 297379, 30, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(164, 64, 650403, 25, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(165, 90, 211635, 15, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(165, 24, 372201, 41, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(165, 2, 707105, 39, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(165, 72, 90704, 15, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(165, 85, 77628, 24, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(165, 35, 936908, 6, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(165, 11, 449474, 6, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(165, 59, 738949, 11, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 22, 106747, 23, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 18, 353193, 7, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 42, 634282, 24, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 88, 382554, 49, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 80, 481204, 30, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 47, 26243, 30, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 94, 454969, 42, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 74, 76208, 8, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 78, 975640, 7, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 51, 169665, 6, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 59, 120086, 1, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 28, 749888, 41, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 44, 43486, 45, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 61, 80397, 19, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 50, 581895, 40, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 100, 397986, 36, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 63, 703574, 39, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 26, 355573, 30, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(166, 32, 365881, 7, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(167, 27, 925495, 48, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(167, 45, 376045, 8, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(167, 57, 21677, 9, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(167, 67, 866700, 14, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(167, 36, 328393, 17, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(167, 77, 188581, 37, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(167, 80, 895980, 12, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 9, 842675, 48, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 81, 231277, 30, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 48, 697509, 48, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 15, 760194, 9, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 57, 330260, 41, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 55, 263249, 9, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 88, 995988, 14, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 26, 27803, 20, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 39, 777422, 17, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 53, 517418, 14, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 19, 823671, 27, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 24, 419756, 13, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 10, 66426, 44, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 1, 408374, 20, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 42, 954538, 12, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 96, 427612, 32, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 85, 338009, 10, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(168, 17, 998362, 9, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 61, 390858, 24, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 14, 81024, 45, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 100, 179905, 24, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 79, 850685, 7, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 72, 865170, 17, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 16, 816173, 24, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 4, 690006, 29, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 22, 402614, 39, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 15, 520947, 45, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 95, 744054, 48, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 86, 214659, 31, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 99, 953089, 16, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 70, 737941, 22, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 87, 776609, 21, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 10, 604517, 9, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 41, 467510, 49, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(169, 92, 576418, 2, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(170, 6, 223046, 35, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 22, 169496, 27, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 54, 802058, 40, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 3, 113791, 23, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 45, 595087, 3, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 89, 681694, 38, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 10, 700333, 45, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 18, 777459, 38, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 27, 189514, 26, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 67, 709856, 16, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 19, 701169, 45, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 39, 840458, 11, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 83, 854483, 3, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 84, 464763, 42, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 65, 566304, 35, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(171, 46, 138102, 38, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 8, 333861, 18, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 82, 488793, 9, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 19, 874226, 48, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 67, 401980, 38, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 21, 677408, 15, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 11, 590802, 36, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 29, 773956, 18, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 70, 242026, 3, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 36, 394672, 3, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 32, 599873, 21, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 50, 72184, 29, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 68, 727732, 42, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 18, 476396, 39, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 63, 792399, 14, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 51, 45151, 47, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(172, 78, 193030, 39, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 78, 804465, 45, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 20, 397502, 41, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 54, 939318, 36, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 23, 726992, 27, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 45, 552884, 36, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 98, 459627, 32, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 40, 825675, 21, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 9, 430737, 5, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 65, 794064, 40, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 82, 651756, 45, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 47, 315120, 22, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 1, 750508, 25, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 60, 760175, 46, 0.3)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 62, 966610, 29, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(173, 66, 639023, 30, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 26, 784258, 33, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 12, 743932, 22, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 28, 496183, 32, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 85, 145851, 38, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 81, 27739, 37, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 47, 802630, 16, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 8, 450957, 42, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 3, 399030, 14, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(174, 14, 897284, 32, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 2, 223386, 26, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 80, 792534, 39, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 1, 465279, 41, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 61, 964161, 1, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 66, 430070, 38, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 77, 311620, 35, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 28, 192694, 8, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 84, 479986, 5, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 65, 326188, 27, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 46, 54858, 23, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 24, 35454, 42, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 91, 226655, 40, 0.31)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 79, 723931, 3, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 100, 671812, 5, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 44, 720269, 30, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 11, 652022, 19, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 63, 209349, 10, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(175, 58, 193670, 19, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 55, 499383, 5, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 37, 387971, 38, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 81, 573152, 13, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 44, 974644, 49, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 67, 18232, 16, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 83, 785382, 35, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 46, 389367, 10, 0.38)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 34, 322193, 8, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 20, 946200, 12, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 25, 256762, 38, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 49, 395891, 10, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 40, 99322, 17, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 76, 907485, 38, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(176, 89, 934344, 17, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(177, 84, 917130, 33, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(177, 100, 162587, 25, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(177, 14, 767565, 11, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(177, 70, 308964, 17, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(177, 92, 113969, 15, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(178, 21, 981148, 37, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(178, 5, 957461, 7, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(178, 36, 652106, 13, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(178, 20, 854142, 7, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(178, 30, 829032, 27, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(178, 42, 479848, 45, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(178, 81, 195786, 42, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(178, 4, 50847, 43, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 63, 614696, 11, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 2, 403442, 29, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 14, 551653, 18, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 15, 819320, 16, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 97, 762063, 48, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 38, 889316, 7, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 91, 501084, 11, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 19, 105280, 26, 0.01)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 98, 656289, 10, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(179, 88, 799822, 47, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 2, 487928, 23, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 83, 202922, 23, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 22, 248932, 3, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 27, 146223, 16, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 49, 22321, 3, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 61, 46350, 15, 0.21)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 19, 200502, 14, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 56, 845304, 28, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(180, 15, 810788, 40, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(181, 39, 169122, 9, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(181, 5, 909574, 48, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(181, 90, 696375, 39, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(181, 21, 162807, 5, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(181, 9, 376627, 29, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(182, 44, 446343, 48, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 63, 990927, 28, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 62, 438541, 43, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 76, 909862, 22, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 72, 990704, 38, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 41, 808145, 20, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 92, 738533, 19, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 66, 752483, 4, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 13, 154375, 18, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 12, 807335, 37, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 55, 352349, 29, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(183, 49, 245348, 39, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 95, 951594, 17, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 73, 594934, 36, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 32, 547484, 9, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 94, 719636, 16, 0.27)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 4, 580576, 37, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 53, 660383, 24, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 61, 514120, 35, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 57, 812497, 47, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 36, 91538, 16, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 97, 347979, 16, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 18, 452334, 3, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(184, 86, 830776, 41, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(185, 64, 778066, 6, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(185, 94, 599232, 16, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(185, 50, 912373, 21, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 10, 751955, 41, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 62, 298301, 38, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 67, 210579, 22, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 45, 904932, 34, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 91, 822899, 38, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 83, 256525, 49, 0.39)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 34, 91573, 48, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 58, 210815, 44, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 37, 678527, 46, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 99, 692829, 13, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 13, 918911, 26, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 49, 191209, 25, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 6, 457348, 46, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 90, 516750, 2, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(186, 68, 974046, 47, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 2, 613058, 39, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 43, 584140, 48, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 70, 753003, 6, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 99, 83699, 25, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 89, 71613, 47, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 68, 683324, 26, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 90, 760864, 41, 0.23)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 23, 139071, 13, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 97, 979256, 21, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 69, 739983, 44, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 3, 760218, 13, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 92, 336802, 41, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 4, 485301, 13, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 33, 357891, 18, 0.19)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 37, 82860, 45, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 11, 615296, 42, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 5, 671015, 39, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 9, 57674, 35, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 62, 104577, 27, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(187, 53, 598877, 16, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 30, 966966, 20, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 97, 310727, 24, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 42, 58565, 25, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 6, 985892, 26, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 54, 34266, 16, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 11, 571406, 18, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 68, 18132, 13, 0.24)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 52, 656939, 31, 0.16)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(188, 10, 934542, 47, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 55, 656438, 3, 0.11)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 60, 736291, 7, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 88, 761912, 41, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 29, 124874, 22, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 7, 546538, 47, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 96, 35041, 36, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 84, 716116, 25, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 1, 354475, 39, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 6, 193654, 47, 0.29)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 48, 456961, 18, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 14, 495269, 19, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 68, 980796, 17, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 77, 748125, 32, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 72, 164282, 14, 0.18)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 85, 920623, 31, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 100, 58575, 47, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 86, 125694, 24, 0.33)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 71, 576937, 2, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 31, 169666, 17, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(189, 17, 207708, 21, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(190, 81, 518431, 26, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(190, 67, 399799, 20, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 82, 60740, 6, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 55, 713889, 16, 0.25)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 92, 115659, 27, 0.32)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 3, 73177, 31, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 89, 65005, 23, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 96, 84369, 1, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 4, 223040, 26, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 49, 293190, 11, 0.04)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 93, 774315, 29, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 46, 608061, 11, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 50, 62411, 11, 0.1)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 35, 420126, 34, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(191, 34, 596543, 37, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(192, 17, 754286, 43, 0.12)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(192, 80, 71238, 22, 0.13)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(193, 10, 293312, 24, 0.06)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(193, 83, 911803, 36, 0.34)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(193, 23, 922234, 38, 0.36)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(194, 1, 602774, 11, 0.0)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(194, 29, 744438, 49, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(194, 36, 200971, 23, 0.35)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(194, 7, 133260, 47, 0.37)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 71, 580741, 26, 0.02)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 36, 978239, 22, 0.15)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 34, 364417, 26, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 72, 530167, 28, 0.22)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 18, 891163, 10, 0.03)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 97, 562998, 33, 0.09)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 86, 150495, 1, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 100, 393521, 38, 0.26)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 12, 852063, 30, 0.28)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 74, 985379, 15, 0.2)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 93, 172675, 42, 0.14)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 11, 571617, 2, 0.07)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 70, 608969, 15, 0.17)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 41, 542854, 19, 0.05)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 38, 918069, 28, 0.08)
INSERT INTO ReceiptDetails(ReceiptID, ProductID, UnitPrice, Quantity, Discount) VALUES(195, 82, 376971, 48, 0.16)
GO