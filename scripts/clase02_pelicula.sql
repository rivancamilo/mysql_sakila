use sakila;

with consulta_principal as(
    SELECT
        film_id
        ,title
        ,category.name AS category
        ,concat(first_name, ' ', last_name) as customer
        ,year(rental_date) AS rental_year
        ,month(rental_date) AS rental_month
        ,dayofmonth(rental_date) as rental_day
    FROM inventory
        LEFT JOIN rental USING(inventory_id)
        LEFT JOIN film USING(film_id)
        LEFT JOIN film_category USING(film_id)
        LEFT JOIN category USING(category_id)
        LEFT JOIN customer using (customer_id)
),consulta_anno_mes as (
    select
    customer,
    rental_year,
    rental_month,
    count(*) as cantidad
    from consulta_principal
    group by customer,rental_year,rental_month
), datos_mes as (
    select 
    customer
    ,sum(case when rental_year = 2005 and rental_month= 5  then cantidad else 0 end ) as may2005
    ,sum(case when rental_year = 2005 and rental_month= 6  then cantidad else 0 end ) as jun2005
    from consulta_anno_mes
    group by customer

),diferencias as (
    select 
    customer
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
LIMIT 10; p