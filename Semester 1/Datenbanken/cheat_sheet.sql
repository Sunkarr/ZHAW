constraint preise.einkaufspreis
check einkaufspreis < verkaufspreis

----------------

select *
from mitarbeiter
where abteilung = 'HR'

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