select * from menu_items
/*1.- Realizar consultas para contestar las siguientes preguntas:
-- Encontrar el número de artículos en el menú.*/
SELECT COUNT(item_name) 
FROM menu_items
--Resultado 32 platillos

--● ¿Cuál es el artículo menos caro y el más caro en el menú?
SELECT item_name,price,category
FROM menu_items 
ORDER BY price asc
limit 1;
--resutado
--"Edamame" 5.00

--mas caro
SELECT item_name,price,category
FROM menu_items 
ORDER BY price desc
limit 1;
--resultado
--"Shrimp Scampi" 19.92

-- ¿Cuántos platos americanos hay en el menú?
SELECT COUNT(item_name) as "Total platillos comida americana"
FROM menu_items
WHERE category='American'
--resultado 6 

--● ¿Cuál es el precio promedio de los platos?
SELECT ROUND(AVG(price),2) as "Precio promedio de los platillos"
FROM menu_items
--resultado redondeado a 2 decimales 13.29
/*
c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
*/
select * from menu_items;
SELECT * FROM order_details;
1.- Realizar consultas para contestar las siguientes preguntas:*/

--● ¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT(DISTINCT(order_id)) FROM order_details;
--resultado 5370 pedidos unicos

--● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT order_id AS "#Orden",COUNT(item_id) as "totalarticulos"
FROM order_details
GROUP BY order_id
ORDER BY totalarticulos desc
LIMIT 5;
--resultado los numeros de ordenes con mas articulos son: 440,2675,3473,4305,443, con 14 articulos

/*● ¿Cuándo se realizó el primer pedido y el último pedido?*/
SELECT order_id,order_date, order_time
FROM order_details
GROUP BY order_id,order_date, order_time
ORDER BY order_id ASC
LIMIT 1;
--resultado, el primer pedido fue 5370 "2023-01-01" "11:38:36"

SELECT order_id,order_date, order_time
FROM order_details
GROUP BY order_id,order_date, order_time
ORDER BY order_id DESC
LIMIT 1;
--resultado, el ultimo pedido fue 5370 "2023-03-31" "22:15:48"

/*● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?*/
SELECT COUNT(DISTINCT(order_id))as "Total de pedidos"
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05'
--resultado 308 pedidos

/*d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items).*/
SELECT * 
FROM  order_details OD
LEFT JOIN menu_items MI ON OD.item_id = MI.menu_item_id

/*e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
utiliza los resultados obtenidos para llegar a estas conclusiones.*/
/*RESULTADO DEL ANALISIS*/
/* El tipo de categoria mas vendida fue la comida asiatica, 
una propuesta para el nuevo menu seria, incluir mas platillos de este tipo de CATEGORIA */

SELECT COUNT(MI.category) as "veces_pedida",mi.category
FROM menu_items MI
LEFT JOIN order_details OD ON MI.menu_item_id = OD.item_id
GROUP BY mi.category
ORDER BY COUNT(MI.category) desc
/*Resultado VECES SOLICITADA por categoria
3470	"Asian"  VECES SOLICITADA
2948	"Italian"
2945	"Mexican"
2734	"American" */

/*-De los 32 platillos del menu actual,
el mas vendido fue Hamburguesa(American) lo pidieron 622 ocasiones
y el menos vendido fue chicken tacos (Mexican) lo pidieron 123 ocasiones*/
SELECT COUNT(od.item_id) as "el platillo mas pedido",mi.item_name,mi.category,mi.price
FROM menu_items MI
LEFT JOIN order_details OD ON MI.menu_item_id = OD.item_id
GROUP BY od.item_id,mi.item_name,mi.category,mi.price
ORDER BY COUNT(od.item_id) desc
/**
Platillo mas redituable es "Korean Beef Bowl" con ventas de 10,554.60
el que menos ingreso genero fue "Chicken Tacos" 1,469.85, recomendaria quitar del menu este platino
*/
SELECT COUNT(mi.menu_item_id),mi.item_name,SUM(MI.PRICE) as "Ventas",mi.category
FROM menu_items MI
LEFT JOIN order_details OD ON MI.menu_item_id = OD.item_id
GROUP BY mi.menu_item_id,mi.item_name,MI.PRICE,mi.category
ORDER BY 3 desc

/*De los 90 dias de ventas en el restauran, el mejor dia fue "2023-02-01", con "Ventas" de 2,396.35  
este analisis puede apoyar para determinar dias festivos oc claves para incluir promociones y generan mas ventas de platillos*/
SELECT DISTINCT(od.order_date),SUM(MI.PRICE) as "Ventas"
FROM menu_items MI
LEFT JOIN order_details OD ON MI.menu_item_id = OD.item_id
GROUP BY DISTINCT(od.order_date)
ORDER BY 2 desc
/****************************************/

