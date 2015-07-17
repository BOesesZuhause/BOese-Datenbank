SET search_path TO 'public';

DROP TABLE IF EXISTS "Device" CASCADE; 
DROP TABLE IF EXISTS "Connector" CASCADE; 
DROP TABLE IF EXISTS "Zone" CASCADE; 
DROP TABLE IF EXISTS "Service" CASCADE; 
DROP TABLE IF EXISTS "Component" CASCADE; 
DROP TABLE IF EXISTS "Unit" CASCADE; 
DROP TABLE IF EXISTS "Group" CASCADE; 
DROP TABLE IF EXISTS "DeviceGroup" CASCADE; 
DROP TABLE IF EXISTS "LogComponent" CASCADE; 
DROP TABLE IF EXISTS "User" CASCADE; 
DROP TABLE IF EXISTS "GroupUser" CASCADE; 
DROP TABLE IF EXISTS "LogConnector" CASCADE; 
DROP TABLE IF EXISTS "DeviceComponent" CASCADE; 
DROP TABLE IF EXISTS "ServiceDevice" CASCADE; 
DROP TABLE IF EXISTS "Rule" CASCADE; 
DROP TABLE IF EXISTS "LogRule" CASCADE; 
DROP TABLE IF EXISTS "HistoryLogComponente" CASCADE; 
DROP TABLE IF EXISTS "HistoryLogConnector" CASCADE; 
DROP TABLE IF EXISTS "HistoryLogRule" CASCADE; 
DROP TABLE IF EXISTS "DeviceComponenteReplace" CASCADE; 
DROP TABLE IF EXISTS "GroupZone" CASCADE; 

CREATE TABLE "Device" 
( 
	"DeID" serial NOT NULL UNIQUE,
	"Alias" varchar(125) NOT NULL UNIQUE,
	"SerialNumber" varchar(125) NOT NULL UNIQUE,
	"PurchaseDate" date,
	"CoID" serial NOT NULL,
	"ZoID" serial NOT NULL
); 

CREATE TABLE "Connector" 
( 
	"CoID" serial NOT NULL UNIQUE,
	"Name" varchar(25) NOT NULL UNIQUE,
	"Webadress" varchar(125) NOT NULL UNIQUE
); 

CREATE TABLE "Zone" 
( 
	"ZoID" serial NOT NULL UNIQUE,
	"Name" varchar(25) NOT NULL,
	"SuZoID" serial UNIQUE
); 

CREATE TABLE "Service" 
( 
	"SeID" serial NOT NULL UNIQUE,
	"Description" varchar(125) NOT NULL UNIQUE
); 

CREATE TABLE "Component" 
( 
	"CoID" serial NOT NULL UNIQUE,
	"Name" varchar(125) NOT NULL,
	"UnID" serial NOT NULL,
	"Sensor" boolean NOT NULL
); 

CREATE TABLE "Unit" 
( 
	"UnID" serial NOT NULL UNIQUE,
	"Name" varchar(25) UNIQUE,
	"Symbol" varchar(25) UNIQUE
); 

CREATE TABLE "Group" 
( 
	"GrID" smallint NOT NULL UNIQUE,
	"Name" varchar(25) NOT NULL UNIQUE
); 

CREATE TABLE "DeviceGroup" 
( 
	"DeID" serial NOT NULL,
	"GrID" smallint NOT NULL,
	"Rights" smallint NOT NULL
); 

CREATE TABLE "LogComponent" 
( 
	"LoCoID" serial NOT NULL UNIQUE,
	"Value" numeric NOT NULL,
	"Timestamp" timestamp NOT NULL,
	"DeCoID" serial NOT NULL
); 

CREATE TABLE "User" 
( 
	"UsID" integer NOT NULL UNIQUE,
	"Surname" varchar(125) NOT NULL,
	"FirstName" varchar(125) NOT NULL,
	"Password" varchar(125) NOT NULL,
	"Gender" boolean,
	"Birthdate" date,
	"UserName" varchar(125) NOT NULL UNIQUE,
	"Email" varchar(125)
); 

CREATE TABLE "GroupUser" 
( 
	"GrID" smallint NOT NULL,
	"UsID" integer NOT NULL,
	"Position" smallint
); 

CREATE TABLE "LogConnector" 
( 
	"LoCoID" serial NOT NULL UNIQUE,
	"CoID" serial NOT NULL,
	"Timestap" timestamp NOT NULL,
	"Data" xml NOT NULL
); 

CREATE TABLE "DeviceComponent" 
( 
	"DeCoID" serial NOT NULL UNIQUE,
	"SeID" serial NOT NULL,
	"GeID" serial NOT NULL,
	"Status" smallint,
	"Description" varchar,
	"LogRule" numeric,
	"CurrentValue" numeric
); 

CREATE TABLE "ServiceDevice" 
( 
	"SeID" serial NOT NULL,
	"DeID" serial NOT NULL
); 

CREATE TABLE "Rule" 
( 
	"RuID" serial NOT NULL UNIQUE,
	"Active" boolean,
	"InsertDate" date,
	"ModifyDate" date,
	"Permissions" xml,
	"Conditions" xml,
	"Actions" xml
); 

CREATE TABLE "LogRule" 
( 
	"LoRuID" serial NOT NULL UNIQUE,
	"Timestamp" timestamp NOT NULL,
	"RuID" serial NOT NULL
); 

CREATE TABLE "HistoryLogComponente" 
( 
	"HiLoCoID" serial NOT NULL UNIQUE,
	"Value" numeric NOT NULL,
	"Timestamp" timestamp NOT NULL,
	"DeCoID" serial NOT NULL
); 

