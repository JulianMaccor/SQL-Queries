use DHAlmundo;


/*
Codigo de Camada: 0223TDPIMN1C4LAED1022PT (CAMADA 4) 
Julian Maccor
*/

/*CONSIGNAS:
 1- 1. Listar todas las reservas de hoteles realizadas en la ciudad de Nápoles. */

select re.*, ciudad from reservas re
join hotelesxreserva hxr
on hxr.idreserva = re.idreserva
join hoteles ho
on ho.idhotel = hxr.idhotel
where ciudad = 'Napoles';

/*Numero de registros = 6*/

/*2. Listar el número de pago (idpago), el precio, la cantidad de cuotas de todas las
reservas realizadas con tarjeta de crédito.*/

select pa.idpago, precioTotal, cantidadCuotas, mp.nombre from reservas re
join pagos pa
on pa.idpago = re.idpago
join metodospago mp
on mp.idmetodospago = pa.idmetodospago
where mp.nombre = 'Tarjeta de Crédito';

/*Numero de registros = 19*/

/*3. Listar la cantidad de reservas realizadas de acuerdo al método de pago.*/

select mp.nombre, count(re.idreserva) as cantidad_reserva from reservas re
join pagos pa
on pa.idpago = re.idpago
join metodospago mp
on mp.idmetodospago = pa.idmetodospago
group by mp.nombre;

/*Numero de registros = 3*/

/*4. Listar las reservas de los clientes cuyo pago lo hicieron a través de tarjeta de
crédito, se pide mostrar el nombre, apellido, país y el método de pago.*/

select cl.nombres, cl.apellidos, mp.nombre, pa.nombre  from reservas re
join pagos pag
on pag.idpago = re.idpago
join metodospago mp
on mp.idmetodospago = pag.idmetodospago
join clientes cl
on cl.idcliente = re.idcliente
join paises pa
on pa.idpais = cl.idpais
where mp.nombre = 'Tarjeta de Crédito';

/*Numero de registros = 19*/

/*5. Listar la cantidad de reservas de hoteles por país, se necesita mostrar el nombre
del país y la cantidad.*/

select pa.nombre, count(re.idreserva) as cantidad_reservas from reservas re
join hotelesxreserva hxr
on hxr.idreserva = re.idreserva
join hoteles ho
on ho.idhotel = hxr.idhotel
join paises pa 
on pa.idpais = ho.idpais
group by pa.nombre;

/*Numero de registros = 8*/

/*6. Listar el nombre, apellido, número de pasaporte,ciudad y nombre del país de los
clientes de origen Peruano.*/

select cl.nombres, cl.apellidos, cl.numeroPasaporte, cl.ciudad, pa.nombre as pais from reservas re
join clientes cl
on cl.idcliente = re.idcliente
join paises pa
on pa.idpais = cl.idpais
where pa.nombre = 'Peru';

/*Numero de registros = 3*/

/*7. Listar la cantidad de reservas realizadas de acuerdo al cliente y el método de
pago, mostrar el nombre completo del cliente, y el método de pago, ordenar por
apellido.*/

select mp.nombre, count(re.idreserva) as cant_reservas,cl.nombres ,cl.apellidos from reservas re
join pagos pag
on pag.idpago = re.idpago
join metodospago mp
on mp.idmetodospago = pag.idmetodospago
join clientes cl
on cl.idcliente = re.idcliente
group by mp.nombre, cl.nombres, cl.apellidos
order by cl.apellidos;

/*Numero de registros = 51*/

/*8. Mostrar la cantidad de clientes por país, se necesita visualizar el nombre del
país y la cantidad de clientes.*/

select pa.nombre, count(cl.idcliente) from clientes cl
join paises pa
on pa.idpais = cl.idpais
group by pa.nombre;

/*Numero de registros = 11*/     

/*9. Listar todas las reservas de hotel, se pide mostrar el nombre del hotel,dirección,
ciudad, el país, el tipo de pensión y que tengan como tipo de hospedaje 'Media
pensión'.*/


select ho.nombre, ho.direccion, ho.ciudad, pa.nombre, th.nombre from reservas re
join hotelesxreserva hxr
on hxr.idreserva = re.idreserva
join hoteles ho
on ho.idhotel = hxr.idhotel
join paises pa 
on pa.idpais = ho.idpais
join tiposhospedaje th
on th.idtiposhospedaje = hxr.idtiposhospedaje
where th.nombre = 'Media pension';

/*Numero de registros = 22*/


/*10. Mostrar por cada método de pago el monto total obtenido,se pide visualizar el
nombre del método de pago y el total.*/

