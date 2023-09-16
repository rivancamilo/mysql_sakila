use sakila;


SELECT
cu.customer_id,
cu.first_name,

FROM customer as cu
INNER JOIN address as a USING(address_id)
INNER JOIN city as ci USING(city_id)
limit 5;
