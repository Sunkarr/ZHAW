-- Aufgabe 1
select avg(anlager) as Durchschnittslagerbestand
from sortiment;

SELECT AVG(AnLager) AS Durchschnittslagerbestand
FROM Sortiment;

-- Aufgabe 2
select Name,Vorname,Strasse
from besucher
where lower(strasse) like '%bach%';

SELECT Name,Vorname,Strasse
FROM Besucher
WHERE Strasse LIKE '%bach%' OR Strasse LIKE '%Bach%';

-- Aufgabe 3
select strasse
from restaurant
group by strasse
having count(strasse) >= 3;

SELECT Strasse
FROM Restaurant
GROUP BY Strasse
HAVING COUNT(*) >= 3;

-- Aufgabe 4
select *
from restaurant, besucher;

select *
from restaurant
cross join besucher;

-- Aufgabe 5
SELECT Name,Vorname,SUM(COALESCE(Frequenz,0)) AS AnzahlBesuche
FROM Besucher AS b
LEFT OUTER JOIN Gast AS g
ON b.Name = g.Bname AND b.Vorname = g.Bvorname
GROUP BY b.Name,b.Vorname
ORDER BY AnzahlBesuche DESC;

SELECT Bname, Bvorname, SUM(Frequenz) AS AnzahlBesuche
FROM Gast
GROUP BY Bname, Bvorname

UNION

SELECT Name, Vorname, 0 AS AnzahlBesuche
FROM Besucher AS x
WHERE NOT EXISTS (
  SELECT 1
  FROM   Gast AS y
  WHERE  y.Bname = x.Name AND y.Bvorname = x.Vorname)
ORDER BY AnzahlBesuche DESC;

-- Aufgabe 6
select hersteller, count(name) as AnzahlBiere, count(grundstoff) as AnzahlGrundstoffe
from biersorte
group by hersteller
order by hersteller;

SELECT Hersteller, COUNT(*) AS AnzahlBiere,
COUNT(DISTINCT Grundstoff) AS AnzahlGrundstoffe
FROM Biersorte
GROUP BY Hersteller
order by hersteller;

-- Aufgabe 7
select bsorte
from lieblingsbier
group by bsorte
having min(bewertung) = max(bewertung);

SELECT Bsorte
FROM Lieblingsbier
GROUP BY Bsorte
HAVING MIN(Bewertung) = MAX(Bewertung);

-- Aufgabe 8
with avgsp as
    (select strasse, avg(suppenpreis)
    from restaurant
    group by strasse)
select name, suppenpreis, avgsp.avg
from restaurant, avgsp
where restaurant.strasse = avgsp.strasse;

SELECT x.Name, x.Suppenpreis, y.Durchschnittspreis
FROM Restaurant x
JOIN (
      SELECT Strasse, AVG(Suppenpreis) AS Durchschnittspreis
      FROM Restaurant
      GROUP BY Strasse) AS y
ON x.Strasse = y.Strasse;

-- Aufgabe 9
select rname, bsorte
from sortiment x
where anlager =
      (select max(anlager)
       from sortiment y
       where x.rname = y.rname
       group by rname);

-- Aufgabe 10
with
res as
    (select strasse, count(strasse) as Anzahl_Restaurants
    from restaurant
    group by strasse),
bes as
    (select strasse, count(strasse) as Anzahl_Besucher
    from besucher
    group by strasse)
select res.strasse, Anzahl_Restaurants, Anzahl_Besucher
from res, bes
where res.strasse = bes.strasse and Anzahl_Restaurants > Anzahl_Besucher;

SELECT Strasse
FROM Restaurant x
GROUP BY Strasse
HAVING COUNT(*) > (
    SELECT COUNT(*)
    FROM Besucher y
    WHERE y.Strasse = x.Strasse
    GROUP BY Strasse);

-- Aufgabe 11
select distinct b.strasse
from besucher b, gast g, restaurant r
where b.name = g.bname
  and b.vorname = g.bvorname
  and r.name = g.rname
  and lower(b.vorname) like '%p%'
  and r.suppenpreis < 5
  and r.suppenpreis > 3;

SELECT DISTINCT x.Strasse
FROM Besucher x, Gast y, Restaurant z
WHERE x.Vorname = y.Bvorname AND x.Name = y.Bname AND
y.Rname = z.Name AND x.Vorname LIKE '%p%' AND
z.Suppenpreis BETWEEN 3 AND 5;

-- Aufgabe 12
select rname, count(rname)
from gast
where rname = 'Löwen'
group by rname;

SELECT COUNT(*) AS Besucher_Restaurant_Löwen
FROM (SELECT DISTINCT Bname, Bvorname
      FROM Gast
      WHERE Rname = 'Löwen') AS x;