select mp.nombre, sum(pa.precioTotal) as total from reservas re
join pagos pa
on pa.idpago = re.idpago
join metodospago mp
on mp.idmetodospago = pa.idmetodospago
group by mp.nombre;

/*Numero de registros = 3*/

/*11. Mostrar la suma de los pagos realizados en la sucursal de Mendoza, llamar al
resultado “TOTAL MENDOZA”.*/

select sum(pa.precioTotal) as totalMendoza from reservas re
join pagos pa
on pa.idpago = re.idpago
join metodospago mp
on mp.idmetodospago = pa.idmetodospago
join sucursales su
on su.idsucursal = re.idsucursal
where su.ciudad = 'Mendoza';

/*Numero de registros = 1*/

/*12. Listar todos los clientes que no han realizado reservas.*/

select cl.*, re.idreserva from clientes cl
left join reservas re
on re.idcliente = cl.idcliente
where re.idreserva is null;

/*Numero de registros = 33*/

/*13. Listar todas las reservas de vuelos realizadas donde el origen sea Chile y el
destino Ecuador, mostrar el código de la reserva, número de vuelo, fecha de
partida, fecha de llegada, fecha de la reserva.*/

select re.codigoReserva, v.nrovuelo, v.fechapartida, v.fechallegada, re.fecharegistro, v.origen, v.destino  from reservas re
join vuelosxreserva vxr
on vxr.idreserva = re.idreserva
join vuelos v
on v.idvuelo = vxr.idvuelo
where v.origen = 'Chile' and v.destino = 'Ecuador';

/*Numero de registros = 3*/

/*14. Listar el nombre y cantidad de habitaciones de aquellos hoteles que tengan de
30 a 70 habitaciones pertenecientes al país Argentina.*/

select ho.nombre, ho.cantidadHabitaciones, pa.nombre as pais from hoteles ho 
join paises pa
on pa.idpais = ho.idpais
where ho.cantidadHabitaciones between 30 and 70 and pa.nombre = 'Argentina';

/*Numero de registros = 3*/

/*15. Listar el top 10 de hoteles más utilizados y la cantidad de reservas en las que ha
sido reservado.*/

SELECT b.nombre, count(a.idhotelesxreserva) as cantidad_reserva
from hotelesxreserva a
inner join hoteles b on a.idhotel = b.idhotel
group by b.nombre
order by cantidad_reserva desc
limit 10;

/*Numero de registros = 10*/

/*16. Listar los clientes (nombre y apellido) que pagaron con transferencia bancara o
en efectivo, esta lista deberá estar ordenada por apellidos de manera
ascendente.*/

select cl.nombres, cl.apellidos, mp.nombre  from reservas re
join pagos pag
on pag.idpago = re.idpago
join metodospago mp
on mp.idmetodospago = pag.idmetodospago
join clientes cl
on cl.idcliente = re.idcliente
where mp.nombre = 'Transferencia Bancaria' or mp.nombre = 'Efectivo'
order by cl.apellidos asc;

/*Numero de registros = 43*/

/*17. Listar la cantidad de reservas que se realizaron para los vuelos que el origen ha
sido de Argentina o Colombia, cuyo horario de partida sean las 18:11 hs. Mostrar
la cantidad de vuelos y país de origen.*/

select re.*, v.origen, v.fechapartida from reservas re
join vuelosxreserva vxr
on vxr.idreserva = re.idreserva
join vuelos v
on v.idvuelo = vxr.idvuelo
where v.origen in ('Argentina','Colombia') and v.fechapartida like '%18:11%';

/*Numero de registros = 6*/

/*18. Mostrar los totales de ventas de sucursales por países y ordenarlas de mayor a
menor.*/

select pai.nombre, sum(pa.precioTotal) as total from reservas re
join pagos pa
on pa.idpago = re.idpago
join metodospago mp
on mp.idmetodospago = pa.idmetodospago
join sucursales su
on su.idsucursal = re.idsucursal
join paises pai
on pai.idpais = su.idpais
group by pai.nombre
order by total;

/*Numero de registros = 2*/

/*19. Mostrar los países que no tienen clientes asignados ordenados por los que
empiezan por Z primero.*/

select pa.idpais, pa.nombre, cl.idcliente from clientes cl
right join paises pa
on pa.idpais = cl.idpais
where cl.idcliente is null
order by pa.nombre desc;

/*Numero de registros = 19*/


/*20. Generar un listado con los hoteles que tuvieron más de 2 reservas realizadas.
Mostrar el nombre del hotel y la cantidad.*/

SELECT b.nombre, count(a.idhotelesxreserva) as cantidad_reserva
from hotelesxreserva a
inner join hoteles b on a.idhotel = b.idhotel
group by b.nombre
having count(a.idhotelesxreserva) > 2

/*Numero de registros = 4*/






