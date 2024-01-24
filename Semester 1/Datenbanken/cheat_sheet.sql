constraint preise.einkaufspreis
check einkaufspreis < verkaufspreis

----------------

select *
from mitarbeiter
where abteilung = 'HR';

----------------

create trigger strassenänderung
    before update
    on mitarbeiter
    for each row
    execute procedure log_strasse();

----------------

select s, count(*) as count
from abgabe
group by s
having count(*) > 5;

----------------

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

----------------

-- Join ltp, l, p where L.Stadt = P.Stadt

SELECT DISTINCT LTP.TNr
FROM LTP, L, P
WHERE LTP.LNr = L.LNr AND LTP.PNr = P.PNr AND
L.Stadt = P.Stadt;

----------------

-- Allte Städte in denen ein Lieferant, Teil oder Projekt ist

select stadt
from l
union
select stadt
from t
union
select stadt
from p

----------------

create table test (
    id integer unique not null primary key,
    gebdat  date,
    bestdat date,
    CONSTRAINT check_dates CHECK (gebdat > bestdat));

----------------

select bsorte, avg(bewertung)
from lieblingsbier
group by bsorte;

select rname, sum(anlager)
from sortiment
group by rname;

----------------

select *
from besucher
where strasse like '%strasse';

select *
from besucher
where strasse in ('Dorfstrasse');

----------------

-- Alle "uniquen" Strassen
select distinct strasse
from besucher
order by strasse;

----------------

create table arbeitet (
    mitarbeiter_id integer NOT NULL default 1,
    firma_id integer NOT NULL default 1,
    CONSTRAINT ma_uniq UNIQUE (mitarbeiter_id),
    CONSTRAINT fk_mitarbeiter FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeiter(mitarbeiter_id),
    CONSTRAINT fk_firma FOREIGN KEY (firma_id) REFERENCES firma(firma_id));

----------------
