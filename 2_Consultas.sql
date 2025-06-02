/*SQL: Fundamentos*/

/*Ejercicio 1
Obtener la lista de todos los géneros ( Genre ) disponibles en la base de datos,
ordenados alfabéticamente por el nombre del género.*/

SELECT *
FROM "Genre" AS g 
ORDER BY "Name" ASC;


/*Ejercicio 2
Listar todos los álbumes ( Album ) y mostrar sólo el título del álbum ( Title ) y el
identificador del artista ( ArtistId ).*/

SELECT "Title","ArtistId"
FROM "Album" AS a;


/*Ejercicio 3
Contar cuántos empleados ( Employee ) hay en la base de datos.*/

SELECT COUNT("EmployeeId") 
FROM "Employee" AS e; 


/*SQL: Consultas Básicas*/

/*Ejercicio 4
Obtener el nombre y el apellido de todos los empleados ( Employee ) que tengan
el título de "Sales Support Agent".*/

SELECT "FirstName","LastName" 
FROM "Employee" AS e 
WHERE "Title" = 'Sales Support Agent';


/*Ejercicio 5
Mostrar una lista de todas las pistas ( Track ) cuyo nombre ( Name ) empiece con
la letra "A".*/

SELECT "Name"
FROM "Track" AS t
WHERE "Name" LIKE 'A%';


/*Ejercicio 6
Obtener los nombres de todos los clientes ( Customer ) que tengan una dirección
de correo electrónico ( Email ) que contenga la palabra "yahoo".*/

SELECT "FirstName"
FROM "Customer" AS c 
WHERE "Email" LIKE '%yahoo%';


/*Ejercicio 7
Listar todas las pistas ( Track ) que tienen una duración ( Milliseconds ) superior a
300,000 milisegundos.*/

SELECT "Name"
FROM "Track" AS t
WHERE "Milliseconds" > 300.000;


/*SQL: Relaciones entre Tablas*/

/*Ejercicio 8
Obtener los nombres de todos los álbumes ( Album ) junto con el nombre de su
artista correspondiente ( Artist ).*/

SELECT a."Title",a2."Name"
FROM "Album" AS a 
LEFT JOIN "Artist" AS a2 ON a."AlbumId" = a2."ArtistId"; 


/*Ejercicio 9
Listar los nombres de todos los empleados ( Employee ) junto con el nombre de su
supervisor directo ( ReportsTo ).*/

SELECT  e."EmployeeId" AS "ID_Empleado",
        e."FirstName" AS "Nombre_empleado",
        s."FirstName" AS "Supervisor"
FROM "Employee" AS e 
LEFT JOIN "Employee" AS s ON e."ReportsTo" = s."EmployeeId"
ORDER BY e."EmployeeId";


/*Ejercicio 10
Mostrar una lista con el nombre de cada cliente ( Customer ) y el país donde
realizó su compra. (Relacionar Customer con Invoice ).*/

SELECT DISTINCT c."FirstName" || ' ' || c."LastName" AS "Cliente",
       i."BillingCountry" AS "País de Compra"
FROM "Customer" AS c 
LEFT JOIN "Invoice" AS i ON i."CustomerId" = c."CustomerId"
ORDER BY "Cliente";


/*Ejercicio 11
Obtener una lista de los nombres de los clientes ( Customer ) que compraron
pistas de género "Rock".*/

SELECT DISTINCT c."FirstName" || ' ' || c."LastName" AS "Cliente"
FROM "Customer" AS c 
INNER JOIN "Invoice" AS i ON c."CustomerId"= i."CustomerId" 
INNER JOIN "InvoiceLine" AS il ON i."InvoiceId"= il."InvoiceId"
INNER JOIN "Track" AS t ON il."TrackId"= t."TrackId"
INNER JOIN "Genre" AS g ON t."GenreId"= g."GenreId" 
WHERE g."Name" = 'Rock'
ORDER BY "Cliente";


/*Ejercicio 12
Listar los títulos de todos los álbumes ( Album ) comprados por cada cliente
( Customer ).*/

SELECT DISTINCT c."FirstName" || ' ' || c."LastName" AS "Cliente",
                a."Title" AS "Album"
FROM "Customer" AS c 
INNER JOIN "Invoice" AS i ON c."CustomerId"= i."CustomerId" 
INNER JOIN "InvoiceLine" AS il ON i."InvoiceId"= il."InvoiceId"
INNER JOIN "Track" AS t ON il."TrackId"= t."TrackId"
INNER JOIN "Album" AS a ON t."AlbumId"= a."AlbumId" 
ORDER BY "Album";


/*SQL: Subconsultas*/

/*Ejercicio 13
Encontrar el precio más alto ( UnitPrice ) de todas las pistas ( Track ) y listar los
nombres de las pistas con ese precio.*/

SELECT t."Name" AS "Nombre de la pista",
        t."UnitPrice" AS "Precio"
FROM "Track" AS t 
WHERE t."UnitPrice" = (
            SELECT MAX("UnitPrice")
            FROM "Track"
            )
