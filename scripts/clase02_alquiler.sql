/* 
--CLIENTES
    SELECT
        first_name
        ,last_name
        ,address
        ,postal_code
        ,city
        ,country
        ,phone
    FROM customer
        INNER JOIN address USING(address_id)
        INNER JOIN city USING(city_id)
        INNER JOIN country USING(country_id)
    ORDER BY first_name
    LIMIT 10;

--PELICULAS
    SELECT
        film_id
        ,title
        ,category.name AS category
    FROM inventory
        LEFT JOIN film USING(film_id)
        LEFT JOIN film_category USING(film_id)
        LEFT JOIN category USING(category_id)
    LIMIT 10; */

use sakila;
with consulta_princiapl as (
    SELECT
        film_id
        ,title
        ,category.name AS category,
        year(rental_date) AS rental_year,
        month(rental_date) AS rental_month,
        dayofmonth(rental_date) as rental_day
    FROM inventory
        LEFT JOIN rental USING(inventory_id)
        LEFT JOIN film USING(film_id)
        LEFT JOIN film_category USING(film_id)
        LEFT JOIN category USING(category_id)
), consulta_mes_ano as (
    SELECT 
    title
    ,rental_year
    ,rental_month
    ,COUNT(*) AS cantidad
    FROM consulta_princiapl
    GROUP BY title,rental_year,rental_month
), datos_mes as (
    select 
    title
    ,sum(case when rental_year = 2005 and rental_month= 5  then cantidad else 0 end ) as may2005
    ,sum(case when rental_year = 2005 and rental_month= 6  then cantidad else 0 end ) as jun2005
    from consulta_mes_ano
    group by title

),diferencias as (
    select 
    title
    ,may2005
    ,jun2005
    ,(may2005 - jun2005 ) as diferencia
    ,(case when may2005 <> 0 then
        ROUND((((jun2005 - may2005)/may2005)* 100),2)
    else
        0
    end) as porcenjmay2005
    from datos_mes
)
SELECT * FROM diferencias
LIMIT 10;



/* --ALQUILER DE PELICULAS
    SELECT
        film_id
        ,title
        ,category.name AS category,
        COUNT(rental_id) AS times_rented
    FROM inventory
        LEFT JOIN rental USING(inventory_id)
        LEFT JOIN film USING(film_id)
        LEFT JOIN film_category USING(film_id)
        LEFT JOIN category USING(category_id)
    GROUP BY film_id, title, category
    LIMIT 10; */
/* 

--VENTAS
    SELECT
        CONCAT(city, ',', country) AS store,
        CONCAT(staff.first_name,' ', staff.last_name) AS manager,
        CONCAT(customer.first_name,' ', customer.last_name) AS customer,
        payment_date,
        amount
    FROM country
        INNER JOIN city USING(country_id)
        INNER JOIN address USING(city_id)
        INNER JOIN store USING(address_id)
        INNER JOIN staff USING(store_id)
        INNER JOIN payment USING(staff_id)
        INNER JOIN customer USING(customer_id)
    LIMIT 10;  */

