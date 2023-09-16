use sakila;

WITH CONSULTA_PRINCIAPL AS (
    SELECT 
    ST.store_id,
    CONCAT( AD.address, ' , ',CI.city) AS STORE,
    CI.city,
    CU.country,
    CONCAT(SF.first_name, ' ', SF.last_name) AS STAFF,
    PY.amount,
    YEAR(PY.payment_date) AS AnnO,
    month(PY.payment_date) AS MES,
    dayofmonth(PY.payment_date) AS DIA
    FROM store AS ST
    INNER JOIN address AS AD
        ON ST.address_id = AD.address_id
    INNER JOIN city AS CI
        ON AD.city_id = CI.city_id
    INNER JOIN country AS CU
        ON CI.country_id = CU.country_id    
    INNER JOIN staff AS SF
        ON ST.STORE_ID = SF.STORE_ID
    INNER JOIN payment AS PY
        ON SF.STAFF_ID = PY.STAFF_ID
)
/*, segunda_consulta as (
    select
        STORE,
        AnnO,
        MES,
        sum(amount) as amount
    from CONSULTA_PRINCIAPL
    GROUP by 
        STORE,AnnO,MES
)*/
SELECT * FROM CONSULTA_PRINCIAPL     
LIMIT 5;