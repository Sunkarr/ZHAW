CREATE TABLE mitarbeiter(
    mitarbeiter_id integer PRIMARY KEY ,
    name varchar,
    vorname varchar);

CREATE TABLE firma(
    firma_id integer,
    name varchar,
    ort varchar,
    CONSTRAINT pk_firma PRIMARY KEY (firma_id));

create table arbeitet (
    mitarbeiter_id integer NOT NULL default 1,
    firma_id integer NOT NULL default 1,
    CONSTRAINT ma_uniq UNIQUE (mitarbeiter_id),
    CONSTRAINT fk_mitarbeiter FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeiter(mitarbeiter_id),
    CONSTRAINT fk_firma FOREIGN KEY (firma_id) REFERENCES firma(firma_id));

alter table firma
    add gruendungsjahr integer not null;

alter table mitarbeiter
    add jahreslohn float default 1;

ALTER TABLE arbeitet
    ADD jahreslohn FLOAT,
    ADD CONSTRAINT fk_jahreslohn FOREIGN KEY (jahreslohn) REFERENCES mitarbeiter(jahreslohn);

alter table mitarbeiter
    ADD CONSTRAINT unique_jahreslohn UNIQUE (jahreslohn);

alter table arbeitet
    drop jahreslohn;

alter table mitarbeiter
    add plz integer not null default 1,
    add ort varchar not null default 1,
    add strasse varchar not null default 1,
    add hausnummer float;

INSERT INTO firma (firma_id, name, ort, gruendungsjahr) VALUES
    (1, 'SBB', 'Zuerich', 2000),
    (2, 'CS', 'Zuerich', 2010),
    (3, 'UBS', 'Basel', 2005);

alter table mitarbeiter
    add arbeitet varchar not null default 1;

INSERT INTO mitarbeiter (mitarbeiter_id , name, vorname, jahreslohn, plz, ort, strasse, hausnummer) VALUES
    (1, 'Jonas', 'Bratschi', 100000, 8048, 'Zuerich', 'Hallostrasse', '1'),
    (2, 'Max', 'Muster', 120000, 8090, 'Mueter', 'Nuttnstrasse', '20'),
    (3, 'Fabian', 'Mueller', 80000, 6020, 'Rapperswil', 'Dorfplatz', '31'),
    (4, 'Abdullah', 'Mohammed', 20000, 5070, 'TamamTamam', 'Inshallah', '45'),
    (5, 'James', 'Jones', 40500, 4578, 'Schuessmitot', 'Tschuessstrasse', '458');

UPDATE mitarbeiter
SET arbeitet = CASE
                      WHEN mitarbeiter_id = 1 THEN 'UBS'
                      WHEN mitarbeiter_id = 2 THEN 'UBS'
                      WHEN mitarbeiter_id = 3 THEN 'CS'
                      WHEN mitarbeiter_id = 4 THEN 'SBB'
                      WHEN mitarbeiter_id = 5 THEN 'SBB'
                    END
WHERE mitarbeiter_id IN (1, 2, 3, 4, 5);

ALTER TABLE mitarbeiter
ADD COLUMN telefonnummer INTEGER not null default 1;

UPDATE mitarbeiter
SET telefonnummer = CASE
                      WHEN mitarbeiter_id = 1 THEN 0449211801
                      WHEN mitarbeiter_id = 2 THEN 0449211802
                      WHEN mitarbeiter_id = 3 THEN 0449211803
                      WHEN mitarbeiter_id = 4 THEN 0449211804
                      WHEN mitarbeiter_id = 5 THEN 0449211805
                    END
WHERE mitarbeiter_id IN (1, 2, 3, 4, 5);

ALTER TABLE mitarbeiter
RENAME COLUMN arbeitet TO firma;

ALTER TABLE firma
RENAME COLUMN name TO firma;

drop table arbeitet;

create table arbeitet (
    mitarbeiter_id integer NOT NULL default 1,
    firma_id integer NOT NULL default 1,
    CONSTRAINT ma_uniq UNIQUE (mitarbeiter_id),
    CONSTRAINT fk_mitarbeiter FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeiter(mitarbeiter_id),
    CONSTRAINT fk_firma FOREIGN KEY (firma_id) REFERENCES firma(firma_id));


UPDATE mitarbeiter
SET plz = 6000, ort = 'Bern', strasse = 'Bundeshaus'
WHERE mitarbeiter_id = 3;

update firma
set name = 'Migros'
where firma_id = 1;

 drop table arbeitet;
 drop table firma;
 drop table mitarbeiter;

