REPLACE INTO RIBONI.DBG
SET DBG_ID = (SELECT COALESCE(MAX(ID), 0) % 5 + 1 FROM DBG as d),
INFO = 'I like turtles.',
OBJECT = 'test insert',
STATE = 0,
MESSAGE='messaggio dell errore',
INNER_EXCEPTION='inner ex dell errore';

select * from RIBONI.DBG;