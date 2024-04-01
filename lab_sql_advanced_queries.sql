Use sakila ;

#List each pair of actors that have worked together.
select * from film_actor;

select * from film_actor f1
join film_actor f2
on f1.film_id = f2.film_id
and f1.actor_id <> f2.actor_id;

SELECT a1.first_name AS actor1_name, a1.last_name AS actor1_last_name,
       a2.first_name AS actor2_name, a2.last_name AS actor2_last_name, fa1.film_id
FROM actor a1
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN actor a2 ON a2.actor_id = fa2.actor_id
WHERE a1.actor_id < a2.actor_id;


#For each film, list actor that has acted in more films.
select * from actor ;
select * from film_actor;
select * from film ;

with  film_per_actor as 
(select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as number_film
from actor a 
join film_actor fa on fa.actor_id = a.actor_id
group by actor_id, a.first_name, a.last_name
order by number_film),

rank_1 as 
(select f.title, fpa.first_name, fpa.last_name, fpa.number_film, rank() over (partition by f.title order by number_film desc) as rank_actor
from film f 
join film_actor fa on fa.film_id = f.film_id
join film_per_actor fpa on fpa.actor_id = fa.actor_id
order by f.title)

select title, first_name, last_name, number_film from rank_1  where rank_actor = 1;









