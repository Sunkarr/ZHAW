-- Aufgabe 1
select *
from besucher
where strasse = 'Dorfstrasse';

-- Aufgabe 2
select *
from lieblingsbier
where bsorte = 'Malzdrink' and bewertung > 3
order by literprowoche;

-- Aufgabe 3
select *
from besucher
where strasse = 'Dorfstrasse'
order by name, vorname;

-- Aufgabe 4
SELECT suppenpreis, restaurant.name
FROM restaurant
JOIN sortiment ON restaurant.name = sortiment.Rname
JOIN biersorte ON sortiment.Bsorte = biersorte.name
WHERE biersorte.grundstoff = 'Hopfen';

-- Aufgabe 5
SELECT besucher.name, besucher.vorname, besucher.gebtag
FROM besucher
JOIN gast ON besucher.name = gast.Bname
JOIN restaurant ON gast.Rname = restaurant.name
WHERE restaurant.eroeffnungsdatum > '2010-01-01';

-- Aufgabe 6
SELECT hersteller,
  COUNT(grundstoff) AS anzahlzutaten,
  COUNT(name) AS anzahlbiersorten
FROM biersorte
group by hersteller;

-- Aufgabe 7
SELECT Bsorte
FROM Lieblingsbier
GROUP BY Bsorte
HAVING MIN(Bewertung) = MAX(Bewertung);

-- Aufgabe 8
SELECT x.Name, x.Suppenpreis, y.Durchschnittspreis
FROM Restaurant x
JOIN (
      SELECT Strasse, AVG(Suppenpreis) AS Durchschnittspreis
      FROM Restaurant
      GROUP BY Strasse) AS y
ON x.Strasse = y.Strasse;

-- Aufgabe 9
SELECT max(sortiment.anlager), restaurant.name
FROM sortiment
INNER JOIN restaurant ON restaurant.name = sortiment.rname
group by restaurant.name;

-- Aufgabe 10
SELECT Strasse
FROM Restaurant x
GROUP BY Strasse
HAVING COUNT(*) > (
    SELECT COUNT(*)
    FROM Besucher y
    WHERE y.Strasse = x.Strasse
    GROUP BY Strasse);

-- Aufgabe11
SELECT strasse
FROM besucher
WHERE vorname LIKE '%p%' AND EXISTS (
    SELECT 1
    FROM restaurant
    WHERE besucher.strasse = restaurant.strasse
    AND restaurant.suppenpreis > 3 AND restaurant.suppenpreis < 5);

SELECT DISTINCT x.Strasse
FROM Besucher x, Gast y, Restaurant z
WHERE x.Vorname = y.Bvorname AND x.Name = y.Bname AND
y.Rname = z.Name AND x.Vorname LIKE '%p%' AND
z.Suppenpreis BETWEEN 3 AND 5;

-- Aufgabe 12
select count(bname)
from gast
where rname = 'Löwen';

SELECT COUNT(*) AS Besucher_Restaurant_Löwen
FROM (SELECT DISTINCT Bname, Bvorname
      FROM Gast
      WHERE Rname = 'Löwen') AS x;

drop table besucher, biersorte, gast, lieblingsbier, restaurant, sortiment;

