-- -- drop database RIBONI;
create database if not exists RIBONI;
use RIBONI;


drop table if exists RIBONI.DBG;
drop table if exists RIBONI.LAVORAZIONI;
drop table if exists RIBONI.PRODUZIONE;
drop table if exists RIBONI.TAGLI;


create table if not exists RIBONI.LAVORAZIONI (
	ID INT NOT NULL AUTO_INCREMENT,
    primary key (ID),
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

create table if not exists RIBONI.PRODUZIONE (
	ID INT NOT NULL AUTO_INCREMENT,
    primary key (ID),
    ID_LAVORAZIONE INT,
    foreign key (ID_LAVORAZIONE) references RIBONI.LAVORAZIONE(ID),
    CODICE_PRODUZIONE VARCHAR(50),
    TARGET INT,
    PRODOTTI INT DEFAULT 0
    
) ENGINE=INNODB ;

create table if not exists RIBONI.TAGLI (
	ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    primary key (ID),
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

select * from TAGLI order by ID;






insert into RIBONI.PRODUZIONE (ID_LAVORAZIONE,CODICE_PRODUZIONE,TARGET) values
(1,'2018-96-8545',250);
select p.ID, p.CODICE_PRODUZIONE, l.NAME as 'NOME RICETTA', p.TARGET, p.PRODOTTI  from RIBONI.PRODUZIONE p
join RIBONI.LAVORAZIONE l ON l.ID = p.ID_LAVORAZIONE;

-- insert into RIBONI.LAVORAZIONI (NAME,PARAM_1,PARAM_2,PARAM_3,PARAM_4,PARAM_5,PARAM_6,PARAM_7,PARAM_8,PARAM_9) values
-- ('RicettaRiboni1',1,1,1,1,1,1,1,false,true),
-- ('RicettaRiboni2',1,1,1,1,1,1,1,false,true),
-- ('RicettaRiboni3',1,1,1,1,1,1,1,false,true),
-- ('RicettaRiboni4',1,1,1,1,1,1,1,false,true);
-- 
-- 
-- select * from RIBONI.LAVORAZIONI;
-- delete from LAVORAZIONI WHERE ID = 2;

create table if not exists RIBONI.DBG (
	ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    DBG_ID INT UNSIGNED NOT NULL UNIQUE KEY,
	TSTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    OBJECT varchar(30),
    STATE boolean,
    INFO text,
    MESSAGE text,
    INNER_EXCEPTION text,
    primary key (ID)
)ENGINE=INNODB;
select * from RIBONI.DBG;

call RIBONI.while_example();
truncate table RIBONI.TAGLI;
select count(*) from RIBONI.TAGLI;
SELECT 
table_name AS `Table`, 
round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB` 
FROM information_schema.TABLES 
WHERE table_schema = "RIBONI"
AND table_name = "TAGLI";