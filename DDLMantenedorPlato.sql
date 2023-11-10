/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.5 		*/
/*  Created On : 05-Nov.-2023 09:35:29 				*/
/*  DBMS       : SQL Server 2008 						*/
/* ---------------------------------------------------- */

/* Drop Foreign Key Constraints */
create database BDMantenedorPlato
go

use BDMantenedorPlato
go

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_Insumo_Tipoinsumo]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [Insumo] DROP CONSTRAINT [FK_Insumo_Tipoinsumo]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_InsumoPlato_Plato]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [InsumoPlato] DROP CONSTRAINT [FK_InsumoPlato_Plato]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_InsumoPlato_Insumo]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [InsumoPlato] DROP CONSTRAINT [FK_InsumoPlato_Insumo]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_Plato_Tipoplato]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [Plato] DROP CONSTRAINT [FK_Plato_Tipoplato]
GO

/* Drop Tables */

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[Insumo]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [Insumo]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[InsumoPlato]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [InsumoPlato]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[Plato]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [Plato]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[Tipoinsumo]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [Tipoinsumo]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[Tipoplato]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [Tipoplato]
GO

/* Create Tables */

CREATE TABLE [Insumo]
(
	[InsumoID] nvarchar(10) NOT NULL,
	[CantidadInsumo] int NOT NULL,
	[TipoinsumoID] nvarchar(10) NOT NULL,
	[EstadoInsumo] bit NOT NULL,
	[NombreInsumo] nvarchar(50) NOT NULL
)
GO

CREATE TABLE [InsumoPlato]
(
	[PlatoID] nvarchar(10) NULL,
	[InsumoID] nvarchar(10) NULL
)
GO

CREATE TABLE [Plato]
(
	[PlatoID] nvarchar(10) NOT NULL,
	[EstadoPlato] bit NULL,
	[TipoplatoID] nvarchar(10) NOT NULL,
	[NombrePlato] nvarchar(50) NULL,
	[PrecioPlato] decimal(10,2) NULL
)
GO

CREATE TABLE [Tipoinsumo]
(
	[NombreTipoInsumo] nvarchar(50) NULL,
	[TipoinsumoID] nvarchar(10) NOT NULL,
	[EstadoTipoInsumo] bit NULL
)
GO

CREATE TABLE [Tipoplato]
(
	[NombreTipoPlato] nvarchar(50) NULL,
	[TipoplatoID] nvarchar(10) NOT NULL,
	[EstadoTipoPlato] bit NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [Insumo] 
 ADD CONSTRAINT [PK_Insumo]
	PRIMARY KEY CLUSTERED ([InsumoID] ASC)
GO

ALTER TABLE [Plato] 
 ADD CONSTRAINT [PK_Plato]
	PRIMARY KEY CLUSTERED ([PlatoID] ASC)
GO

ALTER TABLE [Tipoinsumo] 
 ADD CONSTRAINT [PK_Tipoinsumo]
	PRIMARY KEY CLUSTERED ([TipoinsumoID] ASC)
GO

ALTER TABLE [Tipoplato] 
 ADD CONSTRAINT [PK_Tipoplato]
	PRIMARY KEY CLUSTERED ([TipoplatoID] ASC)
GO

/* Create Foreign Key Constraints */

ALTER TABLE [Insumo] ADD CONSTRAINT [FK_Insumo_Tipoinsumo]
	FOREIGN KEY ([TipoinsumoID]) REFERENCES [Tipoinsumo] ([TipoinsumoID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [InsumoPlato] ADD CONSTRAINT [FK_InsumoPlato_Plato]
	FOREIGN KEY ([PlatoID]) REFERENCES [Plato] ([PlatoID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [InsumoPlato] ADD CONSTRAINT [FK_InsumoPlato_Insumo]
	FOREIGN KEY ([InsumoID]) REFERENCES [Insumo] ([InsumoID]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Plato] ADD CONSTRAINT [FK_Plato_Tipoplato]
	FOREIGN KEY ([TipoplatoID]) REFERENCES [Tipoplato] ([TipoplatoID]) ON DELETE No Action ON UPDATE No Action
GO

-- PROCEDIMIENTOS ALMACENADOS
-- para TIPOPLATO

create or alter proc spInsertarTipoPlato
(@tipoplatoid nvarchar(10), @nombretipoplato nvarchar(50), @estadotipoplato bit)
as
insert into Tipoplato values
(@nombretipoplato, @tipoplatoid, @estadotipoplato)
go

create or alter proc spListarTipoPlato
as
select * from Tipoplato
where EstadoTipoPlato = 1
go

create or alter proc spEditarTipoPlato
(@tipoplatoid nvarchar(10), @nombretipoplato nvarchar(50), @estadotipoplato bit)
as
update
Tipoplato 
set
NombreTipoPlato = @nombretipoplato,
EstadoTipoPlato = @estadotipoplato
where 
@tipoplatoid = TipoplatoID
go

create or alter proc spDeshabilitarTipoPlato
(@tipoplatoid nvarchar(10))
as
update
Tipoplato
set
EstadoTipoPlato = 0
where
@tipoplatoid = TipoplatoID
go

select * from Tipoplato

-- para TIPOINSUMO

create or alter proc spInsertarTipoInsumo
(@tipoinsumoid nvarchar(10), @nombretipoinsumo nvarchar(50), @estadotipoinsumo bit)
as
insert into Tipoinsumo values
(@nombretipoinsumo, @tipoinsumoid, @estadotipoinsumo)
go

create or alter proc spListarTipoInsumo
as
select * from TipoInsumo
where EstadoTipoInsumo = 1
go

create or alter proc spEditarTipoInsumo
(@tipoinsumoid nvarchar(10), @nombretipoinsumo nvarchar(50), @estadotipoinsumo bit)
as
update
Tipoinsumo 
set
NombreTipoinsumo = @nombretipoinsumo,
EstadoTipoinsumo = @estadotipoinsumo
where 
@tipoinsumoid = tipoinsumoid
go

create or alter proc spDeshabilitarTipoinsumo
(@tipoinsumoid nvarchar(10))
as
update
Tipoinsumo
set
EstadoTipoinsumo = 0
where
@tipoinsumoid = TipoinsumoID
go

select * from Tipoinsumo

-- para INSUMO

create or alter proc spInsertarInsumo
(@insumoid nvarchar(10), @nombreinsumo nvarchar(50), @idtipoinsumo nvarchar(10), @cantidadinsumo int, @estadoinsumo bit)
as
insert into insumo values
(@insumoid, @cantidadinsumo, @idtipoinsumo, @estadoinsumo, @nombreinsumo)
go

create or alter proc spListarInsumo
as
select * from insumo
where EstadoInsumo = 1
go

create or alter proc spEditarInsumo
(@insumoid nvarchar(10), @nombreinsumo nvarchar(50), @idtipoinsumo nvarchar(10), @cantidadinsumo int, @estadoinsumo bit)
as
update
Insumo
set
NombreInsumo = @nombreinsumo,
TipoinsumoID = @idtipoinsumo,
CantidadInsumo = @cantidadinsumo,
Estadoinsumo = @estadoinsumo
where 
@insumoid = insumoid
go

create or alter proc spDeshabilitarinsumo
(@insumoid nvarchar(10))
as
update
insumo
set
Estadoinsumo = 0
where
@insumoid = insumoid
go

select * from insumo