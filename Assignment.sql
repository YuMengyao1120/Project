USE master
IF EXISTS(select * from sys.databases where name='MokeFoods')
DROP DATABASE MokeFoods
Go

Create Database MokeFoods
Go

Use MokeFoods
Go

/*** Delete tables (if they exist) before creating ***/

/* Table: Customer */
if exists (select * from sysobjects 
  where id = object_id('Customer') and sysstat & 0xf = 3)
  drop table Customer
GO

/* Table: Business */
if exists (select * from sysobjects 
  where id = object_id('Business') and sysstat & 0xf = 3)
  drop table Business
GO

/* Table: Zone */
if exists (select * from sysobjects 
  where id = object_id('Zone') and sysstat & 0xf = 3)
  drop table Zone
GO

/* Table: Outlet */
if exists (select * from sysobjects 
  where id = object_id('Outlet') and sysstat & 0xf = 3)
  drop table Outlet
GO

/* Table: OutletContact */
if exists (select * from sysobjects 
  where id = object_id('OutletContact') and sysstat & 0xf = 3)
  drop table OutletContact
GO

/* Table: Cuisine */
if exists (select * from sysobjects 
  where id = object_id('Cuisine') and sysstat & 0xf = 3)
  drop table Cuisine
GO

/* Table: OutletCuisine */
if exists (select * from sysobjects 
  where id = object_id('OutletCuisine') and sysstat & 0xf = 3)
  drop table OutletCuisine
GO

/* Table: Menu */
if exists (select * from sysobjects 
  where id = object_id('Menu') and sysstat & 0xf = 3)
  drop table Menu
GO

/* Table: Item */
if exists (select * from sysobjects 
  where id = object_id('Item') and sysstat & 0xf = 3)
  drop table Item
GO

/* Table: MenuItem */
if exists (select * from sysobjects 
  where id = object_id('MenuItem') and sysstat & 0xf = 3)
  drop table MenuItem
GO

/* Table: Voucher */
if exists (select * from sysobjects 
  where id = object_id('Voucher') and sysstat & 0xf = 3)
  drop table Voucher
GO

/* Table: CustOrder */
if exists (select * from sysobjects 
  where id = object_id('CustOrder') and sysstat & 0xf = 3)
  drop table CustOrder
GO

/* Table: OrderItem */
if exists (select * from sysobjects 
  where id = object_id('OrderItem') and sysstat & 0xf = 3)
  drop table OrderItem
GO

/* Table: Payment */
if exists (select * from sysobjects 
  where id = object_id('Payment') and sysstat & 0xf = 3)
  drop table Payment
GO

/* Table: Promotion */
if exists (select * from sysobjects 
  where id = object_id('Promotion') and sysstat & 0xf = 3)
  drop table Promotion
GO

/* Table: OrderPromo */
if exists (select * from sysobjects 
  where id = object_id('OrderPromo') and sysstat & 0xf = 3)
  drop table OrderPromo
GO

/* Table: OutletPromotion */
if exists (select * from sysobjects 
  where id = object_id('OutletPromo') and sysstat & 0xf = 3)
  drop table OutletPromo
GO

/* Table: Pickup */
if exists (select * from sysobjects 
  where id = object_id('Pickup') and sysstat & 0xf = 3)
  drop table Pickup
GO

/* Table: Delivery */
if exists (select * from sysobjects 
  where id = object_id('Delivery') and sysstat & 0xf = 3)
  drop table Delivery
GO

/* Table: Rider */
if exists (select * from sysobjects 
  where id = object_id('Rider') and sysstat & 0xf = 3)
  drop table Rider
GO

/* Table: DeliveryDetails */
if exists (select * from sysobjects 
  where id = object_id('DeliveryDetails') and sysstat & 0xf = 3)
  drop table DeliveryDetails
GO

/* Table: Award */
if exists (select * from sysobjects 
  where id = object_id('Award') and sysstat & 0xf = 3)
  drop table Award
GO

/* Table: RiderAward */
if exists (select * from sysobjects 
  where id = object_id('RiderAward') and sysstat & 0xf = 3)
  drop table RiderAward
GO

/* Table: Team */
if exists (select * from sysobjects 
  where id = object_id('Team') and sysstat & 0xf = 3)
  drop table Team
GO

/* Drop foreign key constraint in dbo.Team to dbo.Rider */
if exists (select * from sysobjects 
  where id = object_id('Team') and sysstat & 0xf = 3)
  ALTER TABLE Team
  DROP CONSTRAINT FK_Team_LeaderID
GO

/* Table: Equipment */
if exists (select * from sysobjects 
  where id = object_id('Equipment') and sysstat & 0xf = 3)
  drop table Equipment
GO

/* Table: RiderEquipment */
if exists (select * from sysobjects 
  where id = object_id('RiderEquipment') and sysstat & 0xf = 3)
  drop table RiderEquipment
GO

 /*** Create tables ***/
/* Table:  Customer   */
CREATE TABLE Customer
(
  CustID             int                 NOT NULL,
  CustName           varchar(50)         NOT NULL,
  CustAddress        varchar(150)        NULL,
  CustContact        char(8)             NOT NULL UNIQUE,
  CustEmail          varchar(50)         NOT NULL UNIQUE,
  CONSTRAINT PK_Customer PRIMARY KEY (CustID),
)

 /*** Create tables ***/
/* Table:  Business   */
CREATE TABLE Business
(
  BizID             smallint                 NOT NULL,
  BizName           varchar(50)              NOT NULL UNIQUE,
  CONSTRAINT PK_Business PRIMARY KEY (BizID),
)

/*** Create tables ***/
/* Table:  Zone   */
CREATE TABLE Zone
(
  ZoneID                 smallint                NOT NULL,
  ZoneName               varchar(11)             NOT NULL CHECK (ZoneName IN ('N', 'E', 'S', 'W', 'C', 'NE', 'SE', 'SW', 'NW', 'CE', 'CN', 'CS', 'CW')),
  CONSTRAINT PK_Zone PRIMARY KEY (ZoneID),
)

 /*** Create tables ***/
