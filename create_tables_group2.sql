-- ============================================
-- CPSC 332 - Project
-- File: create_tables_group2.sql
-- Group: 2
-- Members: [Stephan Maready, Liyuhan Zhou, Marco Guirguis, Alex Trang]
-- Date: [4/15/26]
-- ============================================


-- ============================================
-- SECTION 1: DATABASE SETUP
-- ============================================

DROP DATABASE IF EXISTS world_group2;
CREATE DATABASE world_group2;
USE world_group2;

-- ============================================
-- SECTION 2: WORLD DB TABLES (DO NOT MODIFY)
-- These three tables are copied from world.sql
-- ============================================

-- Country table

CREATE TABLE Country (
  Code CHAR(3) NOT NULL DEFAULT '',
  Name CHAR(52) NOT NULL DEFAULT '',
  Continent ENUM('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL default 'Asia',
  Region CHAR(26) NOT NULL DEFAULT '',
  SurfaceArea FLOAT(10,2) NOT NULL DEFAULT '0.00',
  IndepYear SMALLINT(6) DEFAULT NULL,
  Population INT(11) DEFAULT NULL,
  LifeExpectancy FLOAT(3,1) DEFAULT NULL,
  GNP FLOAT(10,2) DEFAULT NULL,
  GNPOld FLOAT(10,2) DEFAULT NULL,
  LocalName CHAR(45) NOT NULL DEFAULT '',
  GovernmentForm CHAR(45) NOT NULL DEFAULT '',
  HeadOfState CHAR(60) DEFAULT NULL,
  Capital INT(11) DEFAULT NULL,
  Code2 CHAR(2) NOT NULL DEFAULT '',
  PRIMARY KEY  (Code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- City table

CREATE TABLE City (
  ID INT(11) NOT NULL auto_increment,
  Name CHAR(35) NOT NULL DEFAULT '',
  CountryCode CHAR(3) NOT NULL DEFAULT '',
  District CHAR(20) NOT NULL DEFAULT '',
  Population INT(11) DEFAULT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- CountryLanguage table

CREATE TABLE CountryLanguage (
  CountryCode CHAR(3) NOT NULL DEFAULT '',
  Language CHAR(30) NOT NULL DEFAULT '',
  IsOfficial ENUM('T','F') NOT NULL DEFAULT 'F',
  Percentage FLOAT(4,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY  (CountryCode,Language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ============================================
-- SECTION 3: WORLD DB FOREIGN KEYS (DO NOT MODIFY)
-- These FK constraints are provided for you.
-- The original world.sql does not include them.
-- ============================================

ALTER TABLE City
    ADD CONSTRAINT fk_city_country
    FOREIGN KEY (CountryCode) REFERENCES Country(Code);

ALTER TABLE CountryLanguage
    ADD CONSTRAINT fk_countryLanguage_country
    FOREIGN KEY (CountryCode) REFERENCES Country(Code);


-- ============================================
-- SECTION 4: YOUR NEW TABLES (MODIFY THIS SECTION)
-- Add exactly 3 new tables below.
-- Requirements for each table:
--   - At least one PRIMARY KEY
--   - At least one FOREIGN KEY referencing an existing table
--   - Appropriate data types and NOT NULL constraints
-- ============================================

-- EXAMPLE (delete this before submitting):
-- CREATE TABLE Economic_Indicators (
--     indicator_id  INT          NOT NULL AUTO_INCREMENT,
--     country_code  CHAR(3)      NOT NULL,
--     year          YEAR         NOT NULL,
--     gdp_billion   DECIMAL(15,2),
--     inflation_rate DECIMAL(5,2),
--     PRIMARY KEY (indicator_id),
--     CONSTRAINT fk_econ_country
--         FOREIGN KEY (country_code) REFERENCES Country(Code)
-- );

-- New Table 1: Education
-- Purpose: [Briefly describe what this table represents]
CREATE TABLE Education (
	ID INT(11) NOT NULL AUTO_INCREMENT,
    CountryCode CHAR(3) NOT NULL DEFAULT '',
    `Year` YEAR NOT NULL,
    LiteracyRate INT,
    PrimarySchoolEnrollmentNetPercentage INT,
    SecondarySchoolEnrollmentGrossPercentage INT,
    AvgYearsOfSchooling DECIMAL(3,1),
    EducationExpenditurePercentage DECIMAL(3,1),
    PRIMARY KEY (ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -- New Table 2: Tourism
-- -- Purpose: [Briefly describe what this table represents]
CREATE TABLE Tourism (
	ID INT(11) NOT NULL AUTO_INCREMENT,
	CountryCode CHAR(3) NOT NULL DEFAULT '',
	`Year` YEAR NOT NULL,
    NumOfTourists INT,
    TourismRevenueInUSD DECIMAL(11,2),
    AvgLengthOfStayInDays DECIMAL(3,1),
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -- New Table 3: Infrastructure
-- -- Purpose: [Briefly describe what this table represents]
CREATE TABLE Infrastructure (
	ID INT(11) NOT NULL AUTO_INCREMENT,
	CountryCode CHAR(3) NOT NULL DEFAULT '',
	`Year` YEAR NOT NULL,
    BasicSanitationServicesUsagePercentage INT,
    ElectricityAccessPercentage DECIMAL(3,1),
    InternetAccessPercentage INT,
    PavedRoadsPercentageOfTotalRoads INT,
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -- New Table 4: Climate Data
-- -- Purpose: [Briefly describe what this table represents]
CREATE TABLE ClimateData (
	ID INT(11) NOT NULL AUTO_INCREMENT,
	CountryCode CHAR(3) NOT NULL DEFAULT '',
	`Year` YEAR NOT NULL,
    AvgPrecipitationMillimetersPerYear DECIMAL(5,1),
    AnnualFossilFuelAndIndustryCO2Emissions DECIMAL(12,2),
    AgriculturalLandPercentage DECIMAL(3,1),
    ForestAreaPercentage DECIMAL(3,1),
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -- Alter Education Table to have UNIQUE CONSTRAINT and FOREIGN KEY
ALTER TABLE Education
    ADD CONSTRAINT FkEducationCountry 
        FOREIGN KEY (CountryCode) REFERENCES Country(Code),
    ADD CONSTRAINT UqEducationCountryYear 
        UNIQUE (CountryCode, `Year`);

-- -- Alter Tourism Table to have UNIQUE CONSTRAINT and FOREIGN KEY
ALTER TABLE Tourism
    ADD CONSTRAINT FkTourismCountry
        FOREIGN KEY (CountryCode) REFERENCES Country(Code),
    ADD CONSTRAINT UqTourismCountryYear 
        UNIQUE (CountryCode, `Year`);

-- -- Alter Infrastructure Table to have UNIQUE CONSTRAINT and FOREIGN KEY
ALTER TABLE Infrastructure
    ADD CONSTRAINT FkInfrastructureCountry
        FOREIGN KEY (CountryCode) REFERENCES Country(Code),
    ADD CONSTRAINT UqInfrastructureCountryYear 
        UNIQUE (CountryCode, `Year`);

-- -- Alter ClimateData Table to have UNIQUE CONSTRAINT and FOREIGN KEY
ALTER TABLE ClimateData
    ADD CONSTRAINT FkClimateDataCountry
        FOREIGN KEY (CountryCode) REFERENCES Country(Code),
    ADD CONSTRAINT UqClimateDataCountryYear 
        UNIQUE (CountryCode, `Year`);