CREATE TABLE "HistoryLogConnector" 
( 
	"HiLoCoID" serial NOT NULL UNIQUE,
	"Timestap" timestamp NOT NULL,
	"Data" xml NOT NULL,
	"CoID" serial NOT NULL
); 

CREATE TABLE "HistoryLogRule" 
( 
	"HiLoRuID" serial NOT NULL UNIQUE,
	"Timestamp" timestamp NOT NULL,
	"RuID" serial NOT NULL
); 

CREATE TABLE "DeviceComponenteReplace" 
( 
	"DeCoID" serial NOT NULL,
	"DeCoIDReplaced" serial NOT NULL,
	"Timestap" timestamp NOT NULL
); 

CREATE TABLE "GroupZone" 
( 
	"GrID" smallint NOT NULL,
	"ZoID" serial NOT NULL,
	"Rights" smallint
); 

ALTER TABLE "Device" ADD PRIMARY KEY ("DeID");
ALTER TABLE "Connector" ADD PRIMARY KEY ("CoID");
ALTER TABLE "Zone" ADD PRIMARY KEY ("ZoID");
ALTER TABLE "Service" ADD PRIMARY KEY ("SeID");
ALTER TABLE "Component" ADD PRIMARY KEY ("CoID");
ALTER TABLE "Unit" ADD PRIMARY KEY ("UnID");
ALTER TABLE "Group" ADD PRIMARY KEY ("GrID");
ALTER TABLE "DeviceGroup" ADD PRIMARY KEY ("DeID", "GrID");
ALTER TABLE "LogComponent" ADD PRIMARY KEY ("LoCoID");
ALTER TABLE "User" ADD PRIMARY KEY ("UsID");
ALTER TABLE "GroupUser" ADD PRIMARY KEY ("GrID", "UsID");
ALTER TABLE "LogConnector" ADD PRIMARY KEY ("LoCoID");
ALTER TABLE "DeviceComponent" ADD PRIMARY KEY ("DeCoID");
ALTER TABLE "ServiceDevice" ADD PRIMARY KEY ("SeID", "DeID");
ALTER TABLE "Rule" ADD PRIMARY KEY ("RuID");
ALTER TABLE "LogRule" ADD PRIMARY KEY ("LoRuID");
ALTER TABLE "HistoryLogComponente" ADD PRIMARY KEY ("HiLoCoID");
ALTER TABLE "HistoryLogConnector" ADD PRIMARY KEY ("HiLoCoID");
ALTER TABLE "HistoryLogRule" ADD PRIMARY KEY ("HiLoRuID");
ALTER TABLE "DeviceComponenteReplace" ADD PRIMARY KEY ("DeCoID", "DeCoIDReplaced");
ALTER TABLE "GroupZone" ADD PRIMARY KEY ("GrID", "ZoID");

ALTER TABLE "Device" ADD FOREIGN KEY ("CoID") REFERENCES "Connector"("CoID");
ALTER TABLE "Device" ADD FOREIGN KEY ("ZoID") REFERENCES "Zone"("ZoID");
ALTER TABLE "Zone" ADD FOREIGN KEY ("SuZoID") REFERENCES "Zone"("ZoID");
ALTER TABLE "Component" ADD FOREIGN KEY ("UnID") REFERENCES "Unit"("UnID");
ALTER TABLE "DeviceGroup" ADD FOREIGN KEY ("DeID") REFERENCES "Device"("DeID");
ALTER TABLE "DeviceGroup" ADD FOREIGN KEY ("GrID") REFERENCES "Group"("GrID");
ALTER TABLE "LogComponent" ADD FOREIGN KEY ("DeCoID") REFERENCES "DeviceComponent"("DeCoID");
ALTER TABLE "GroupUser" ADD FOREIGN KEY ("GrID") REFERENCES "Group"("GrID");
ALTER TABLE "GroupUser" ADD FOREIGN KEY ("UsID") REFERENCES "User"("UsID");
ALTER TABLE "LogConnector" ADD FOREIGN KEY ("CoID") REFERENCES "Connector"("CoID");
ALTER TABLE "DeviceComponent" ADD FOREIGN KEY ("SeID") REFERENCES "Component"("CoID");
ALTER TABLE "DeviceComponent" ADD FOREIGN KEY ("GeID") REFERENCES "Device"("DeID");
ALTER TABLE "ServiceDevice" ADD FOREIGN KEY ("SeID") REFERENCES "Service"("SeID");
ALTER TABLE "ServiceDevice" ADD FOREIGN KEY ("DeID") REFERENCES "Device"("DeID");
ALTER TABLE "LogRule" ADD FOREIGN KEY ("RuID") REFERENCES "Rule"("RuID");
ALTER TABLE "HistoryLogComponente" ADD FOREIGN KEY ("DeCoID") REFERENCES "DeviceComponent"("DeCoID");
ALTER TABLE "HistoryLogConnector" ADD FOREIGN KEY ("CoID") REFERENCES "Connector"("CoID");
ALTER TABLE "HistoryLogRule" ADD FOREIGN KEY ("RuID") REFERENCES "Rule"("RuID");
ALTER TABLE "DeviceComponenteReplace" ADD FOREIGN KEY ("DeCoID") REFERENCES "DeviceComponent"("DeCoID");
ALTER TABLE "DeviceComponenteReplace" ADD FOREIGN KEY ("DeCoIDReplaced") REFERENCES "DeviceComponent"("DeCoID");
ALTER TABLE "GroupZone" ADD FOREIGN KEY ("GrID") REFERENCES "Group"("GrID");
ALTER TABLE "GroupZone" ADD FOREIGN KEY ("ZoID") REFERENCES "Zone"("ZoID");
ALTER TABLE "Zone" ADD CONSTRAINT "Na_ObZoID" UNIQUE ("Name","SuZoID");