/* Table:  Outlet   */
CREATE TABLE Outlet
(
OutletID			smallint		NOT NULL,
OutletName			varchar(50)		NOT NULL,
Address				varchar(150)	NOT NULL,
DeliveryFee			smallmoney		NOT NULL CHECK (DeliveryFee >= 3),
OpenTime			time	        NOT NULL DEFAULT (GETDATE()),
CloseTime			time	        NOT NULL DEFAULT (GETDATE()),
StartDeliveryTime	time	        NOT NULL DEFAULT (GETDATE()),
EndDeliveryTime		time	        NOT NULL DEFAULT (GETDATE()),
BizID				smallint		NOT NULL,
ZoneID				smallint		NOT NULL,
CONSTRAINT PK_Outlet PRIMARY KEY (OutletID),
CONSTRAINT FK_Outlet_BizID FOREIGN KEY (BizID) REFERENCES Business(BizID),
CONSTRAINT FK_Outlet_ZoneID FOREIGN KEY (ZoneID) REFERENCES Zone(ZoneID)
)

/*** Create tables ***/
/* Table:  OutletContact   */
CREATE TABLE OutletContact
(
  OutletID                 smallint                   NOT NULL,
  ContactNo                char(8)                    NOT NULL UNIQUE,
  CONSTRAINT PK_OutletPromo PRIMARY KEY (OutletID, ContactNo),
  CONSTRAINT FK_OutletPromo_OutletID FOREIGN KEY (OutletID) REFERENCES Outlet(OutletID),
 )

  /*** Create tables ***/
/* Table:  Cuisine   */
CREATE TABLE Cuisine
(
  CuisineID             smallint                  NOT NULL,
  CuisineName           varchar(50)              NOT NULL,
  CONSTRAINT PK_Cuisine PRIMARY KEY (CuisineID),
)

/*** Create tables ***/
/* Table:  OutletCuisine   */
CREATE TABLE OutletCuisine
(
  OutletID               smallint                   NOT NULL,
  CuisineID              smallint                   NOT NULL,
  CONSTRAINT PK_OutletCuisine PRIMARY KEY (OutletID, CuisineID),
  CONSTRAINT FK_OutletCuisine_OutletID FOREIGN KEY (OutletID) REFERENCES Outlet(OutletID),
  CONSTRAINT FK_OutletCuisine_CuisineID FOREIGN KEY (CuisineID) REFERENCES Cuisine(CuisineID)
)

/*** Create tables ***/
/* Table:  Menu  */
CREATE TABLE Menu
(
OutletID		smallint			NOT NULL,
MenuNo			tinyint			NOT NULL,
MenuName		varchar(30)		NOT NULL,
CONSTRAINT	PK_Menu PRIMARY KEY
NONCLUSTERED (OutletID, MenuNo),
CONSTRAINT FK_Menu_OutletID FOREIGN KEY (OutletID) REFERENCES Outlet(OutletID)
)

/*** Create tables ***/
/* Table:  Item   */
CREATE TABLE Item
(
ItemID			tinyint			NOT NULL,
ItemName		varchar(30)		NOT NULL,
ItemDesc		varchar(150)	NULL,
ItemPrice		smallmoney		NOT NULL,
CONSTRAINT PK_Item PRIMARY KEY (ItemID)
)

/*** Create tables ***/
/* Table:  MenuItem   */
CREATE TABLE MenuItem
(
OutletID		smallint			NOT NULL,
MenuNo			tinyint			NOT NULL,
ItemID			tinyint			NOT NULL,
CONSTRAINT PK_MenuItem PRIMARY KEY
NONCLUSTERED(OutletID, MenuNo, ItemID),
CONSTRAINT FK_MenuItem FOREIGN KEY (OutletID, MenuNo) REFERENCES
Menu(OutletID, MenuNo),
CONSTRAINT FK_MenuItem_ItemID FOREIGN KEY (ItemID) REFERENCES
Item(ItemID)
)

/*** Create tables ***/
/* Table:  Voucher   */
Create Table Voucher
(
VoucherID		smallint		NOT NULL,
VoucherStatus	varchar(11)		NOT NULL CHECK (VoucherStatus IN ('Unredeemed', 'Redeemed', 'Expired')),
VoucherDesc		varchar(100)	NOT NULL,
StartDate		smalldatetime	NOT NULL DEFAULT (GETDATE()),
ExpiryDate		smalldatetime	NOT NULL,	
MinOrder		smallmoney		NOT NULL CHECK (MinOrder >= 5.00),
DollarValue		smallmoney		NULL,
CustID			int				NOT NULL,
CONSTRAINT PK_Voucher PRIMARY KEY (VoucherID),
CONSTRAINT ExpiryDate CHECK (ExpiryDate > StartDate),
CONSTRAINT FK_Voucher FOREIGN KEY (CustID) REFERENCES Customer(CustID)
)

/*** Create tables ***/
/* Table:  CustOrder   */
CREATE TABLE CustOrder
(
  OrderID             smallint                  NOT NULL,
  OrderStatus         varchar(20)               NOT NULL CHECK(OrderStatus IN ('Pending Confirmation', 'Accepted', 'Preparing', 'Dispatched', 'Cancelled', 'Completed')),
  OrderDateTime       smalldatetime             NOT NULL DEFAULT (GETDATE()),
  CustID              int						NOT NULL,
  VoucherID           smallint                  NULL,
  OutletID            smallint                  NOT NULL,
  CONSTRAINT PK_CustOrder PRIMARY KEY (OrderID),
  CONSTRAINT FK_CustOrder_CustID FOREIGN KEY (CustID) REFERENCES
  Customer(CustID),
  CONSTRAINT FK_CustOrder_VoucherID FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID),
  CONSTRAINT FK_CustOrder_OutletID FOREIGN KEY (OutletID) REFERENCES Outlet(OutletID),
)

/*** Create tables ***/
/* Table:  OrderItem   */
CREATE TABLE OrderItem
(
OrderID			smallint		 NOT NULL,
OrderQty			tinyint			 NOT NULL,
ItemID			tinyint			 NOT NULL,
UnitPrice		smallmoney		 NOT NULL,
CONSTRAINT PK_OrderItem PRIMARY KEY 
NONCLUSTERED(OrderID, ItemID),
CONSTRAINT FK_OrderItem_OrderID FOREIGN KEY(OrderID) REFERENCES
CustOrder(OrderID),
CONSTRAINT  FK_OrderItem_ItemID FOREIGN KEY(ItemID) REFERENCES
Item(ItemID)
)

