-- Aufgabe 1
select avg(anlager)
from sortiment;

-- Aufgabe 2
select name, vorname, strasse
from besucher
where lower(strasse) like '%bach%';

-- Aufgabe 3
select strasse, count(strasse)
from restaurant
group by strasse
having count(strasse) >= 3;

-- Aufgabe 4
select *
from restaurant, besucher;

select *
from restaurant
cross join besucher;

-- Aufgabe 5
select name, vorname, sum(frequenz) as anzbes
from besucher, gast
where vorname = bvorname and name = bname
group by name, vorname
order by anzbes;

SELECT Bname, Bvorname, SUM(Frequenz) AS AnzahlBesuche
FROM Gast
GROUP BY Bname, Bvorname;

-- Aufgabe 6
select hersteller, count(distinct grundstoff) as anzgrundst, count(name) as anzbiere
from biersorte
group by hersteller;

 SELECT Hersteller, COUNT(*) AS AnzahlBiere,
COUNT(DISTINCT Grundstoff) AS AnzahlGrundstoffe
FROM Biersorte
GROUP BY Hersteller;

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
with avgsupstr as (
    select strasse, avg(suppenpreis) as avg
    from restaurant
    group by strasse)
select name, restaurant.strasse, suppenpreis, avgsupstr.avg
from restaurant, avgsupstr
where restaurant.strasse = avgsupstr.strasse;

SELECT x.Name, x.Suppenpreis, y.Durchschnittspreis
FROM Restaurant x
JOIN (
      SELECT Strasse, AVG(Suppenpreis) AS Durchschnittspreis
      FROM Restaurant
      GROUP BY Strasse) AS y
ON x.Strasse = y.Strasse;

-- Aufgabe 9
with max as (
    select rname, max(anlager) as maxlag
    from sortiment
    group by rname)
select distinct s.rname, bsorte
from sortiment s, max
where s.anlager = max.maxlag
order by rname;

SELECT Rname, Bsorte
FROM Sortiment x
WHERE AnLager = (
  SELECT MAX(AnLager)
  FROM Sortiment y
  WHERE y.Rname = x.Rname
  GROUP BY Rname)
order by rname;

-- Aufgabe 10
with resstr as (
    select strasse, count(strasse) as cnt
    from restaurant
    group by strasse),
    besstr as (
    select strasse, count(strasse) as cnt
    from besucher
    group by strasse)
select *
from resstr, besstr
where resstr.strasse = besstr.strasse and resstr.cnt > besstr.cnt;

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
where b.vorname = g.bvorname and
      b.name = g.bname and
      g.rname = r.name and
      b.vorname like '%p%' and
      suppenpreis between 3 and 5;

SELECT distinct x.strasse
FROM Besucher x, Gast y, Restaurant z
WHERE x.Vorname = y.Bvorname AND x.Name = y.Bname AND
y.Rname = z.Name AND x.Vorname LIKE '%p%' AND
z.Suppenpreis BETWEEN 3 AND 5;

-- Aufgabe 12
with beslöw as (
    select distinct *
    from gast
    where rname = 'Löwen')
select count(*)
from beslöw;

SELECT COUNT(*) AS Besucher_Restaurant_Löwen
FROM (SELECT DISTINCT Bname, Bvorname
      FROM Gast
      WHERE Rname = 'Löwen') AS x;




