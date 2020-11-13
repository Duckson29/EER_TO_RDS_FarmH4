/*Database And Tables*/
CREATE DATABASE [FarmsH4];
GO
USE [FarmsH4];
GO
CREATE TABLE [Owner]
(
  [CVR] INT NOT NULL,
  [First] VARCHAR(32) NOT NULL,
  [Last] VARCHAR(32) NOT NULL,
  [Streetname] VARCHAR(64) NOT NULL,
  [No] INT NOT NULL,
  [Postcode] INT NOT NULL,
  [City] VARCHAR(32) NOT NULL,
  [Email] VARCHAR(64) NOT NULL,
  PRIMARY KEY ([CVR])
);
GO
CREATE TABLE [Farm]
(
  [Pnumber] INT NOT NULL,
  [Name] VARCHAR(32) NOT NULL,
  [Streetname] VARCHAR(64) NOT NULL,
  [No] INT NOT NULL,
  [Postcode] INT NOT NULL,
  [City] VARCHAR(32) NOT NULL,
  [CVR] INT NOT NULL,
  PRIMARY KEY ([Pnumber]),
  FOREIGN KEY ([CVR]) REFERENCES [Owner]([CVR])
);
GO
CREATE TABLE [Stall]
(
  [No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  PRIMARY KEY ([No], [Pnumber]),
  CONSTRAINT FK_Stall_Farm FOREIGN KEY ([Pnumber]) REFERENCES [Farm]([Pnumber])
);
GO
CREATE TABLE [Box]
(
  [Type] VARCHAR(32) NOT NULL,
  [Outdoor] BIT NOT NULL,
  [No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  PRIMARY KEY ([No], [Stall_No], [Pnumber]),
  CONSTRAINT FK_Box_Stall FOREIGN KEY ([Stall_No], [Pnumber]) REFERENCES [Stall]([No], [Pnumber])
);
GO
CREATE TABLE [SmartUnit]
(
  [Type] VARCHAR(32) NOT NULL,
  [Serialnumber] INT NOT NULL,
  [IpAddress] VARCHAR(32) NOT NULL,
  [MacAddress] VARCHAR(32) NOT NULL,
  PRIMARY KEY ([Serialnumber])
);
GO
CREATE TABLE [State]
(
  [Severity] INT NOT NULL,
  [Id] INT NOT NULL,
  PRIMARY KEY ([Id])
);
GO
CREATE TABLE [Box_monitor]
(
  [Value] INT NOT NULL,
  [Time] DATETIME NOT NULL,
  [No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  [Serialnumber] INT NOT NULL,
  PRIMARY KEY ([No], [Stall_No], [Pnumber], [Serialnumber]),
  CONSTRAINT FK_Stall_Box FOREIGN KEY ([No], [Stall_No], [Pnumber]) REFERENCES [Box]([No], [Stall_No], [Pnumber]),
  CONSTRAINT FK_BoxMonitor_Smartunit FOREIGN KEY ([Serialnumber]) REFERENCES [SmartUnit]([Serialnumber])
);
GO
CREATE TABLE [Stall_monitor]
(
  [No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  [Serialnumber] INT NOT NULL,
  PRIMARY KEY ([No], [Pnumber], [Serialnumber]),
  CONSTRAINT FK_StallMonitor_Stall FOREIGN KEY ([No], [Pnumber]) REFERENCES [Stall]([No], [Pnumber]),
  CONSTRAINT FK_SmartUnit_StallMonitr FOREIGN KEY ([Serialnumber]) REFERENCES [SmartUnit]([Serialnumber])
);
GO
CREATE TABLE [Changes]
(
  [Time] DATETIME NOT NULL,
  [Serialnumber] INT NOT NULL,
  [Id] INT NOT NULL,
  PRIMARY KEY ([Serialnumber], [Id]),
  CONSTRAINT FK_changes_SmartUnitChanges FOREIGN KEY ([Serialnumber]) REFERENCES [SmartUnit]([Serialnumber]),
  CONSTRAINT FK_Changes_StateID FOREIGN KEY ([Id]) REFERENCES [State]([Id])
);
GO
CREATE TABLE [Owner_Phone]
(
  [Phone] VARCHAR(16) NOT NULL,
  [CVR] INT NOT NULL,
  PRIMARY KEY ([Phone], [CVR]),
  CONSTRAINT FK_Phone_Owner FOREIGN KEY ([CVR]) REFERENCES [Owner]([CVR])
);
GO
CREATE TABLE [Farm_ChrNo]
(
  [ChrNo] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  PRIMARY KEY ([ChrNo], [Pnumber]),
  CONSTRAINT FK_FarmChrNo_Farm FOREIGN KEY ([Pnumber]) REFERENCES [Farm]([Pnumber])
);
GO
CREATE TABLE [Animal]
(
  [ChrNo] INT NOT NULL,
  [Color] VARCHAR(16) NOT NULL,
  [Id] INT NOT NULL,
  [Sex] BIT NOT NULL,
  [Type] VARCHAR(16) NOT NULL,
  [Birth] DATE NOT NULL,
  [Death] DATE NULL,
  [Age] SQL_VARIANT DEFAULT (DATEDIFF(year, 'Birth', getdate())),
  [produce_ChrNo] INT,
  [produce_Color] VARCHAR(16),
  [produce_Id] INT,
  PRIMARY KEY ([ChrNo], [Color], [Id]),
  CONSTRAINT FK_Animal_Animal FOREIGN KEY ([produce_ChrNo], [produce_Color], [produce_Id]) REFERENCES [Animal]([ChrNo], [Color], [Id])
);
GO
CREATE TABLE [Lives_In]
(
  [MoveInTime] DATETIME NOT NULL,
  [MoveOutTime] DATETIME NULL,
  [No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  [ChrNo] INT NOT NULL,
  [Color] VARCHAR(16) NOT NULL,
  [Id] INT NOT NULL,
  PRIMARY KEY ([No], [Stall_No], [Pnumber], [ChrNo], [Color], [Id]),
  CONSTRAINT FK_Lives_In_Box FOREIGN KEY ([No], [Stall_No], [Pnumber]) REFERENCES [Box]([No], [Stall_No], [Pnumber]),
  CONSTRAINT FK_Lives_In_Animal FOREIGN KEY ([ChrNo], [Color], [Id]) REFERENCES [Animal]([ChrNo], [Color], [Id])
);
GO

/****Dummy Data*******/

/*Owner*/
Insert into Owner (CVR,City,Email,First,Last,No,Postcode,Streetname)
values(1111111,'Næstved','someMail@mail.com','Dummy1','DummyNickname1',6514,4700,'A streetname 45 1.tv');
insert into Owner_Phone (CVR,Phone) values (1111111,12345678);

/*Farm*/
insert into Farm (City,CVR,Name,No,Pnumber,Postcode,Streetname) 
values('Næstved',1111111,'FarmInc',6514,987,4700,'Farmvej 1a');
insert into Farm_ChrNo (ChrNo,Pnumber) values (1,987);

/*Stalls*/
insert into Stall (No,Pnumber) values(1,987);
insert into Stall_monitor (No,Pnumber,Serialnumber) values(1,987,789);

/*SmartUnit*/
insert into SmartUnit (IpAddress,MacAddress,Serialnumber,Type) values ('172.1.5.4','00-50-56-C0-00-08',789,5);

/*Changes And State*/
insert into Changes (Id,Serialnumber,Time) values (1,789,(-500 - GETDATE()));
insert into State (Id,Severity) values(1,5);

/*Box*/
insert into Box (No,Outdoor,Pnumber,Stall_No,Type) values(1,1,987,1,1);
insert into Box_monitor (No,Pnumber,Serialnumber,Stall_No,Time,Value) values(1,987,789,1,GETDATE(),8);

/*Animal*/
insert into Animal (Birth,ChrNo,Color,Id,Sex,Type) values ((SELECT CAST(getdate() AS date)),654,'Black',1,0,'PigLet');
	/*Lives In*/
	insert into Lives_In (ChrNo,Color,Id,MoveInTime,No,Pnumber,Stall_No) values(654,'Black',1,GETDATE(),1,987,1);

  
  