/*** Create tables ***/
/* Table:  Payment   */
CREATE TABLE Payment
(
PmtID		smallint		NOT NULL,
PmtMode		varchar(20)		NOT NULL,
PmtType		varchar(20)		NOT NULL CHECK(PmtType IN ('Order Payment', 'Refund')),
PmtAmt		smallmoney		NOT NULL,
OrderID		smallint		NOT NULL,
CONSTRAINT 	PK_Payment PRIMARY KEY(PmtID),
CONSTRAINT FK_Payment_OrderID FOREIGN KEY(OrderID) REFERENCES CustOrder(OrderID)
)

/*** Create tables ***/
/* Table:  Promotion   */
Create Table Promotion
(
PromoID			smallint		NOT NULL,
PromoName		varchar(50)		NOT NULL,
PromoDesc		varchar(100)	NULL,
PercentDiscount tinyint			NOT NULL CHECK (PercentDiscount >= 10),
IsFreeDelivery	varchar(4)		NOT NULL CHECK (IsFreeDelivery IN ('Yes', 'No')),
CONSTRAINT PK_Promotion PRIMARY KEY(PromoID)
)

/*** Create tables ***/
/* Table:  OrderPromo  */
CREATE TABLE OrderPromo
(
OrderID smallint NOT NULL,
PromoID smallint NOT NULL,
CONSTRAINT PK_OrderPromo PRIMARY KEY
NONCLUSTERED(OrderID, PromoID),
CONSTRAINT FK_OrderPromo_OrderID FOREIGN KEY (OrderID) REFERENCES CustOrder(OrderID),
CONSTRAINT FK_OrderPromo_PromoID FOREIGN KEY (PromoID) REFERENCES Promotion(PromoID)
)

 /*** Create tables ***/
/* Table:  OutletPromo   */
CREATE TABLE OutletPromo
(
  OutletID               smallint                   NOT NULL,
  PromoID                smallint                   NOT NULL,
  MaxCount               smallint                   NOT NULL,
  CONSTRAINT PK_OutletPromo_OutletID PRIMARY KEY (OutletID, PromoID),
  CONSTRAINT FK_OutletPromo_OutID FOREIGN KEY (OutletID) REFERENCES
  Outlet(OutletID),
  CONSTRAINT FK_OutletPromo_PromoID FOREIGN KEY (PromoID) REFERENCES Promotion(PromoID)
)

/*** Create tables ***/
/* Table:  Pickup  */
Create Table Pickup
(
OrderID			smallint		NOT NULL,
PickupRefNo		smallint		NOT NULL,
PickupDateTime	smalldatetime	NULL ,
CONSTRAINT PK_Pickup PRIMARY KEY(OrderID),
CONSTRAINT FK_Pickup FOREIGN KEY(OrderID) REFERENCES CustOrder(OrderID)
)

/*** Create tables ***/
/* Table:  Rider   */
Create Table Rider
(
RiderID			smallint		NOT NULL,
RiderName		varchar(50)		NOT NULL,
RiderContact	char(10)		NOT NULL UNIQUE,
RiderAddress	varchar(150)	NOT NULL,
RiderDOB		smalldatetime	NOT NULL,
RiderNRIC		char(9)			NOT NULL UNIQUE,
DeliveryMode	varchar(50)		NOT NULL CHECK(DeliveryMode IN ('Foot', 'Bicycle', 'Motorcycle', 'Car')),
TeamID			smallint		NOT NULL,
CONSTRAINT PK_Rider PRIMARY KEY(RiderID),
)

/*** Create tables ***/
/* Table:  Delivery   */
CREATE TABLE Delivery
(
  OrderID               smallint                 NOT NULL,
  DeliveryAddress       varchar(150)             NOT NULL,
  DeliveryDateTime      smalldatetime            NULL,
  RiderID               smallint                 NOT NULL,
  CONSTRAINT PK_Delivery PRIMARY KEY (OrderID),
  CONSTRAINT FK_Delivery_OrderID FOREIGN KEY (OrderID) REFERENCES
  CustOrder(OrderID),
  CONSTRAINT FK_Delivery_RiderID FOREIGN KEY (RiderID) REFERENCES
  Rider(RiderID),
)

/*** Create tables ***/
/* Table:  DeliveryDetails   */
CREATE TABLE DeliveryDetails
(
  OrderID               smallint                 NOT NULL,
  RiderID               smallint                 NOT NULL,
  Status                char(1)                  NOT NULL CHECK(Status IN ('A','R')),
  CONSTRAINT PK_DeliveryDetails PRIMARY KEY (OrderID, RiderID),
  CONSTRAINT FK_DeliveryDetails_OrderID FOREIGN KEY (OrderID) REFERENCES
  CustOrder(OrderID),
  CONSTRAINT FK_DeliveryDetails_RiderID FOREIGN KEY (RiderID) REFERENCES Rider(RiderID),
)

/*** Create tables ***/
/* Table:  Award   */
CREATE TABLE Award
(
  AwardID             tinyint                  NOT NULL,
  AwardType           char(1)                  NOT NULL CHECK (AwardType IN ('T', 'I')),
  AwardName           varchar(50)              NOT NULL,
  CONSTRAINT PK_Award PRIMARY KEY (AwardID),
)

/*** Create tables ***/
/* Table:  RiderAward   */
Create Table RiderAward
(
RiderID			smallint		NOT NULL,
AwardID			tinyint			NOT NULL,
WinDate			smalldatetime	NOT NULL DEFAULT (GETDATE()),
CONSTRAINT PK_RiderAward PRIMARY KEY
NONCLUSTERED (RiderID, AwardID),
CONSTRAINT FK_RiderAward_RiderID FOREIGN KEY (RiderID) REFERENCES Rider(RiderID),
CONSTRAINT FK_RiderAward_AwardID FOREIGN KEY (AwardID)REFERENCES Award(AwardID),
)

