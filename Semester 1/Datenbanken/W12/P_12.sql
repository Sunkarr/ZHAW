-- Aufgabe 1

with a as (
    select *
    from l
    natural join ltp),
    b as (
    select *
    from p
    natural join ltp)
select distinct a.tnr
from a
join b on a.lnr = b.lnr
where a.stadt = b.stadt;

SELECT DISTINCT LTP.TNr
FROM LTP, L, P
WHERE LTP.LNr = L.LNr AND LTP.PNr = P.PNr AND
L.Stadt = P.Stadt;

-- Aufgabe 2

select lnr, sum (menge)
from ltp
where lnr = 'L1'
group by lnr;

SELECT SUM(Menge)
FROM LTP, L
WHERE LTP.LNr = L.LNr AND L.LName ='Sulzer' AND LTP.TNr ='T1';

-- Aufgabe 3

select distinct tnr
from ltp
where menge > 350;

SELECT DISTINCT TNr
FROM LTP
GROUP BY TNr, PNr
HAVING AVG(Menge) > 350;

-- Aufgabe 4

select distinct pname
from ltp, l, p
where ltp.lnr = l.lnr and ltp.pnr = p.pnr and lname = 'Sulzer';

SELECT DISTINCT P.Pname
FROM LTP, L, P
WHERE LTP.LNr = L.LNr AND LTP.PNr = P.PNr AND
L.LName ='Sulzer';

-- Aufgabe 5

select distinct farbe
from ltp, t, l
where ltp.lnr = l.lnr and t.tnr = ltp.tnr and lname = 'Sulzer';

SELECT DISTINCT T.Farbe
FROM LTP, L, T
WHERE LTP.LNr = L.LNr AND LTP.TNr = T.TNr AND
L.LName = 'Sulzer';

-- Aufgabe 6

select distinct tnr
from ltp, p
where ltp.pnr = p.pnr and stadt = 'Winterthur';

SELECT DISTINCT LTP.TNr
FROM LTP, P
WHERE LTP.PNr = P.PNr AND P.Stadt ='Winterthur';

-- Aufgabe 7

select distinct p.pnr
from ltp, l, p
where ltp.lnr = l.lnr and ltp.pnr = p.pnr and lname = 'Sulzer';

SELECT DISTINCT x.PNr
FROM LTP AS x, LTP AS y, L
WHERE x.TNr = y.TNr AND y.LNr = L.LNr AND L.LName ='Sulzer';

-- Aufgabe 8

select lnr, tnr
from l
cross join t
except
select lnr, tnr
from ltp;

(SELECT LNr, TNr FROM L, T)
EXCEPT
(SELECT LNr, TNr FROM LTP);

-- oder:

SELECT LNr, TNr
FROM L, T
WHERE NOT EXISTS (
 SELECT ''
 FROM LTP
 WHERE LTP.LNr=L.LNr AND LTP.TNr=T.TNr);

-- Aufgabe 9

create view avgmengep as
select pnr, avg(menge)
from ltp
group by pnr;






















