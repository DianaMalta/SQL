# CASO PRACTICO SQL
## Contexto
El restaurante "Sabores del Mundo", es conocido por su auténtica cocina y su ambiente
acogedor.
Este restaurante lanzó un nuevo menú a principios de año y ha estado recopilando
información detallada sobre las transacciones de los clientes para identificar áreas de
oportunidad y aprovechar al máximo sus datos para optimizar las ventas.
## Objetivo
Identificar cuáles son los productos del menú que han tenido más éxito y cuales son los que
menos han gustado a los clientes.

## RESULTADO DEL ANALISIS*/
/* El tipo de categoria mas vendida fue la comida asiatica, 
una propuesta para el nuevo menu seria, incluir mas platillos de este tipo de CATEGORIA */
### Consulta SQL utilizada
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

### De los 32 platillos del menu actual,
el mas vendido fue Hamburguesa(American) lo pidieron 622 ocasiones
y el menos vendido fue chicken tacos (Mexican) lo pidieron 123 ocasiones*/

### Consulta utilizada
SELECT COUNT(od.item_id) as "el platillo mas pedido",mi.item_name,mi.category,mi.price
FROM menu_items MI
LEFT JOIN order_details OD ON MI.menu_item_id = OD.item_id
GROUP BY od.item_id,mi.item_name,mi.category,mi.price
ORDER BY COUNT(od.item_id) desc

Otro aspecto a considerar es platillo mas redituable es "Korean Beef Bowl" con ventas de 10,554.60
el que menos ingreso genero fue "Chicken Tacos" 1,469.85, recomendaria quitar del menu este platino

### Consulta utilizada
SELECT COUNT(mi.menu_item_id),mi.item_name,SUM(MI.PRICE) as "Ventas",mi.category
FROM menu_items MI
LEFT JOIN order_details OD ON MI.menu_item_id = OD.item_id
GROUP BY mi.menu_item_id,mi.item_name,MI.PRICE,mi.category
ORDER BY 3 desc

 De los 90 dias de ventas en el restauran, el mejor dia fue "2023-02-01", con "Ventas" de 2,396.35  
  este analisis puede apoyar para determinar dias festivos o claves para incluir promociones y generan mas ventas de platillos
  ### Consulta utilizada
SELECT DISTINCT(od.order_date),SUM(MI.PRICE) as "Ventas"
FROM menu_items MI
LEFT JOIN order_details OD ON MI.menu_item_id = OD.item_id
GROUP BY DISTINCT(od.order_date)
ORDER BY 2 desc
  

## Resumen de 5 aspectos a considerar
- De los 32 platillos, solamente dejar los mas redituables y mas pedidos, considerando la categoria mas vendida
- De las 4 categorias, la mas vendida fue la asiatica, esto le sirve a los duaños para poder agregar al nuevo menu mas platillos de esta categoria
- El platillo mas vendido fue Hamburguesa(American) lo pidieron 622 ocasiones
  y el menos vendido fue chicken tacos (Mexican) lo pidieron 123 ocasiones
- De los 32 platillos el mas redituable es "Korean Beef Bowl" con ventas de 10,554.60
  el que menos ingreso genero fue "Chicken Tacos" 1,469.85, recomendaria quitar del menu este platino
- De los 90 dias de ventas en el restauran, el mejor dia fue "2023-02-01", con "Ventas" de 2,396.35  
  este analisis puede apoyar para determinar dias festivos o claves para incluir promociones y generan mas ventas de platillos
  

