-- -- drop database RIBONI;
create database if not exists RIBONI;
use RIBONI;


drop table if exists RIBONI.DBG;

-- create table if not exists TOOEZ.PEOPLE_BASIC (
-- 	BASIC_ID INT NOT NULL AUTO_INCREMENT,
--     primary key (BASIC_ID),
--     EMAIL VARCHAR(50),
--     unique (EMAIL),
--     PASSWORD VARCHAR(64)
-- )ENGINE=INNODB;
-- 
-- create table if not exists TOOEZ.PEOPLE_INFO (
-- 	BASIC_ID INT,
--     primary key (BASIC_ID),
--     foreign key (BASIC_ID) references PEOPLE_BASIC(BASIC_ID),
--     NAME VARCHAR(50),
--     SURNAME VARCHAR(50),
--     NICKNAME VARCHAR(50),
--     unique (NICKNAME),
--     SHOW_PRIVATE_NAME bit(1)
-- ) ENGINE=INNODB ;

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

REPLACE INTO RIBONI.DBG
SET DBG_ID = (SELECT COALESCE(MAX(ID), 0) % 5 + 1 FROM DBG as d),
INFO = 'I like turtles.',
OBJECT = 'test insert',
STATE = 0,
MESSAGE='messaggio dell errore',
INNER_EXCEPTION='inner ex dell errore';

select * from RIBONI.DBG;