/*** Create tables ***/
/* Table:  Team   */
Create Table Team
(
TeamID			smallint	    NOT NULL,
TeamName		varchar(20)		NULL,
LeaderID		smallint		NOT NULL,
AwardID			tinyint			NULL,
CONSTRAINT PK_Team PRIMARY KEY (TeamID),
CONSTRAINT FK_Team_LeaderID FOREIGN KEY (LeaderID) REFERENCES Rider(RiderID),
CONSTRAINT FK_Team_AwardID FOREIGN KEY (AwardID) REFERENCES Award(AwardID)
)

/* Add foreign key constraint to dbo.Rider */
ALTER TABLE Rider
ADD CONSTRAINT FK_Rider_TeamID FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
GO

 /*** Create tables ***/
/* Table:  Equipment   */
CREATE TABLE Equipment
(
  EquipID               tinyint                   NOT NULL,
  EquipName             varchar(50)               NOT NULL,
  EquipPrice            smallmoney                NOT NULL,
  SetEquipID            tinyint                   NOT NULL,
  CONSTRAINT PK_Equipment PRIMARY KEY (EquipID),
  CONSTRAINT FK_Equipment_SetEquipID FOREIGN KEY (SetEquipID) REFERENCES
  Equipment(EquipID)
)

/*** Create tables ***/
/* Table:  RiderEquipment   */
Create Table RiderEquipment
(
PurchaseDateTime smalldatetime	NOT NULL DEFAULT (GETDATE()),
RiderID			 smallint		NOT NULL,
EquipID			 tinyint		NOT NULL,
PurchaseQty		 tinyint		NOT NULL,
CONSTRAINT PK_RiderEquipment PRIMARY KEY
NONCLUSTERED (PurchaseDateTime, RiderID, EquipID),
CONSTRAINT FK_RiderEquipment FOREIGN KEY (RiderID) REFERENCES Rider(RiderID),
CONSTRAINT FK_RiderEquipmet FOREIGN KEY (EquipID) REFERENCES Equipment(EquipID)
)

