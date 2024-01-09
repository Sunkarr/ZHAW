-- Aufgabe 1
select name, vorname
from besucher
where strasse = 'Dorfstrasse';

SELECT Name, Vorname
FROM Besucher
WHERE Strasse = 'Dorfstrasse';

-- Aufgabe 2
select distinct bname, bvorname
from lieblingsbier
where bsorte = 'Malzdrink' and bewertung > 3.0;

SELECT DISTINCT Bname
FROM Lieblingsbier
WHERE Bsorte = 'Malzdrink' AND Bewertung > 3;

-- Aufgabe 3
select name, vorname
from besucher
where strasse = 'Dorfstrasse'
order by name desc , vorname desc;

SELECT Name, Vorname
FROM Besucher
WHERE Strasse = 'Dorfstrasse'
ORDER BY Name DESC, Vorname DESC;

-- Aufgabe 4
select distinct r.name, r.suppenpreis
from restaurant r
join sortiment s on r.name = s.rname
join biersorte b on s.bsorte = b.name
where b.grundstoff = 'Hopfen';

SELECT DISTINCT r.Name,r.Suppenpreis
FROM Restaurant r
JOIN Sortiment s ON r.Name = s.Rname
JOIN Biersorte b ON s.Bsorte = b.Name
WHERE b.Grundstoff = 'Hopfen';

-- Aufgabe 5
select distinct b.name, b.gebtag
from gast g
join restaurant r on g.rname = r.name
join besucher b on g.bname = b.name and g.bvorname = b.vorname
where r.eroeffnungsdatum < '2010-01-01';

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
LEFT JOIN x ON x.bname = besucher.name AND x.bvorname = besucher.vorname
WHERE x.bname IS NULL AND x.bvorname IS NULL;

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
select name, vorname, strasse
from besucher
except
select b.name, b.vorname, b.strasse
from besucher b
join restaurant on restaurant.strasse = b.strasse
order by name;

SELECT Name, Vorname, Strasse
FROM Besucher AS x
WHERE
  NOT EXISTS (
    SELECT 1
    FROM   Gast y, Restaurant z
    WHERE  x.Name = y.Bname AND x.Vorname = y.Bvorname AND
           y.Rname = z.Name AND x.Strasse = z.Strasse)
order by name;

-- Aufgabe 8
select distinct bname, bvorname
from lieblingsbier natural join sortiment
order by bname, bvorname;

SELECT DISTINCT Bname, Bvorname
FROM Lieblingsbier NATURAL JOIN Sortiment;

-- Aufgabe 9
select bsorte as Lieblingsbiersorte
from lieblingsbier l, gast g
where l.bvorname = g.bvorname and l.bname = g.bname and rname = 'Löwen' and l.bvorname like 'P%';

SELECT DISTINCT Bsorte
FROM Gast x, Lieblingsbier y
WHERE x.Bvorname LIKE 'P%' AND x.Rname = 'Löwen' AND
      x.Bname = y.Bname AND x.Bvorname = y.Bvorname;

-- Aufgabe 10
SELECT DISTINCT x.Strasse
FROM Restaurant x, Restaurant y, Restaurant z
WHERE x.Strasse = y.Strasse AND y.Strasse = z.Strasse AND
  NOT (x.Name = y.Name OR x.Name = z.Name OR y.Name = z.Name);