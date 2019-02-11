-- -- drop database GIDI;
create database if not exists GIDI;
use GIDI;


drop table if exists GIDI.DBG;
drop table if exists GIDI.PRODUZIONE;
drop table if exists GIDI.LAVORAZIONI;
drop table if exists GIDI.TAGLI;


create table if not exists GIDI.LAVORAZIONI (
	LAVORAZIONE_ID INT NOT NULL AUTO_INCREMENT,
    primary key (LAVORAZIONE_ID),
    NAME VARCHAR(50),
    unique (NAME),
    DATA_CREAZIONE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PARAM_1 INT,
    PARAM_2 INT,
    PARAM_3 INT,
    PARAM_4 FLOAT,
    PARAM_5 FLOAT,
    PARAM_6 bool,
    PARAM_7 bool,
    PARAM_8 bool,
    PARAM_9 bool
) ENGINE=INNODB ;

create table if not exists GIDI.PRODUZIONE (
	PRODUZIONE_ID INT NOT NULL AUTO_INCREMENT,
    primary key (PRODUZIONE_ID),
    LOG_ID INT UNSIGNED NOT NULL UNIQUE KEY,
    LAVORAZIONE_ID INT,
    foreign key (LAVORAZIONE_ID) references GIDI.LAVORAZIONI(LAVORAZIONE_ID),
    CODICE_PRODUZIONE VARCHAR(50),
    TARGET INT,
    PRODOTTI INT DEFAULT 0,
    PRIORITA INT DEFAULT 0
    
) ENGINE=INNODB ;

create table if not exists GIDI.TAGLI (
	TAGLIO_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    primary key (TAGLIO_ID),
    ID_LOG INT UNSIGNED NOT NULL UNIQUE KEY,
    TSTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CODICE_PRODUZIONE VARCHAR(50),
    NOME_LAVORAZIONE VARCHAR(50),
    PV_PAR_1 FLOAT,
    PV_PAR_2 FLOAT,
    PV_PAR_3 FLOAT,
    PV_PAR_4 FLOAT,
    PV_PAR_5 FLOAT,
    PV_PAR_6 FLOAT,
    PV_PAR_7 FLOAT,
    PV_PAR_8 FLOAT,
    PV_PAR_9 FLOAT,
    PV_PAR_10 FLOAT
) ENGINE=INNODB ;


create table if not exists GIDI.DBG (
	DBG_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    LOG_ID INT UNSIGNED NOT NULL UNIQUE KEY,
	TSTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    OBJECT varchar(30),
    STATE boolean,
    INFO text,
    MESSAGE text,
    INNER_EXCEPTION text,
    primary key (DBG_ID)
)ENGINE=INNODB;


insert into GIDI.LAVORAZIONI (NAME,PARAM_1,PARAM_2,PARAM_3,PARAM_4,PARAM_5,PARAM_6,PARAM_7,PARAM_8,PARAM_9) values
('RicettaGIDI1',1,1,1,1,1,1,1,false,true),
('RicettaGIDI2',1.1,1.2,1.3,1.4,1.5,1.6,1.7,false,true),
('RicettaGIDI3',1.1,1.2,1.3,1.4,1.5,1.6,1.7,false,true),
('RicettaGIDI4',1.1,1.2,1.3,1.4,1.5,1.6,1.7,false,true),
('RicettaGIDI5',1,1,1,1,1,1,1,false,true);




-- insert produzione
REPLACE INTO PRODUZIONE
SET LOG_ID = (SELECT COALESCE(MAX(PRODUZIONE_ID), 0) % 999 + 1 FROM PRODUZIONE as p),
LAVORAZIONE_ID = 1,
CODICE_PRODUZIONE = 'aywewru2f2egf2efy',
TARGET = 0,
PRODOTTI= 0,
PRIORITA = 50;

select * from GIDI.PRODUZIONE;




/*
insert into GIDI.PRODUZIONE (LAVORAZIONE_ID,CODICE_PRODUZIONE,TARGET) values
(1,'2018-96-8545',250),
(1,'2018-96-8541',350),
(3,'2018-96-8542',450),
(2,'2018-96-8543',550),
(2,'2018-96-8547',650),
(4,'2018-96-8548',750),
(2,'2018-96-8549',850);
*/

-- select p.ID, p.CODICE_PRODUZIONE, l.NAME as 'NOME RICETTA', p.TARGET, p.PRODOTTI  from GIDI.PRODUZIONE p
-- join GIDI.LAVORAZIONE l ON l.ID = p.LAVORAZIONE_ID;


-- 
-- select * from GIDI.LAVORAZIONI;
-- select * from GIDI.PRODUZIONE;
-- delete from LAVORAZIONI WHERE ID = 2;


/*
select * from GIDI.DBG;

call GIDI.while_example();
truncate table GIDI.TAGLI;
select count(*) from GIDI.TAGLI;
SELECT 
table_name AS `Table`, 
round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB` 
FROM information_schema.TABLES 
WHERE table_schema = "GIDI"
AND table_name = "TAGLI";