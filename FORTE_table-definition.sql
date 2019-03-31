CREATE DATABASE IF NOT EXISTS RIBONI_FORTE;
drop table if exists RIBONI_FORTE.TAGLI_EFFETTUATI;
drop table if exists RIBONI_FORTE.PRODUZIONE;
drop table if exists RIBONI_FORTE.LAVORAZIONI;
drop table if exists RIBONI_FORTE.PRODUZIONI_CONCLUSE;
drop table if exists RIBONI_FORTE.LOG_ALLARMI;
drop table if exists RIBONI_FORTE.CATALOGO_ALLARMI;
drop table if exists RIBONI_FORTE.CAMPIONAMENTO;


create table if not exists RIBONI_FORTE.TAGLI_EFFETTUATI (
	TAGLIO_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    primary key (TAGLIO_ID),
    ID_LOG INT UNSIGNED NOT NULL UNIQUE KEY,
    TSTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CODICE_PRODUZIONE VARCHAR(50),
    NUMERO_PROGRAMMA int,
    NUMERO_PROSSIMO_PROGRAMMA int,
    LUNGHEZZA_PEZZO int comment '[mm]',
    TAGLI_RICHIESTI int,
    TAGLI_EFFETTUATI int,
    VELOCITA_LAMA_SP int comment '[m/min]',
    VELOCITA_MEDIA_LAMA int comment '[m/min]',
    POSIZIONE_CARRO int comment '[mm]',
    AVANZAMENTO_MEDIO_TAGLIO int comment '[mm/min]',
	RIPETIZIONI int
) ENGINE=INNODB ;

SELECT * FROM TAGLI_EFFETTUATI;

create table if not exists RIBONI_FORTE.LAVORAZIONI (
	LAVORAZIONE_ID INT NOT NULL AUTO_INCREMENT,
    primary key (LAVORAZIONE_ID),
    NAME VARCHAR(50),
    unique (NAME),
    DATA_CREAZIONE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    NUMERO_PROSSIMO_PROGRAMMA INT DEFAULT 0,
	LUNGHEZZA_TAGLIO INT,
    VELOCITA_LAMA_SP INT
) ENGINE=INNODB ;

-- insert into LAVORAZIONI values (1,"test1",current_timestamp,1,20,20),(2,"test2",current_timestamp,2,25,25),(3,"test3",current_timestamp,3,33,33);


create table if not exists RIBONI_FORTE.PRODUZIONE (
	PRODUZIONE_ID INT NOT NULL AUTO_INCREMENT,
    primary key (PRODUZIONE_ID),
    LOG_ID INT UNSIGNED NOT NULL UNIQUE KEY,
    LAVORAZIONE_ID INT NOT NULL,
    foreign key (LAVORAZIONE_ID) references RIBONI_FORTE.LAVORAZIONI(LAVORAZIONE_ID),
    CODICE_PRODUZIONE VARCHAR(50),
    TARGET INT,
    DATA_INIZIO DATETIME DEFAULT NULL,
    PRODOTTI INT DEFAULT 0,
    PRIORITA INT DEFAULT 0
    
) ENGINE=INNODB ;

-- insert into PRODUZIONE (PRODUZIONE_ID,LOG_ID,LAVORAZIONE_ID,CODICE_PRODUZIONE,TARGET) values (1,1,1,"test1",1),(2,2,2,"test2",2),(3,3,3,"test3",3);
-- insert into PRODUZIONE (PRODUZIONE_ID,LOG_ID,LAVORAZIONE_ID,CODICE_PRODUZIONE,TARGET) values (4,4,7,"test4",1);
-- delete from LAVORAZIONI where LAVORAZIONE_ID = 1;

create table if not exists RIBONI_FORTE.PRODUZIONI_CONCLUSE (
	PRODUZIONE_ID INT NOT NULL,
    primary key (PRODUZIONE_ID),
    NOME_LAVORAZIONE VARCHAR(50),
    CODICE_PRODUZIONE VARCHAR(50),
    TARGET INT,
    PRODOTTI INT,
    DATA_INIZIO DATETIME,
    DATA_CONSUNTIVAZIONE DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB ;




create table RIBONI_FORTE.CATALOGO_ALLARMI(
	CODICE int not null,
    unique (codice),
	TESTO VARCHAR(200) not null,
	primary key (CODICE)
);

create table RIBONI_FORTE.LOG_ALLARMI(
	LOG_ID int not null auto_increment,
    primary key (LOG_ID),
	CODICE_ALLARME int not null,
    FOREIGN KEY (CODICE_ALLARME) REFERENCES CATALOGO_ALLARMI(CODICE),
	T_STAMP TIMESTAMP default CURRENT_TIMESTAMP
);

create table RIBONI_FORTE.CAMPIONAMENTO(
	CAMPIONAMENTO_ID  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    primary key (CAMPIONAMENTO_ID),
    LOG_ID INT UNSIGNED NOT NULL UNIQUE KEY,
    TAGLIO_ID BIGINT UNSIGNED,
	T_STMAP TIMESTAMP DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
    AVANZAMENTO_TAGLIO FLOAT,
    VELOCITA_LAMA FLOAT
) ENGINE=INNODB ;

select * from CAMPIONAMENTO;
select * from tagli_effettuati;

/*
//
//  Creazione testo per allarmi, e shift del id di uno, per
//  partire da offset 0
// 
*/
insert into RIBONI_FORTE.CATALOGO_ALLARMI (CODICE,TESTO)
values (32160,'Collisione Morse'),
(32161,'Controllare pulizia o funzionamento fotocellula punto 0'),
(32162,'Raggiunta fine del programma'),
(32163,'Fine Materiale'),
(32164,'Gruppo Morse Scaricato'),
(32165,'Idraulica Disinserita'),
(32166,'Comando Segatrice Disinserito'),
(32167,'Morse Vicino Lama non Chiuse'),
(32170,'Micro posizione carro avanti e indietro simultaneo'),
(32171,'Micro fine corsa posizione testa segatrice su/giù'),
(32172,'Morse anteriore senza pressione'),
(32173,'Morse avanzamento senza pressione'),
(32174,'Lama rotta o mancante'),
(32175,'Valore di deflettore oltre il limite impostato '),
(32176,'Protezioni aperte'),
(32177,'Pulsante emergenza termica motori'),
(32180,'Lubrificazione centralizzata non funzionante, controllare livello '),
(32181,'Livello liquido refrigerante troppo basso'),
(32182,'Malfunzionamento relais modulo K17 Carter Lama'),
(32183,'Tasto manuale ( su fianco ) non azionato'),
(32184,'Testa segatrice non alzata'),
(32185,'Lunghezza del pezzo rimanente più grande del campo di avanzamento'),
(32186,'Spegnere motore lama'),
(32187,'Verificare e pulire il sensore per il deflettore'),
(32190,'No materiale sotto Lama'),
(32191,'Errore di programmazione, controllare i valori inseriti'),
(0,'Nessun Allarme Presente');