--Inserting Customer Table Values
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (1, 'Doris Koh', 'Blk 456 Bedok Street 79, #15-03', '99484310', 'koh23@yahoo.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (2, 'Gabe Toy', NULL , '97063874', 'gabe.toy@gmail.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (3, 'Michel Fu', '7 Dover Circle, #12-15', '87976835', 'michael.fu@gmail.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (4, 'Diana Cheah', 'Blk 14 Lorong 6 Bukit Merah, #16-21', '94033783', 'cdiana12@yahoo.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (5, 'Aaron Lim', 'Blk 288 Toa Payoh Street 76, #13-39', '95537126','limlim@gmail.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (6, 'Dora Lieu', NULL, '98161775', 'dora.lieu@gmail.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (7, 'Siti Rahmat', 'Blk 27 Yishun Street 22, #02-27', '95552120', 'sitirahmat@yahoo.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (8, 'Marc Chye', 'Blk 39 Marine Parade Street 15, #11-35', '88179700', 'marcc56@gmail.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (9, 'Cathy Liew', '27 Bugis Avenue North, #13-26', '85556165', 'cathy.liew@gmail.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES (10, 'Geoffrey Chai', 'Blk 29 Serangoon Gardens Street 34, #05-12', '90891747', 'geochai1@gmail.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES(11, 'Seo Shin Youn', 'Jurong East Avenue 1 Street 35', '88668015', 'hello26@yahoo.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES(12, 'Francis Poh', 'West Coast Avenue 35 Street 10', '97291638', 'francis.poh@gmail.com')
INSERT INTO Customer (custID, custName, custAddress, custContact, custEmail)
VALUES(13, 'Elijah Lim', 'Macpherson Road Block 41, #01-05', '91278899', 'limlimelijah2@gmail.com')

-- Inserting Business Table Values
INSERT INTO Business (bizID, bizName)
VALUES (1, 'McDonald''s')
INSERT INTO Business (bizID, bizName)
VALUES (2, 'KFC')
INSERT INTO Business (bizID, bizName)
VALUES (3, 'Ya Kun Kaya Toast')
INSERT INTO Business (bizID, bizName)
VALUES (4, 'Guzman Y Gomez')
INSERT INTO Business (bizID, bizName)
VALUES (5, 'Ichiban Boshi')
INSERT INTO Business (bizID, bizName)
VALUES (6, 'Seoul Yummy')
INSERT INTO Business (bizID, bizName)
VALUES (7, 'Nakhon Kitchen')
INSERT INTO Business (bizID, bizName)
VALUES (8, 'Project Acai')
INSERT INTO Business (bizID, bizName)
VALUES (9, 'Encik Tan')
INSERT INTO Business (bizID, bizName)
VALUES (10, 'So Pho')

-- Inserting Zone Table Values
INSERT INTO Zone(ZoneID, ZoneName)
VALUES (1, 'N')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(2, 'S')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(3, 'E')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(4, 'W')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(5, 'C')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(6, 'SE')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(7, 'SW')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(8, 'NE')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(9, 'NW')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(10, 'CE')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(11, 'CW')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(12, 'CN')
INSERT INTO Zone(ZoneID, ZoneName)
VALUES(13, 'CS')

-- Inserting Outlet Table Values
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(1, 'McDonald''s', 'Paya Lebar Road Street 31', 3.50, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 1, 1)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(2, 'McDonald''s', 'Aljunied Road Street 17', 4.00, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 1, 2)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(3, 'McDonald''s', 'Clementi Road Street 8', 3.50, '09:30:00', '22:30:00', '10:30:00', '21:30:00', 1, 3)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(4, 'KFC', 'Yuan Ching Road Street 11', 4.50, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 2, 4)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(5, 'KFC', 'Lorong Chuan Road Street 51', 4.00, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 2, 5)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(6, 'Ya Kun Kaya Toast', 'Beauty World Street 50', 3.00, '09:30:00', '22:30:00', '10:30:00', '21:30:00', 3, 6)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(7, 'Ya Kun Kaya Toast', 'Orchard Road Street 12', 5.00, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 3, 7)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(8, 'McDonald''s', 'MacPherson Road Street 40', 4.00, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 1, 8)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(9, 'Guzman Y Gomez', 'Sengkang Road Street 39', 4.50, '09:30:00', '22:30:00', '10:30:00', '21:30:00', 4, 9)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(10, 'Ichiban Boshi', 'Tampines Road Street 23', 4.50, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 5, 10)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(11, 'Ichiban Boshi', 'Orchard Road Street 13', 4.50, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 5, 11)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(12, 'Seoul Yummy', 'Ivory Heights Road Street 41', 3.20, '09:30:00', '22:30:00', '10:30:00', '21:30:00', 6, 12)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(13, 'Nakhon Kitchen', 'Alexander Road Street 61', 4.00, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 7, 13)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(14, 'Nakhon Kitchen', 'Bukit Batok Road Street 15', 3.50, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 7, 1)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(15, 'Project Acai', 'Newton Road Street 48', 4.50, '09:30:00', '22:30:00', '10:30:00', '21:30:00', 8, 2)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(16, 'Encik Tan', 'Jurong East Street 30', 3.00, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 9, 3)
INSERT INTO Outlet(OutletID, OutletName, Address, DeliveryFee, OpenTime, CloseTime, StartDeliveryTime, EndDeliveryTime, BizID, ZoneID)
VALUES(17, 'So Pho', 'One north Road Street 11', 3.50, '09:00:00', '22:00:00', '10:00:00', '21:00:00', 10, 4)

-- Inserting OutletContact Table Values
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(1, '69271927')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(2, '62816013')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(3, '60572094')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(4, '62681183')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(5, '61186918')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(6, '60271471')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(7, '63629273')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(8, '60027162')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(9, '61182102')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(10, '68161917')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(11, '61829101')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(12, '69219181')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(13, '67782718')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(14, '61821992')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(15, '63712812')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(16, '66649182')
INSERT INTO OutletContact(OutletID, ContactNo)
VALUES(17, '62231727')


--Inserting Cuisine Table Values
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (1, 'Halal')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (2, 'Western')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (3, 'Local')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (4, 'Mexican')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (5, 'Japanese')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (6, 'Korean')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (7, 'Thai')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (8, 'Vegetarian')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (9, 'Chinese')
INSERT INTO Cuisine (cuisineID, cuisineName)
VALUES (10, 'Vietnamese')

-- Inserting OutletCuisine Table Values
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(1, 2)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(2, 2)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(3, 2)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(4, 2)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(5, 2)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(6, 3)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(7, 3)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(8, 2)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(9, 4)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(10, 5)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(11, 5)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(12, 6)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(13, 7)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(14, 7)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(15, 8)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(16, 3)
INSERT INTO OutletCuisine (OutletID, CuisineID)
VALUES(17, 10)

-- Inserting Menu Table Values
INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(1, 1, 'Breakfast Delight Menu')
INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(1, 2, 'Lunch Savings Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(2, 1, 'Breakfast Delight Menu')
INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(2, 2, 'Lunch Savings Menu')
INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(2, 3, 'Premium Burgers Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(3, 1, 'Lunch Savings Menu')
INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(3, 2, 'Premium Burgers Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(4, 1, 'Breakfast Riser Menu')
INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(4, 2, 'Rice bucket Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(5, 1, 'Zinger Box Menu')
INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(5, 2, 'Chicken Bucket Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(6, 1, 'Coffee and Tea Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(7, 1, 'Noodles Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(8, 1, 'McCafe Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(9, 1, 'Burrito Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(10, 1, 'Sushi Menu')
INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(10, 2, 'Ramen Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(11, 1, 'Bento Box Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(12, 1, 'BBQ Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(13, 1, 'Soup Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(14, 1, 'Mookata Steamboat Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(15, 1, 'Veggie-bowl Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(16, 1, 'Rice Combo Menu')

INSERT INTO Menu(OutletID, MenuNo, MenuName)
VALUES(17, 1, 'Boat Noodles Menu')

-- Inserting Item Table Values
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (1,'Chicken Rice','Hainanese style of chicken rice',3.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (2,'Laksa', 'A spicy noodle soup popular in Peranakan cuisine', 4.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (3,'Chicken Curry','A Curry consisting of chicken stewed in an onion-and-tomato-based soup combined with a multitude of spices',3.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (4,'Pasta Bolognese','An Italian dish using a tomato-based sauce',10.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (5,'Margherita Pizza','A Neapolitan pizza made with mozzarella, basil, olive oil, and salt',15.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (6,'Mozzarella and Fish Kebab','Skewer-cooked fresh mozzarella and fish served in warm pitta pockets',7.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (7,'Smashed Cheeseburger','A burger cooked with chuck steak smashed unto the grill for a crispier texture',12.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (8,'Tonkotsu Ramen','Rich Japanese noodle dish slow-cooked in pork and chicken broth',14.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (9,'Oyakodon','A Japanese dish consisting of simmered chicken, egg, and sliced scallion',8.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (10,'Chicken Katsu Curry Rice','Japanese style rice and curry dish with a chicken cutlet on it',7.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (11,'Monster Burger','Three meat patties topped with spicy grounded peppercorns',6.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (12,'McGriddle Burger','Chicken Patty with egg topped with muffin buns',3.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (13,'Spicy Pho Noodle', 'A spicy noodle soup popular in Vietnamese Culture', 4.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (14,'Beef curry stew','A Curry consisting of Beef stewed in an onion-and-tomato-based soup combined with a multitude of spices',3.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (15,'Basic Pizza','An Italian Pizza using a tomato-based sauce',6.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (16,'Butter Chicken Noodle Soup','Long-brewed chicken soup topped with thin noodles',10.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (17,'Chicken Kebab','Skewer-cooked fresh mozzarella and Chicken served in warm pitta pockets',7.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (18,'Smashed Cheeseburger','A burger cooked with chuck steak smashed unto the grill for a crispier texture',12.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (19,'Shoyu Ramen','Rich Japanese noodle dish slow-cooked in chicken broth with soya sauce',14.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (20,'Spicy Oyakodon','A Japanese dish consisting of simmered chicken, egg, sliced scallion and spices',8.50)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (21,'Pork Katsu Curry Rice','Japanese style rice and curry dish with a pork cutlet on it',7.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (22,'Spicy Beef Burger','Beef patties topped with spicy grounded peppercorns',6.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (23,'Basic Coffee','Black Coffee',2.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (24,'Latte','Americano Latte',3.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (25,'Maguro Sushi','Tuna with rice rolled in Seaweed',1.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (26,'Sashimi','Salmon with rice rolled in Seaweed',1.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (27,'Beef Slices','Tender beef slices topped with onions',3.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (28,'Spicy Chicken Galbi','Spicy Chicken Galbi drenched with signature sauce',3.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (29,'Thailand Pork','Mookata Pork slices topped with onions',3.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (30,'Pho Boat Noodles','Authentic Pho Noodles with pork brewed soup',4.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (31,'Acai Superbowl','Acai bowl for 2 pax ',10.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (32,'Acai Megasuperbowl','Acai bowl for 4pax',17.00)
INSERT INTO Item (ItemID, ItemName, ItemDESC,ItemPrice)
VALUES (33,'Chicken Cutlet Rice with Egg','Crispy chicken cutlet with fragrant rice and egg',1.00)

-- Inserting MenuItem Table Values
--McDonalds'
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(1, 1, 22)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(1, 1, 17)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(1, 2, 18)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(2, 1, 22)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(2, 1, 17)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(2, 2, 18)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(2, 3, 11)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(3, 1, 17)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(3, 2, 11)
--KFC
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(4, 1, 4)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(4, 1, 15)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(4, 2, 5)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(5, 1, 4)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(5, 1, 15)
--Ya Kun Kaya Toast
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(6, 1, 2)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(7, 1, 13)
--McDonalds'
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(8, 1, 23)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(8, 1, 24)
--Gomez
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(9, 1, 17 )
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(9, 1, 6)
--Ichiban Boshi
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(10, 1, 25)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(10, 1, 26)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(10, 2, 8)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(10, 2, 19)
--Ichiban Boshi
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(11, 1, 9)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(11, 1, 21)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(11, 1, 10)
--Seoul Yummy
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(12, 1, 27)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(12, 1, 28)
--Nakhon Kitchen
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(13, 1, 13)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(14, 1, 29)
--Project Acai
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(15, 1, 31)
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(15, 1, 32)
--Encik Tan
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(16, 1, 33)
--So Pho
INSERT INTO MenuItem(OutletID, MenuNo, ItemID)
VALUES(17, 1, 30)

-- Inserting Voucher Table Values
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(1, 'Unredeemed', '$8.00 off with $12.00 spent', '2020-05-28', '2021-07-28', 12.00, 8.00, 1)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(2, 'Expired', '$1.00 off with $5.00 spent', '2019-01-15', '2019-06-12', 5.00, 1.00, 2)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(3, 'Expired', '$2.00 off with $7.00 spent', '2018-02-17', '2018-09-25', 7.00, 2.00, 3)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(4, 'Redeemed', '$10.00 off with $25.60 Spent', '2019-05-28', '2019-06-02', 25.60, 10.00, 4)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(5, 'Redeemed', '$5.00 off with $6.80 spent', '2020-07-30', '2021-01-04', 6.80, 5.00, 5)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(6, 'Redeemed', '$3.00 off with $8.00 spent',  '2016-05-28', '2016-12-28', 8.00, 3.00, 6)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(7, 'Unredeemed', '$50.00 off with $149.99 spent', '2018-07-28','2021-05-12', 149.99, 50.00, 7)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(8, 'Unredeemed', '$2.00 off with $6.00 spent', '2020-05-28', '2021-03-01', 6.00, 2.00, 8)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(9, 'Expired', '$5.00 off with $9.50 spent', '2013-07-28','2015-05-12', 9.50, 5.00, 9)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(10, 'Unredeemed', '$1.50 off with $6.00 spent', '2020-01-10', '2021-05-10', 6.00, 1.50, 10)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(11, 'Unredeemed', '$3.00 off with $8.00 spent',  '2016-05-28', '2021-12-28', 8.00, 3.00, 9)
INSERT INTO Voucher (VoucherID, VoucherStatus, VoucherDesc, StartDate, ExpiryDate, MinOrder, DollarValue, CustID)
VALUES(12, 'Unredeemed', '$50.00 off $149.99 spent', '2018-07-28','2021-05-12', 149.99, 50.00, 8)
--DELETE FROM Voucher;

-- Inserting CustOrder Table Values
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (1, 'Pending Confirmation', '2019-12-12 13:00:00', 1, 1, 10)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (2, 'Accepted', '2020-01-15 12:00:00', 2, NULL, 9)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (3, 'Preparing', '2020-03-14 10:00:00', 3, NULL, 8)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (4, 'Dispatched', '2019-10-22 18:00:00', 4, NULL, 7)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (5, 'Cancelled', '2020-04-05 13:31:00', 5, NULL, 6)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (6, 'Completed', '2019-12-19 19:45:00', 6, NULL, 5)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (7, 'Accepted', '2020-09-13 14:15:00', 7, 7, 4)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (8, 'Preparing', '2019-10-21 20:30:00', 8, 8, 3)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (9, 'Dispatched', '2020-06-10 12:17:00', 9, NULL, 2)
INSERT INTO CustOrder (orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (10, 'Completed', '2019-11-01 16:00:00', 10, 10, 1)
INSERT INTO CustOrder(orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (11, 'Preparing', '2019-11-01 17:00:00', 11, NULL, 11)
INSERT INTO CustOrder(orderID, orderStatus, orderDateTime, custID, voucherID, outletID)
VALUES (12, 'Preparing', '2019-11-01 19:00:00', 12, NULL, 12)

--Inserting value into OrderItem table
INSERT INTO OrderItem(OrderID, ItemID, OrderQty, UnitPrice)
VALUES (1, 8, 2, 14.00)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (2, 17, 1, 7.50)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (3, 24, 3, 3.00)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (4, 13, 1, 4.50)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (5, 2, 1, 4.50)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (6, 4, 1, 10.50)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (7, 5, 10, 15.00)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (8, 11, 1, 6.00)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (9, 22, 2, 6.00)
INSERT INTO OrderItem(OrderID,ItemID,OrderQty,UnitPrice)
VALUES (10, 18, 12, 12.50)
INSERT INTO OrderItem(OrderID, ItemID, OrderQty, UnitPrice)
VALUES (11 , 10, 2, 7.00)
INSERT INTO OrderItem(OrderID, ItemID, OrderQty, UnitPrice)
VALUES (12 , 28, 3, 3.00)

-- Inserting Payment Table Values
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(1, 'DBS PayLah!', 'Order Payment', 17.50,1)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(2, 'OCBC Credit Card', 'Order Payment', 8.25,2)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(3, 'NETS', 'Order Payment', 11.20,3)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(4, 'NETS', 'Order Payment', 5.25,4)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(5, 'Maybank Credit Card', 'Refund', 0.00,5)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(6, 'OCBC Credit Card', 'Order Payment', 9.83 ,6)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(7, 'DBS Credit Card', 'Order Payment', 79,7)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(8, 'DBS PayLah!', 'Order Payment', 5.50, 8)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(9, 'DBS PayLah!', 'Order Payment', 10,9)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(10, 'NETS', 'Order Payment', 12 ,10)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(11, 'Maybank Credit Card', 'Order Payment', 13.60, 11)
INSERT INTO Payment (PmtID, PmtMode, PmtType, PmtAmt, OrderID)
VALUES(12, 'OCBC Credit Card', 'Order Payment', 12.20, 12)

-- Inserting Promotion Table Values
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(1, '11:11', '11:11 Singles Day Offer', 35, 'Yes')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(2, 'Christmas Promotion', '25% of storewide food items', 25, 'Yes')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(3, 'Valentines Day', 'Half Price all storewide food items', 50, 'No')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(4, 'National Day', 'Singapore Birthday Promotion on all storewide food items', 50, 'No')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(5, 'Grand Opening', 'New Store Opening Sales', 20, 'No')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(6, 'CNY Promotion', 'Chinese New Year Sales on all food items', 35, 'No')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(7, '50% off Food', NULL, 50, 'Yes')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(8, 'Hari Raya Promo', 'Half Price on all food items for sale', 50, 'Yes')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(9, 'McDonald''s Anniversary', '50% off Smash Burgers', 30, 'No')
INSERT INTO Promotion (PromoID, PromoName, PromoDesc, PercentDiscount, IsFreeDelivery)
VALUES(10, 'McDonald''s Coffee Promo', '20% off all Coffee Latte', 20, 'No')

-- Inserting OrderPromo Table Values
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(1, 1) --Ramen
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(2, 8) -- Chicken Kebab
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(3, 10) -- Latte
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(4, 4) --Spicy Pho noodles Ya Kun Kaya Toast
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(5, 5) --laksa
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(6, 6) -- Bolognese KFC
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(7, 7) --Marg Pizza KFC
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(8, 9) -- Monster Burger
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(9, 9) -- Spicy Beef Burger
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(10, 9) -- Smashed Cheeseburger
INSERT INTO OrderPromo(OrderID, PromoID)
VALUES(11, 1) -- Chicken Katsu

-- Inserting OutletPromo Table Values
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(1, 9, 100)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(2, 9, 20)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(3, 9, 30)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(4, 6, 100)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(5, 7, 20)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(6, 4, 55)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(7, 5, 24)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(8, 10, 33)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(9, 8, 44)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(10, 1, 10)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(11, 2, 10)
INSERT INTO OutletPromo(OutletID, PromoID, MaxCount)
VALUES(12, 3, 10)

-- Inserting Pickup Table Values
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(1, 1021, '2019-12-12 14:00:00')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(2, 1321, '2020-01-15 14:00')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(3, 141, '2020-03-14 12:00')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(4, 131, '2019-10-22 19:00')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(5, 1351, '2020-04-05 14:31')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(6, 121, '2019-12-19 20:45')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(7, 99, '2020-09-13 15:15')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(8, 124, '2019-10-21 21:30')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(9, 214, '2020-06-10 13:17')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(10, 84, '2019-11-01 17:00')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(11, 23, '2019-11-01 19:00')
INSERT INTO Pickup(OrderID, PickupRefNo, PickupDateTime)
VALUES(12, 2332, '2019-11-01 21:00')

DELETE FROM Rider;
ALTER TABLE Rider
DROP CONSTRAINT FK_Rider_TeamID
GO
-- Inserting Rider Table Values
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(1, 'James Chua', '88218261', 'Bukit Merah Blk 35 #02-21', '1998-03-27', 'T0361926A', 'Bicycle', 1)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(2, 'Khoo Cheng Ann', '93674381', 'Alexander Rd Blk 312 #09-17', '1990-05-23', 'T0321926B', 'Car', 1)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(3, 'Seow Eng Hua', '89162816', 'Jurong East Blk 35 #20-20', '1993-06-21', 'T0341926C', 'Motorcycle', 2)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(4, 'Teo Kah Choo', '88456291', 'Bukit Gombak Blk 105 #05-06', '1989-02-23', 'T0261926D', 'Motorcycle', 2)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(5, 'Mariah Lhow', '90187289', 'Clementi Rd Blk 41 #05-14', '1999-07-14', 'T0461926E', 'Foot', 3)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(6, 'Charlotte Lim', '90128192', 'Somerset Rd Blk 87 #13-03', '1980-12-30', 'T0361926F', 'Bicycle', 3)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(7, 'Maximus Sim', '88116622', 'Orchard Rd Blk 4 #03-14', '1970-11-24', 'T0421926G', 'Car', 4)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(8, 'Ryan Ang', '90172518', 'Khatib Rd Blk 334 #19-04', '1995-10-01', 'T0591926L', 'Motorcycle', 4)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(9, 'Mukesh Surabani', '81003910', 'Sim Lim Rd Blk 32 #14-01', '1997-09-03', 'T0982269Z', 'Bicycle', 5)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(10, 'Indra Bachtiar', '98979172', 'North Point Rd Blk 88 #08-02', '1993-08-09', 'T0277251Y', 'Foot', 5)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(11, 'Jeremy Lee', '89119353', 'Toa Payoh Street 17 Blk 460 #01-33', '1997-04-30', 'S3954989E', 'Bicycle', 1)
INSERT INTO Rider (RiderID, RiderName, RiderContact, RiderAddress, RiderDOB, RiderNRIC, DeliveryMode, TeamID)
VALUES(12, 'Lucas Wong', '84775491', 'Farrell Link Place Blk 17 #09-17', '1999-01-25', 'T0242327Z', 'Car', 1)


-- Inserting Delivery Table Values
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(1,'Bukit Merah Blk 35 #02-21', '2019-01-15 8:00:00', 1)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(2,'Jalan Rice Lane Blk 306F #05-06', '2019-02-17 13:00:00', 2)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(3,'Bukit Merah Blk 27 #07-21', '2019-01-29 17:00:00', 3)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(4,'Bedok Reservoir View Blk 773 #17-123', '2019-01-17 15:00:00', 4)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(5,'Lorong 2 Toa Payoh Blk 145 #09-04', '2020-04-02 07:00:00', 5)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(6,'Simei Street 2 Blk 147 #18-12', '2020-04-14 18:00:00', 6)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(7,'Tampines Avenue 5 Blk 859B #01-11', '2019-02-07 20:00:00', 7)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(8,'Bishan Street 11 Blk 150 #06-06', '2020-08-09 22:00:00', 8)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(9,'Monahan Alley Quay Blk 196A #10-04', '2020-09-26 16:00:00', 9)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(10,'Dach Crescent Alley Blk 272E #15-03', '2019-12-28 12:00:00', 10)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(11,'Queen Elizabeth Road Blk 196A #10-04', '2019-11-01 19:00:00', 11)
 INSERT INTO Delivery (OrderID, DeliveryAddress, DeliveryDateTime, RiderID)
 VALUES(12,'Clementi Town Road Blk 12B #08-06', '2019-11-01 21:00:00', 12)

DELETE FROM DeliveryDetails;
-- Inserting DeliveryDetails Table Values
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(1, 1, 'R')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(2, 2, 'A')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(3, 3, 'A')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(4, 4, 'A')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(5, 5, 'R')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(6, 6, 'A')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(7, 7, 'A')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(8, 8, 'A')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(9, 9, 'A')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(10, 10, 'A')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(11, 11, 'R')
INSERT INTO DeliveryDetails(OrderID, RiderID, Status)
VALUES(12, 12, 'R')

DELETE FROM Award;
--Inserting Award Table Values
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (1, 'T', 'Highest Number of Orders Fulfilled')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (2, 'I', 'Highest Number of Orders Fulfilled')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (3, 'T', 'Highest Acceptance Rate')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (4, 'I', 'Highest Acceptance Rate')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (5, 'T', 'Fastest Average Time Taken for Delivery')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (6, 'I', 'Fastest Time Taken for Delivery')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (7, 'T', 'More than Average the Number of Order fulfilled')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (8, 'T', 'More than the Average Acceptance Rate')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (9, 'I', 'More than Average the Number of Order fulfilled')
INSERT INTO Award (AwardID, AwardType, AwardName)
VALUES (10, 'I', 'More than the Average Acceptance Rate')

DELETE FROM RiderAward;
-- Inserting RiderAward Table Values
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(1, 2, '2019-11-01' )
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(2, 4, '2019-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(3, 6, '2019-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(4, 9, '2019-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(5, 10, '2019-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(6, 2,'2020-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(7, 4, '2020-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(8, 6, '2020-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(9, 9, '2019-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(10, 10, '2019-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(11, 2, '2020-11-01')
INSERT INTO RiderAward (RiderID, AwardID, WinDate)
VALUES(12, 4, '2020-11-01')

DELETE FROM Team;
-- Inserting Team Table Values
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(1, 'WestSide', 1, 1)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(2, 'A', 2, 3)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(3, 'C', 3, NULL)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(4, 'AlexanderRd', 4, 5)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(5, 'D', 10, 8)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(6, 'Hello', 5, NULL)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(7, 'Qqq', 6, 9)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(8, 'P01', 7, 10)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(9, NULL, 8, 4)
INSERT INTO Team (TeamID, TeamName, LeaderID, AwardID)
VALUES(10, 'T09', 9, NULL)

DELETE FROM Equipment;
-- Inserting Equipment Table Values
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(1,'Long Sleeve T', 15.00, 1)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(2,'Short Sleeve T', 15.00, 1)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(3,'Normal Bag', 20.00, 1)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(4,'Halal Bag', 20.00, 2)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(5,'BackPack', 30.00, 2)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(6,'Rain Coat', 30.00, 2)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(7,'Helmet', 40.00, 3)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(8,'Black Shorts', 15.00, 3)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(9,'Black Trousers', 15.00, 3)
INSERT INTO Equipment (EquipID, EquipName, EquipPrice, SetEquipID)
VALUES(10,'Coat', 30.00, 3)

DELETE FROM RiderEquipment;
-- Inserting RiderEquipment Table Values
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-07-09 22:00:00', 1, 1, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-09-09 22:00:00', 1, 2, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2016-04-09 22:00:00', 1, 3, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2018-04-09 22:00:00', 2, 4, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2015-10-09 22:00:00', 2, 5, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2016-07-09 22:00:00', 2, 6, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2018-04-09 22:00:00', 3, 7, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 3, 8, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 3, 9, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 3, 10, 1)

INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2016-04-09 22:00:00', 4, 1, 3)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-04-09 22:00:00', 4, 2, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2015-02-09 22:00:00', 4, 3, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2018-04-09 22:00:00', 5, 4, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2015-10-09 22:00:00', 5, 5, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2016-07-09 22:00:00', 5, 6, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2018-04-09 22:00:00', 6, 7, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 6, 8, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 6, 9, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 6, 10, 1)

INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-07-09 22:00:00', 7, 1, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-09-09 22:00:00', 7, 2, 3)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2016-04-09 22:00:00', 7, 3, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2018-04-09 22:00:00', 8, 4, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2015-10-09 22:00:00', 8, 5, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2016-07-09 22:00:00', 8, 6, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2018-04-09 22:00:00', 9, 7, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 9, 8, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 9, 9, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 9, 10, 2)

INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-07-09 22:00:00', 10, 1, 3)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-09-09 22:00:00', 10, 2, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2016-04-09 22:00:00', 10, 3, 1)

INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2018-04-09 22:00:00', 11, 4, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2015-10-09 22:00:00', 11, 5, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2016-07-09 22:00:00', 11, 6, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2018-04-09 22:00:00', 11, 7, 3)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 12, 8, 1)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 12, 9, 2)
INSERT INTO RiderEquipment (PurchaseDateTime, RiderID, EquipID, PurchaseQty)
VALUES('2017-08-09 22:00:00', 12, 10, 1)

ALTER TABLE Rider
ADD CONSTRAINT FK_Rider_TeamID FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
GO
