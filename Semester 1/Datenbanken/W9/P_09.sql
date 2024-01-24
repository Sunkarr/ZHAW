-- Aufgabe 1
select *
from besucher
where strasse = 'Dorfstrasse';

-- Aufgabe 2
select *
from lieblingsbier
where bsorte = 'Malzdrink' and bewertung > 3;

-- Aufgabe 3
select *
from besucher
where strasse = 'Dorfstrasse'
order by name, vorname;

-- Aufgabe 4
select restaurant.name, suppenpreis
from restaurant, sortiment, biersorte
where restaurant.name = sortiment.rname and sortiment.bsorte = biersorte.name and
      grundstoff = 'Hopfen';

SELECT DISTINCT r.Name,r.Suppenpreis
FROM Restaurant r
JOIN Sortiment s ON r.Name = s.Rname
JOIN Biersorte b ON s.Bsorte = b.Name
WHERE b.Grundstoff = 'Hopfen';

-- Aufgabe 5
select distinct besucher.name, besucher.vorname, besucher.gebtag
from restaurant, gast, besucher
where restaurant.name = gast.rname and gast.bname = besucher.name and gast.bvorname = besucher.vorname and
      eroeffnungsdatum < '2010-01-01';

SELECT DISTINCT b.Name, b.Gebtag
FROM Besucher b
JOIN Gast g ON b.Name = g.Bname AND b.Vorname = g.Bvorname
JOIN Restaurant r ON g.Rname = r.Name
WHERE r.Eroeffnungsdatum < '2010-01-01';

-- Aufgabe 6
with x as (
    select bname, bvorname
    from gast
    union
    select bname, bvorname
    from lieblingsbier)
select name, vorname
from besucher
left join x
on vorname = bvorname and name = bname
where bvorname is null and bname is null;

SELECT Name, Vorname
FROM Besucher AS x
WHERE
  NOT EXISTS (
    SELECT 1
    FROM   Gast
    WHERE  Bname = x.Name AND Bvorname = x.Vorname)
  AND
  NOT EXISTS (
    SELECT 1
    FROM   Lieblingsbier
    WHERE  Bname = x.Name AND Bvorname = x.Vorname);

-- Aufgabe 7
select a.name, a.vorname, a.strasse
from besucher a
except
select b.name, b.vorname, b.strasse
from besucher b, restaurant
where b.strasse = restaurant.strasse;

SELECT Name, Vorname, Strasse
FROM Besucher AS x
WHERE
  NOT EXISTS (
    SELECT 1
    FROM   Gast y, Restaurant z
    WHERE  x.Name = y.Bname AND x.Vorname = y.Bvorname AND
           y.Rname = z.Name AND x.Strasse = z.Strasse)

-- Aufgabe 8
select distinct bname, bvorname
from lieblingsbier, sortiment
where sortiment.bsorte = lieblingsbier.bsorte;

SELECT DISTINCT Bname, Bvorname
FROM Lieblingsbier NATURAL JOIN Sortiment;

-- Aufgabe 9
select distinct bsorte
from restaurant, gast, lieblingsbier
where name = gast.rname and gast.bname = lieblingsbier.bname and gast.bvorname = lieblingsbier.bvorname and
      restaurant.name = 'Löwen' and lieblingsbier.bvorname like 'P%';

SELECT DISTINCT Bsorte
FROM Gast x, Lieblingsbier y
WHERE x.Bvorname LIKE 'P%' AND x.Rname = 'Löwen' AND
      x.Bname = y.Bname AND x.Bvorname = y.Bvorname;

-- Aufgabe 10
select strasse, count(strasse)
from restaurant
group by strasse;