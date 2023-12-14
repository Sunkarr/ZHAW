-- Bewertetes Praktikum W12
-- fabiosi1, vocatgwe, bratsjon, gampegia

----------------------------------------------
-- Aufgabe 1

create table kaffeesorte(
    k integer primary key not null unique,
    kname varchar not null );

create table sammelstelle(
    s integer primary key not null unique,
    sort varchar not null ,
    sland varchar not null);

create table abgabe(
    a integer not null ,
    aanzkg float,
    adatum date not null ,
    s integer ,
    k integer ,
    foreign key (s) references sammelstelle (s),
    foreign key (k) references kaffeesorte (k),
    primary key (a, s, k));

create table abgabe_möglich(
    s integer,
    k integer,
    foreign key (s) references sammelstelle (s),
    foreign key (k) references kaffeesorte (k),
    primary key (s, k));

create table fabrik(
    f integer not null unique,
    fort varchar not null,
    fland varchar not null);

create table lieferung_möglich(
    s integer,
    f integer,
    k integer,
    foreign key (s) references sammelstelle (s),
    foreign key (f) references fabrik (f),
    foreign key (k) references kaffeesorte (k),
    primary key (s, f, k));

create table lieferung(
    l integer not null unique,
    s integer,
    f integer,
    k integer,
    lanzkg float,
    ldatum date not null,
    foreign key (s) references sammelstelle (s),
    foreign key (f) references fabrik (f),
    foreign key (k) references kaffeesorte (k),
    primary key (l, s, f, k));

insert into sammelstelle (s, sort, sland) values
                                              (1, 'Zürich', 'Schweiz'),
                                              (2, 'Altstette', 'Schweiz'),
                                              (3, 'Bern', 'Schweiz');

insert into kaffeesorte (k, kname) values
                                       (1, 'Braun'),
                                       (2, 'Schwarz'),
                                       (3, 'Ristretto'),
                                       (4, 'Mr. Brown');

insert into fabrik (f, fort, fland) values
                                        (1, 'Oberrieden', 'Schweiz'),
                                        (2, 'Männedorf', 'Schweiz'),
                                        (3, 'Ouagadougu', 'Burkina Faso');

INSERT INTO abgabe_möglich (s, k)
SELECT s.s, k.k
FROM sammelstelle s
CROSS JOIN kaffeesorte k;

insert into abgabe (a, s, k ,aanzkg, adatum) values
                                                    (1,1,1,53.6,'2023-12-01'),
                                                    (2,2,1,7.8,'2023-12-02'),
                                                    (3,3,1,12.2,'2023-12-03'),
                                                    (4,1,2,88.4,'2023-12-04'),
                                                    (5,2,2,47.9,'2023-12-05'),
                                                    (6,3,2,95.3,'2023-12-06'),
                                                    (7,1,3,18.1,'2023-12-07'),
                                                    (8,2,3,61.7,'2023-12-08'),
                                                    (9,3,3,3.9,'2023-12-09'),
                                                    (10,1,4,34, '2023-12-10'),
                                                    (11,1,3,45.3, '2023-12-11'),
                                                    (12,1,2,350.3, '2023-12-12');


INSERT INTO lieferung_möglich (s, k, f)
SELECT s.s, k.k AS z, f.f
FROM sammelstelle s
CROSS JOIN kaffeesorte k
CROSS JOIN fabrik f;

insert into lieferung (l, s, f, k, lanzkg, ldatum) values
                                                            (1, 1, 1, 1, 67.8, '2023-02-15'),
                                                            (2, 1, 1, 2, 45.6, '2023-08-05'),
                                                            (3, 1, 1, 3, 23.4, '2023-11-21'),
                                                            (4, 1, 2, 1, 12.5, '2023-06-09'),
                                                            (5, 1, 2, 2, 89.1, '2023-04-17'),
                                                            (6, 1, 2, 3, 34.2, '2023-09-28'),
                                                            (7, 1, 3, 1, 56.7, '2023-01-12'),
                                                            (8, 1, 3, 2, 78.3, '2023-03-25'),
                                                            (9, 1, 3, 3, 90.9, '2023-07-07'),
                                                            (10, 2, 1, 1, 67.8, '2023-10-14'),
                                                            (11, 2, 1, 2, 45.6, '2023-05-30'),
                                                            (12, 2, 1, 3, 23.4, '2023-12-02'),
                                                            (13, 2, 2, 1, 12.5, '2023-02-19'),
                                                            (14, 2, 2, 2, 89.1, '2023-08-08'),
                                                            (15, 2, 2, 3, 34.2, '2023-11-24'),
                                                            (16, 2, 3, 1, 56.7, '2023-06-13'),
                                                            (17, 2, 3, 2, 78.3, '2023-04-01'),
                                                            (18, 2, 3, 3, 90.9, '2023-09-11'),
                                                            (19, 3, 1, 1, 67.8, '2023-01-08'),
                                                            (20, 3, 1, 2, 45.6, '2023-03-20'),
                                                            (21, 3, 1, 3, 23.4, '2023-07-03'),
                                                            (22, 3, 2, 1, 12.5, '2023-10-22'),
                                                            (23, 3, 2, 2, 89.1, '2023-05-15'),
                                                            (24, 3, 2, 3, 34.2, '2023-12-08'),
                                                            (25, 3, 3, 1, 56.7, '2023-02-09'),
                                                            (26, 3, 3, 2, 78.3, '2023-08-01'),
                                                            (27, 3, 3, 3, 90.9, '2023-11-15');
----------------------------------------------
-- Aufgabe 2

select distinct k, kname
from kaffeesorte
natural join abgabe
natural join (
    select *
    from kaffeesorte
    except
    select k, kname
    from lieferung
    natural join kaffeesorte);

----------------------------------------------
-- Aufgabe 3

SELECT k.kname
FROM kaffeesorte k
JOIN lieferung l ON k.k = l.k
GROUP BY k.kname
HAVING COUNT(DISTINCT l.f) = (SELECT COUNT(*) FROM fabrik);

----------------------------------------------
-- Aufgabe 4

with abgabe_counts as (
    select s, count(*) as count_abgabe
    from abgabe
    group by s
    having count(*) > 5),
lieferung_counts as (
    select s, count(f) as count_lieferung
    from lieferung
    group by s
    having count(f) > 3)

select *
from abgabe_counts
natural join lieferung_counts;

----------------------------------------------




