select bsorte, avg(bewertung)
from lieblingsbier
group by bsorte;

select rname, sum(anlager)
from sortiment
group by rname;

select *
from besucher
where strasse like '%strasse';