ORDER BY "Precio"


/*Ejercicio 14
Obtener los nombres de los artistas ( Artist ) que no tienen ningún álbum
registrado.*/

SELECT a."Name" AS "Artista"
FROM "Artist" AS a
WHERE NOT EXISTS (
                    SELECT 1
                    FROM "Album" AS al
                    WHERE al."ArtistId" = a."ArtistId");

--- Otra forma---Sin subconsulta

SELECT a."Name" AS "Artista"
FROM "Artist" AS a
LEFT JOIN "Album" AS al ON a."ArtistId" = al."ArtistId"
WHERE al."ArtistId" IS NULL;


/*Ejercicio 15
Listar el título de los álbumes ( Album ) que tienen pistas con duración superior al
promedio de duración de todas las pistas.*/

SELECT DISTINCT a."Title" AS "Album"
FROM "Track" AS t
INNER JOIN "Album" AS a ON t."AlbumId" = a."AlbumId" 
WHERE t."Milliseconds" > (
                    SELECT AVG("Milliseconds")
                    FROM "Track") 
ORDER BY "Album";
                    

/*SQL: Vistas, CTEs y Tablas Temporales*/

/*Ejercicio 16
Crear una vista llamada HighCostTracks que incluya todas las pistas ( Track ) con
un precio superior a 0.99.*/

CREATE VIEW "HighCostTracks" AS 
SELECT t."UnitPrice" AS "Precio"
FROM "Track" AS t 
WHERE "UnitPrice" > 0.99;

SELECT *
FROM "HighCostTracks"; 


/*Ejercicio 17
Crear una CTE que calcule el promedio de duración de las pistas ( Track ) por
género ( Genre ) y luego listar todos los géneros con una duración promedio
superior a 300,000 milisegundos.*/

WITH promedio_pistas_CTE AS ( 
                    SELECT t."GenreId",
                            ROUND(AVG(t."Milliseconds")::NUMERIC,1) AS "DuracionPromedio"
                    FROM "Track" AS t 
                    GROUP BY "GenreId")
                    

SELECT  g."Name" AS "Género",
        pp."DuracionPromedio"
FROM promedio_pistas_CTE AS pp 
INNER JOIN "Genre" AS g ON pp."GenreId" = g."GenreId"
WHERE pp."DuracionPromedio"> 300000;


/*Ejercicio 18
Crear una tabla temporal para almacenar los títulos de los álbumes ( Album )
comprados por el cliente cuyo CustomerId sea 5.*/

CREATE TEMP TABLE "compra_cliente_Id5" AS
SELECT
    c."CustomerId",
    c."FirstName" || ' ' || c."LastName" AS "Nombre_Cliente",
    a."Title" AS "Titulo_album"
FROM "Customer" AS c 
INNER JOIN "Invoice" AS i ON c."CustomerId"= i."CustomerId" 
INNER JOIN "InvoiceLine" AS il ON i."InvoiceId"= il."InvoiceId"
INNER JOIN "Track" AS t ON il."TrackId"= t."TrackId"
INNER JOIN "Album" AS a ON t."AlbumId"= a."AlbumId" 
WHERE c."CustomerId" =  5
ORDER BY a."Title"; 

SELECT * FROM "compra_cliente_Id5";


/*Ejercicios Avanzados Combinados*/

/*Ejercicio 19
Usando subconsultas, listar los nombres de los clientes ( Customer ) que hayan
comprado al menos una pista de género "Jazz".*/

SELECT c."FirstName" || ' ' || c."LastName" AS "Nombre_Cliente"
FROM "Customer" AS c 
WHERE c."CustomerId" IN
                    (SELECT c2."CustomerId"
                    FROM "Customer" AS c2 
                    INNER JOIN "Invoice" AS i ON c2."CustomerId"= i."CustomerId" 
                    INNER JOIN "InvoiceLine" AS il ON i."InvoiceId"= il."InvoiceId"
                    INNER JOIN "Track" AS t ON il."TrackId"= t."TrackId"
                    INNER JOIN "Genre" AS g ON t."GenreId"= g."GenreId"
                    WHERE g."Name" = 'Jazz');



/*Ejercicio 20
Utilizando una CTE, obtener el total gastado por cada cliente ( Customer ) y luego
listar a aquellos que han gastado más de 20 en total.*/

WITH total_gastado_CTE AS ( 
                    SELECT 
                    c."CustomerId",
                    c."FirstName" || ' ' || c."LastName" AS "Nombre_Cliente",
                    SUM(i."Total") AS "Total_gastado"
                    FROM "Customer" AS c 
                    INNER JOIN "Invoice" AS i ON c."CustomerId"= i."CustomerId"
                    GROUP BY c."CustomerId", c."FirstName", c."LastName"
                    )                   

SELECT  tg."Nombre_Cliente",
        tg."Total_gastado"
FROM total_gastado_CTE AS tg 
WHERE tg."Total_gastado"> 20;



